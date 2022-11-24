//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 15.11.2022.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(image: String, title: String, backgroundColor: UIColor) {
        self.init(frame: .zero)
        self.set(image: image, title: title, backgroundColor: backgroundColor)
    }
    func set(image: String, title: String, backgroundColor: UIColor) {
        if #available(iOS 15, *) {
            configuration?.title = title
            configuration?.imagePadding = 10
            
            configuration?.baseBackgroundColor = backgroundColor
            configuration?.baseForegroundColor = backgroundColor
            
            configuration?.imagePlacement = .leading
            configuration?.image = UIImage(systemName: image)
        }
        else {
            setTitle(title, for: .normal)
            self.backgroundColor = backgroundColor
        }
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 15, *) {
            configuration = .tinted()
            configuration?.cornerStyle = .large
        }
        else {
            layer.cornerRadius = 10
            titleLabel?.font = .preferredFont(forTextStyle: .headline)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
