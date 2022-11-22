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
    }
    
    init(title: String) {
        super.init(frame: .zero)
        configure(title: title)
    }
    
    private func configure(title: String) {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemGreen
        
        layer.cornerRadius = 10
        
        
        setTitle(title, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        
        
    }
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
