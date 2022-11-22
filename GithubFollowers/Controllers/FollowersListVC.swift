//
//  FollowersListVC.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 15.11.2022.
//

import UIKit

class FollowersListVC: UIViewController {
    enum Section {
        case main
    }
    var collectionView: UICollectionView!
    //var searchController: UISearchController!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var name: String!
    var followers = [Follower]()
    var filteredFollowers = [Follower]()
    
    var currentPage = 1
    var hasMoreFollowers = true
    var canLoadMoreFollowers = true
    var isSearching = false
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
        title = name
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
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
        view.addSubview(collectionView)
        collectionView.register(GFFollowerCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func getFollowers(page: Int) {
        presentLoadingScreen()
        NetworkManager.shared.getFollowers(username: name, page: page) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingScreen()
            switch result {
            case .success(let newFollowers):
                if newFollowers.count <= 0{
                    print("no followers")
                    self.showEmptyStateView()
                }
                if newFollowers.count < 100 {
                    print("no more followers")
                    self.hasMoreFollowers = false
                }
                
                self.followers.append(contentsOf: newFollowers)
                self.updateData(on: self.followers)
            case .failure(let error):
                self.presentAlert(title: "An error occyred", message: error.rawValue, buttonTitle: "Okay")
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
        
        if height + offset > contentHeight, hasMoreFollowers && canLoadMoreFollowers {
            print(canLoadMoreFollowers)
            currentPage += 1
            print("get \(currentPage)")
            getFollowers(page: currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentFollowers = isSearching ? filteredFollowers : followers
        let vc = UserInfoVC()
        vc.username = currentFollowers[indexPath.row].login
        let navControlller = UINavigationController(rootViewController: vc)
        let appereance = UINavigationBarAppearance()
        appereance.configureWithDefaultBackground()
        navControlller.navigationBar.standardAppearance = appereance
        navControlller.navigationBar.scrollEdgeAppearance = appereance
        present(navControlller, animated: true)
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
        canLoadMoreFollowers = false
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
}
