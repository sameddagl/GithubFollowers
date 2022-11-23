//
//  GFEmptyStateView.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 20.11.2022.
//

import UIKit

class GFEmptyStateView: UIView {
    let title = GFTitleLabel(alignment: .center, fontSize: 30, title: "The user has no followers.\n Go follow him.")
    let bgImageView = UIImageView()
    
    let padding: CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configure()
    }
    
    private func configure() {
        title.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(title)
        addSubview(bgImageView)
        
        title.numberOfLines = 2
        bgImageView.image = UIImage(named: "empty-state-logo")
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            bgImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.2),
            bgImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.2),
            bgImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 100),
            bgImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 200)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
