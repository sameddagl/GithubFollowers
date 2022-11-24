//
//  GFFollowerCell.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 15.11.2022.
//

import UIKit

class GFFollowerCell: UICollectionViewCell {
    let avatarImageView = GFAvatarImage(frame: .zero)
    let nameTitle = GFTitleLabel(alignment: .center, fontSize: 15, title: "Null")
    
    let padding: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageView()
    }
    
    func set(_ follower: Follower) {
        nameTitle.text = follower.login
        NetworkManager.shared.getProfileImage(avatarURL: follower.avatarURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.avatarImageView.image = image
            }
        }
    }
    
    private func configureImageView() {
        addSubview(avatarImageView)
                
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
        configureTitleLabel()
    }
    
    private func configureTitleLabel() {
        addSubview(nameTitle)
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            nameTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            nameTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            nameTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
