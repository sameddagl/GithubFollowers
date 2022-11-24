//
//  GFTitleLabel.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 15.11.2022.
//

import UIKit

class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()

    }
    
    convenience init(alignment: NSTextAlignment, fontSize: CGFloat, title: String) {
        self.init(frame: .zero)
        self.textAlignment = alignment
        self.font = .systemFont(ofSize: fontSize, weight: .bold)
        self.text = title
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
                
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.7
        
        textColor = .label
        
        numberOfLines = 1
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
