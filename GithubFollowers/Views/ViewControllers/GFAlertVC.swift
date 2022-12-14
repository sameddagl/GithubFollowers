//
//  GFAlertVC.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 15.11.2022.
//

import UIKit

class GFAlertVC: UIViewController {
    let containerView = UIView()
    
    let titleLabel = GFTitleLabel(alignment: .center, fontSize: 20, title: "Error")
    let messageLabel = GFBodyLabel(alignment: .center, text: "An error occured")
    let dismissButton = GFButton(image: "", title: "Okay", backgroundColor: .systemPink)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    }
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        titleLabel.text = title
        messageLabel.text = message
        dismissButton.setTitle(buttonTitle, for: .normal)
        
        configureContainerView()
        configureElements()
    }
    
    //MARK: - Configure Container View
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .systemBackground
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 250),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    //MARK: - Configure UI Elements
    private func configureElements() {
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(dismissButton)
        
        dismissButton.addTarget(self, action: #selector(dismissAlertVC), for: .touchUpInside)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            
            dismissButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            dismissButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.2),
            dismissButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            dismissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: dismissButton.topAnchor, constant: padding),
        ])
        
    }
    
    @objc func dismissAlertVC() {
        dismiss(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
