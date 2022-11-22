//
//  GFBodyLabel.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 15.11.2022.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    init(text: String) {
        super.init(frame: .zero)
        configure(text: text)
    }
    
    
    private func configure(text: String) {
        translatesAutoresizingMaskIntoConstraints = false
        
        font = .preferredFont(forTextStyle: .body)
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.6
        
        self.text = text
        textAlignment = .center
        
        textColor = .label
        
        numberOfLines = 0
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
