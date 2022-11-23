//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 23.11.2022.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoView1.set(infoType: .repos, count: user.publicRepos)
        infoView2.set(infoType: .gists, count: user.publicGists)
        button.set(title: "Go github page", backgroundColor: .systemBlue)
    }
    
    override func buttonTapped() {
        delegate.didTapGitButton(for: user)
    }

}
