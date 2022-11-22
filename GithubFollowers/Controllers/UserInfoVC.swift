//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 22.11.2022.
//

import UIKit

class UserInfoVC: UIViewController {
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let rightButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = rightButton
        print(username!)
    }
    @objc func dismissVC() {
        dismiss(animated: true)
    }


}
