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
        configure()
    }
    convenience init(alignment: NSTextAlignment, fontSize: CGFloat, title: String) {
        self.init(frame: .zero)
        self.textAlignment = alignment
        self.font = .systemFont(ofSize: fontSize, weight: .medium)
        self.text = title
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
        
        textColor = .secondaryLabel
        
        lineBreakMode = .byTruncatingTail
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
