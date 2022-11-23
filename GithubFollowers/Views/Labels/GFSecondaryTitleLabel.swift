//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 22.11.2022.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    init(alignment: NSTextAlignment, fontSize: CGFloat, title: String) {
        super.init(frame: .zero)
        configure(alignment: alignment, fontSize: fontSize ,title: title)
    }
    
    
    private func configure(alignment: NSTextAlignment, fontSize: CGFloat, title: String) {
        translatesAutoresizingMaskIntoConstraints = false
        
        font = .systemFont(ofSize: fontSize, weight: .medium)
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
        
        text = title
        textColor = .secondaryLabel
        
        textAlignment = alignment
        
        lineBreakMode = .byTruncatingTail
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
