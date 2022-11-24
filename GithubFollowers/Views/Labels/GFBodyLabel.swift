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
        configure()
    }
    convenience init(alignment: NSTextAlignment ,text: String) {
        self.init(frame: .zero)
        self.textAlignment = alignment
        self.font = .preferredFont(forTextStyle: .body)
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.7
        
        self.text = text
        
        textColor = .label
        
        numberOfLines = 0        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
