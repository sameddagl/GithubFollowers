//
//  GFEmptyStateView.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 20.11.2022.
//

import UIKit

class GFEmptyStateView: UIView {
    let title = GFTitleLabel(alignment: .center, fontSize: 30, title: "")
    let bgImageView = UIImageView()
    
    let padding: CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configure()
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        backgroundColor = .systemBackground
        title.text = message
    }
    
    //MARK: - Configure UI Elements
    private func configure() {
        title.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(title)
        addSubview(bgImageView)
        
        title.textColor = .tertiaryLabel
        title.numberOfLines = 2
        bgImageView.image = Images.emptyStateImage
        
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
