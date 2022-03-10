//
//  ViewController.swift
//  FirebaseAuth
//
//  Created by navaneeth-pt4855 on 01/03/22.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {

    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.placeholder = "Email"
        textField.layer.borderColor = UIColor.link.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.placeholder = "Password"
        textField.layer.borderColor = UIColor.link.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        return button
    }()
    
    
    override func viewWillLayoutSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            passwordTextField.heightAnchor.constraint(equalToConstant: 52),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            registerButton.heightAnchor.constraint(equalToConstant: 52),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let ref = Database.database().reference()
//
//        ref.childByAutoId().setValue(["name":"Ravi","age":10])
        
        view.backgroundColor = .systemBackground
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }

    
    @objc func registerTapped(_ sender: UIButton){
        
        if let email = emailTextField.text,let password = passwordTextField.text{
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { data, error in
                
            }
        }
        
        print("Tapped")
        
    }
    

}

