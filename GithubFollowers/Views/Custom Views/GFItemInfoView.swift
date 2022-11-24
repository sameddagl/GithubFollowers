//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 22.11.2022.
//

import UIKit

enum ItemInfoType {
    case repos
    case gists
    case followers
    case following
}

class GFItemInfoView: UIView {
    let iconImageView = UIImageView()
    let titleLabel = GFTitleLabel(alignment: .left, fontSize: 15, title: "")
    let countLabel = GFTitleLabel(alignment: .center, fontSize: 14, title: "")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUIElements()
        configure()
    }
    
    private func configureUIElements() {
        iconImageView.tintColor = .label
        iconImageView.contentMode = .scaleAspectFill
    }
    
    //MARK: - Configure UI Elements
    private func configure() {
        let topStack = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        topStack.distribution = .fill
        topStack.spacing = 5
        
        let mainStack = UIStackView(arrangedSubviews: [topStack, countLabel])
        mainStack.axis = .vertical
        mainStack.distribution = .fillEqually
        mainStack.alignment = .center
        mainStack.spacing = 5
        
        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    //MARK: - Set Function
    func set(infoType: ItemInfoType, count: Int) {
        switch infoType {
        case .repos:
            iconImageView.image = UIImage(systemName: SFSymbols.repo)
            titleLabel.text = "Public Repos"
        case .gists:
            iconImageView.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text = "Public Gists"
        case .followers:
            iconImageView.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text = "Followers"
        case .following:
            iconImageView.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
