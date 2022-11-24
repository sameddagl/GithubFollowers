//
//  GFAvatarImage.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 16.11.2022.
//

import UIKit

class GFAvatarImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
        
        image = Images.placeHolderImage
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    

    
}
