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
    }
    init(fontSize: CGFloat, title: String) {
        super.init(frame: .zero)
        configure(fontSize: fontSize ,title: title)
    }
    
    
    private func configure(fontSize: CGFloat,title: String) {
        translatesAutoresizingMaskIntoConstraints = false
        
        font = .systemFont(ofSize: fontSize, weight: .bold)
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
        
        text = title
        textAlignment = .center
        
        textColor = .label
        
        numberOfLines = 1
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
