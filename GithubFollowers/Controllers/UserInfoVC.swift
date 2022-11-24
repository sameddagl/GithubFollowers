//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 22.11.2022.
//

import UIKit


protocol UserInfoVCDelegate: AnyObject {
    func didTapGitButton(for user: User)
    func didTapGetFollowersButton(for user: User)
}

class UserInfoVC: GFDataLoadingVC {
    var username: String!
    var isTheUserItself = false
    
    let headerContainer = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    let dateLabel = GFSecondaryTitleLabel(alignment: .center, fontSize: 15, title: "")
    
    var delegate: FollowersListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getUserInfo()
        layoutUI()
    }
    
    //MARK: - Get User Info Networking Call
    private func getUserInfo() {
        presentLoadingScreen()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingScreen()
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(user: user)
                }
            case .failure(_):
                self.presentAlert(title: "Something went wrong", message: "Unable to get info for \(String(describing: self.username!)). Please try again", buttonTitle: "Okay")
            }
        }
    }
    
    //MARK: - Configure UI Elements
    private func configureUI() {
        view.backgroundColor = .systemBackground
        let rightButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func configureUIElements(user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followersItemVC = GFFollowersItemVC(user: user)
        followersItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerContainer)
        self.add(childVC: repoItemVC, to: self.itemView1)
        
        if !isTheUserItself {
            self.add(childVC: followersItemVC, to: self.itemView2)
        }
        
        self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYear())"
    }
    
    private func layoutUI() {
        let padding: CGFloat = 20
        let itemSpacing: CGFloat = 20
        
        for item in [headerContainer, itemView1, itemView2, dateLabel] {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        view.addSubview(headerContainer)
        headerContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            headerContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            itemView1.topAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: itemSpacing),
            itemView1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            
            itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: itemSpacing),
            itemView2.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            
        ])
        
        if !isTheUserItself
        {
            dateLabel.topAnchor.constraint(equalTo: itemView2.bottomAnchor, constant: 10).isActive = true
        }
        else
        {
            dateLabel.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: 10).isActive = true
        }
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        self.addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
        
    }
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitButton(for user: User) {
        guard let url = URL(string: user.htmlURL) else {
            presentAlert(title: "Invalid url", message: "The url attached to the user is invalid.", buttonTitle: "Okay")
            return
        }
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowersButton(for user: User) {
        dismiss(animated: true)
        delegate.didRequestFollowers(with: user.login)
    }
    
    
}
