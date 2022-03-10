//
//  ViewController.swift
//  SnapKitPractice
//
//  Created by navaneeth-pt4855 on 10/03/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .tintColor
//        view.layer.cornerRadius = 30
        return view
    }()
    
    let emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "  Enter your Email Id"
        field.layer.borderWidth = 1
        field.backgroundColor = .white
//        field.layer.cornerRadius = 15
        field.layer.borderColor = UIColor.black.cgColor
        return field
    }()
    
    let passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "  Enter your password"
        field.layer.borderWidth = 1
        field.backgroundColor = .white
//        field.layer.cornerRadius = 15
        field.layer.borderColor = UIColor.black.cgColor
        return field
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .tintColor
        button.addTarget(self, action: #selector(loginButtonHandelr), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .tintColor
        button.addTarget(self, action: #selector(registerButtonHandelr), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SnapKit"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        snpLayout()
    }

    func snpLayout(){
        view.addSubview(containerView)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.width.equalTo(view.snp.width).multipliedBy(0.75)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
            make.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { field in
            field.bottom.equalTo(containerView.snp.centerY).offset(-5)
            field.height.equalTo(52)
            field.width.equalTo(containerView).multipliedBy(0.75)
            field.centerX.equalTo(containerView)
        }
        
        passwordTextField.snp.makeConstraints { field in
            field.top.equalTo(containerView.snp.centerY).offset(5)
            field.height.equalTo(52)
            field.width.equalTo(containerView).multipliedBy(0.75)
            field.centerX.equalTo(containerView)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.centerX.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-5)
            make.centerX.equalToSuperview()
        }
        
    }
    
    @objc func loginButtonHandelr(_ sender: UIButton){
        
        print(sender.titleLabel?.text)
    }
    

    @objc func registerButtonHandelr(_ sender: UIButton){
        
        print(sender.titleLabel?.text)
    }
    
}

