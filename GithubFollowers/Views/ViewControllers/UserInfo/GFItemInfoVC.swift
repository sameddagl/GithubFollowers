//
//  GFItemInfoVC.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 22.11.2022.
//

import UIKit

class GFItemInfoVC: UIViewController {
    let infoView1 = GFItemInfoView()
    let infoView2 = GFItemInfoView()
    let button = GFButton()
    
    var user: User!
    var delegate: UserInfoVCDelegate!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

    }
    
    //MARK: - Configure UI Elements
    private func configure() {
        let padding: CGFloat = 20
        view.layer.cornerRadius = 20
        view.backgroundColor = .secondarySystemBackground
        
        let stack = UIStackView(arrangedSubviews: [infoView1, infoView2])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        
        view.addSubview(stack)
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
        ])
    }
    
    @objc func buttonTapped() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
