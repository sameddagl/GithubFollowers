//
//  GFFollowersItemVC.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 23.11.2022.
//

import UIKit

class GFFollowersItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        infoView1.set(infoType: .followers, count: user.followers)
        infoView2.set(infoType: .following, count: user.following)
        button.set(title: "Go github page", backgroundColor: .systemGreen)
    }
    
    override func buttonTapped() {
        delegate.didTapGetFollowersButton(for: user)
    }


}
