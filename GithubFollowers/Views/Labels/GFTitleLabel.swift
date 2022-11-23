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
    init(alignment: NSTextAlignment, fontSize: CGFloat, title: String) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure(alignment: alignment, fontSize: fontSize ,title: title)
    }
    
    
    private func configure(alignment: NSTextAlignment, fontSize: CGFloat, title: String) {
        translatesAutoresizingMaskIntoConstraints = false
        
        font = .systemFont(ofSize: fontSize, weight: .bold)
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.7
        
        text = title
        textAlignment = alignment
        
        textColor = .label
        
        numberOfLines = 1
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
