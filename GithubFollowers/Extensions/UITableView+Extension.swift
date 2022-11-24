//
//  UITableView+Extension.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 24.11.2022.
//

import UIKit

extension UITableView {
    
    func removeExcessRows() {
        self.tableFooterView = UIView(frame: .zero)
    }
}
