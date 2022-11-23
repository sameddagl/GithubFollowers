//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 15.11.2022.
//

import UIKit

class SearchVC: UIViewController {
    let logoImageView = UIImageView()
    let nameTextField = GFTextField(placeholder: "Enter a username")
    let actionButton = GFButton(title: "Get Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureUI() {
        nameTextField.delegate = self
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tappedOnScreen))
        recognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(recognizer)
        
        configureLogoImageView()
        configureTextField()
        configureButton()
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func configureTextField() {
        view.addSubview(nameTextField)
        
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            nameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureButton() {
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            actionButton.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        let vc = FollowersListVC()
        if let name = nameTextField.text, !name.isEmpty {
            vc.username = name
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            presentAlert(title: "No username", message: "Please enter a username.", buttonTitle: "Okay")
        }
    }
}

extension SearchVC: UITextFieldDelegate {
    @objc func tappedOnScreen() {
        view.endEditing(true)
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tappedOnScreen()
        buttonTapped()
        return true
    }
    
}
