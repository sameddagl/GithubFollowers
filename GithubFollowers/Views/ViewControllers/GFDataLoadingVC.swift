//
//  GFDataLoadingVC.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 24.11.2022.
//

import UIKit

class GFDataLoadingVC: UIViewController {

    var containerView: UIView!

    func presentLoadingScreen() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        containerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingScreen() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyStateView(message: String) {
        DispatchQueue.main.async {
            let emptyStateView = GFEmptyStateView(message: message)
            emptyStateView.frame = self.view.safeAreaLayoutGuide.layoutFrame
            self.view.addSubview(emptyStateView)
        }
    }

}
