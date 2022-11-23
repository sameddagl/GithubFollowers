//
//  GFTextField.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 15.11.2022.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(placeholder: String) {
        super.init(frame: .zero)
        configure(placeholder: placeholder)
    }
    
    private func configure(placeholder: String) {
        translatesAutoresizingMaskIntoConstraints = false
        
        text = "SAllen0400"
        
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        
        textAlignment = .center
        font = .preferredFont(forTextStyle: .headline)
        
        returnKeyType = .search
        autocorrectionType = .no
        autocapitalizationType = .none
        
        self.placeholder = placeholder
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
