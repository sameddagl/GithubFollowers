//
//  FollowersListVC.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 15.11.2022.
//

import UIKit

protocol FollowersListVCDelegate: AnyObject {
    func didRequestFollowers(with username: String)
}

class FollowersListVC: UIViewController {
    enum Section {
        case main
    }
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var username: String!
    var followers = [Follower]()
    var filteredFollowers = [Follower]()
    
    var currentPage = 1
    var hasMoreFollowers = true
    var canLoadMoreFollowers = true
    var isSearching = false
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavController()
        configureCollectionView()
        configureSearchController()
        getFollowers(page: currentPage)
        configureDataSource()
    }
    
    private func configureNavController() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let favoritesButton = UIBarButtonItem(image: UIImage(systemName: SFSymbols.bookmark), style: .done, target: self, action: #selector(saveTapped))
        let getInfoButton = UIBarButtonItem(image: UIImage(systemName: SFSymbols.info), style: .done, target: self, action: #selector(getUserInfoTapped))
        
        navigationItem.rightBarButtonItems = [getInfoButton, favoritesButton]
    }
    
    @objc func saveTapped() {
        presentLoadingScreen()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingScreen()
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarURL: user.avatarURL)
                
                PersistanceManager.shared.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    if let error = error {
                        if error == .alreadyInFavorites {
                            self.presentAlert(title: "Unable to favorite", message: "You have already favorited this user.", buttonTitle: "Okay")
                        }
                        else {
                            self.presentAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Okay")
                        }
                    }
                    else {
                        self.presentAlert(title: "Success!", message: "You have sucessfully favorited this user.", buttonTitle: "Okay")
                    }
                }
            case .failure(let error):
                self.presentAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Okay")
            }
        }
    }
    
    @objc func getUserInfoTapped() {
        getUsersInfo(username: self.username, isTheUserItself: true)
    }
    
    func getUsersInfo(username: String, isTheUserItself: Bool) {
        let vc = UserInfoVC()
        vc.delegate = self
        vc.username = username
        vc.isTheUserItself = isTheUserItself
        let navControlller = UINavigationController(rootViewController: vc)
        let appereance = UINavigationBarAppearance()
        appereance.configureWithDefaultBackground()
        navControlller.navigationBar.standardAppearance = appereance
        navControlller.navigationBar.scrollEdgeAppearance = appereance
        present(navControlller, animated: true)
    }
    
    private func configureSearchController() {
        let searchController = UISearchController(nibName: nil, bundle: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a user"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(view: view))
        collectionView.delegate = self
        collectionView.scrollsToTop = true
        view.addSubview(collectionView)
        collectionView.register(GFFollowerCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func getFollowers(page: Int) {
        presentLoadingScreen()
        NetworkManager.shared.getFollowers(username: self.username, page: page) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingScreen()
            switch result {
            case .success(let newFollowers):
                if newFollowers.count <= 0{
                    print("no followers")
                    self.showEmptyStateView(message: "The user has no followers.\n Go follow him.")
                }
                if newFollowers.count < 100 {
                    print("no more followers")
                    self.hasMoreFollowers = false
                }
                
                self.followers.append(contentsOf: newFollowers)
                self.updateData(on: self.followers)
            case .failure(let error):
                self.presentAlert(title: "An error occured", message: error.rawValue, buttonTitle: "Okay")
            }
        }
    }
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GFFollowerCell
            cell.set(follower)
            return cell
        })
    }
    private func updateData(on newFollowers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(newFollowers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot)
        }
    }
}

extension FollowersListVC: UICollectionViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = scrollView.frame.height
        let contentHeight = scrollView.contentSize.height
        let offset = scrollView.contentOffset.y
        
        if height + offset > contentHeight, hasMoreFollowers {
            currentPage += 1
            print("get \(currentPage)")
            getFollowers(page: currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentFollowers = isSearching ? filteredFollowers : followers
        getUsersInfo(username: currentFollowers[indexPath.row].login, isTheUserItself: false)
    }
}

extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isSearching = false
            filteredFollowers.removeAll()
            updateData(on: followers)
            return
        }
        
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
}

extension FollowersListVC: FollowersListVCDelegate {
    func didRequestFollowers(with username: String) {
        self.username = username
        title = username
        currentPage = 1
        followers.removeAll()
        getFollowers(page: currentPage)
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)

    }
 
}
