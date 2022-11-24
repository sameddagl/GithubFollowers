//
//  GFUserInfoHeaderVC.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 22.11.2022.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    let avatarImageView = GFAvatarImage(frame: .zero)
    let usernameLabel = GFTitleLabel(alignment: .left, fontSize: DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 24 : 28, title: "")
    let nameLabel = GFSecondaryTitleLabel(alignment: .left ,fontSize: 16, title: "")
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(alignment: .left, fontSize: 14, title: "")
    let bioLabel = GFBodyLabel(alignment: .left, text: "")
    
    var user: User!
    
    init(user: User!) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        configure()
        configureInfos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Configure UI Elements
    private func configure() {
        locationImageView.tintColor = .secondaryLabel
        usernameLabel.minimumScaleFactor = 0.6
        bioLabel.textColor = .secondaryLabel
        
        let locationStack = UIStackView(arrangedSubviews: [locationImageView, locationLabel])
        locationStack.alignment = .center
        locationStack.distribution = .fill
        locationStack.spacing = 8
        
        let titlesStack = UIStackView(arrangedSubviews: [usernameLabel, nameLabel, locationStack])
        titlesStack.axis = .vertical
        titlesStack.distribution = .equalSpacing
        titlesStack.spacing = 0
        
        let topStack = UIStackView(arrangedSubviews: [avatarImageView, titlesStack])
        topStack.distribution = .fill
        topStack.spacing = 20
        
        let mainStack = UIStackView(arrangedSubviews: [topStack, bioLabel])
        mainStack.axis = .vertical
        mainStack.distribution = .fill
        mainStack.spacing = 10
        
        view.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            locationImageView.widthAnchor.constraint(equalToConstant: 18),
            locationImageView.heightAnchor.constraint(equalToConstant: 18),
            
            
            mainStack.topAnchor.constraint(equalTo: view.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor)            
        ])
    }
    
    //MARK: - Set values for variables
    private func configureInfos() {
        downloadAvatarImage()
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationLabel.text = user.location ?? "No location available"
        bioLabel.text = user.bio ?? "No bio available"
    }
    
    //MARK: - Download avatar image
    private func downloadAvatarImage() {
        NetworkManager.shared.downloadAvatarImage(avatarURL: user.avatarURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.avatarImageView.image = image
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    



}
