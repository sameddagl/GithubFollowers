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
    init(alignment: NSTextAlignment ,text: String) {
        super.init(frame: .zero)
        configure(alignment: alignment, text: text)
    }

    private func configure(alignment: NSTextAlignment, text: String) {
        translatesAutoresizingMaskIntoConstraints = false
        
        font = .preferredFont(forTextStyle: .body)
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.7
        
        self.text = text
        textAlignment = alignment
        
        textColor = .label
        
        numberOfLines = 0
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
