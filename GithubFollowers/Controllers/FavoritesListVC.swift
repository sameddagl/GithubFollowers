//
//  FavoritesListVC.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 15.11.2022.
//

import UIKit

class FavoritesListVC: GFDataLoadingVC {
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
    
    //MARK: - Get Favorites Networking Call
    private func getFavorites() {
        presentLoadingScreen()
        PersistanceManager.shared.retrieveData { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingScreen()
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
            case .failure(let error):
                self.presentAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Okay")
            }
        }
    }
    
    func updateUI(with favorites: [Follower]) {
        if favorites.isEmpty {
            self.showEmptyStateView(message: "No favorites.")
        }
        else {
            self.favorites = favorites
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
    
    //MARK: - Configure UI Elements
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        tableView.removeExcessRows()
        
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
    
    //MARK: - Selection Control
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

    //MARK: - Row Editing
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favToDelete = favorites[indexPath.row]

        PersistanceManager.shared.updateWith(favorite: favToDelete, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                return
            }
            self.presentAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Okay")
        }
    }
}

extension FavoritesListVC: FollowersListVCDelegate {
    func didRequestFollowers(with username: String) {
        let vc = FollowersListVC(username: username)
        navigationController?.pushViewController(vc, animated: true)
    }
}

