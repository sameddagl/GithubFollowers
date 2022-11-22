//
//  UIHelper.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 22.11.2022.
//

import UIKit

struct UIHelper {
    
    static func createThreeColumnFlowLayout(view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 10
        let itemSpacing: CGFloat = 10
        let avaibleWidth = width - (padding * 2) - (itemSpacing * 2)
        let itemWidth = avaibleWidth / 3
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 50)
        
        return layout
    }
}
