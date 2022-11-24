//
//  FavoritesListVC.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 15.11.2022.
//

import UIKit

class FavoritesListVC: UIViewController {
    var tableView: UITableView!
    
    var favorites = [Follower]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()

    }
    private func getFavorites() {
        presentLoadingScreen()
        PersistanceManager.shared.retrieveData { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingScreen()
            switch result {
            case .success(let followers):
                if followers.isEmpty {
                    self.showEmptyStateView(message: "No favorites.")
                }
                else {
                    self.favorites = followers
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Okay")
            }
        }
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.register(GFFavoriteCell.self, forCellReuseIdentifier: GFFavoriteCell.reuseIdentifier)
        
    }
}

extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GFFavoriteCell.reuseIdentifier, for: indexPath) as! GFFavoriteCell
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        let vc = UserInfoVC()
        vc.username = favorites[indexPath.row].login
        vc.delegate = self
        vc.isTheUserItself = false
        let navControlller = UINavigationController(rootViewController: vc)
        let appereance = UINavigationBarAppearance()
        appereance.configureWithDefaultBackground()
        navControlller.navigationBar.standardAppearance = appereance
        navControlller.navigationBar.scrollEdgeAppearance = appereance
        present(navControlller, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favToDelete = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        PersistanceManager.shared.updateWith(favorite: favToDelete, actionType: .remove) { [weak self] error in
            guard let error = error else { return }
            self?.presentAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Okay")
        }
    }
}

extension FavoritesListVC: FollowersListVCDelegate {
    func didRequestFollowers(with username: String) {
        let vc = FollowersListVC()
        vc.username = username
        navigationController?.pushViewController(vc, animated: true)
    }
}

