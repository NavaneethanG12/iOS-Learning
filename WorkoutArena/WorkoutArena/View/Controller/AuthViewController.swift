//
//  AuthViewController.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 03/06/22.
//

import Foundation
import UIKit
import SnapKit

class AuthViewController: UIViewController{
    
    var authenticator: Authenticator?
    
    let passField = PassField()
    let passKeyboard = PassKeyBoard()
    
    var previousString: String = ""
    var newString: String = ""
    
    lazy var textField: UITextField = {
        let field = UITextField()
        field.keyboardType = .numberPad
        field.delegate = self
        field.returnKeyType = .done
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Authentication"
        view.backgroundColor = .white
        
        view.addSubview(passField)
        passField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
            make.width.equalTo(300)
            make.height.equalTo(60)
        }
        view.addSubview(textField)
        textField.becomeFirstResponder()
    }
    
    func setAuthenticator(authenticator: Authenticator){
        self.authenticator = authenticator
    }
}



extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
//        print("IN textFieldShouldBeginEditing")
//        print(textField.text)
        return true
    }


    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
//        print("IN textFieldDidBeginEditing")
//        print(textField.text)
    }

 
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        
//        print("IN textFieldShouldEndEditing")
//        print(textField.text)
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
//        print("IN textFieldDidEndEditing")
//        print(textField.text)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        
//        print("IN shouldChangeCharactersIn")
        
        if let text = textField.text as NSString? {
                let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
//            print(text)
            previousString = text as String
            newString = txtAfterUpdate
//            print(txtAfterUpdate)
            if newString.count > previousString.count{
                passField.updateDots(count: newString.count ?? 0)
                if newString.count == 4{
                    authenticator?.authenticate(with: newString, completion: { status in
                        if status{
                            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                let sceneDelegate = windowScene.delegate as? SceneDelegate
                              else {
                                return
                              }
                              let viewcontroller = DashBoardController()
                            let nav = UINavigationController(rootViewController: viewcontroller)
                              sceneDelegate.window?.rootViewController = nav
                        }else{
                            passField.deleteLastDot(count: 0)
                            textField.text = ""
                            let alert = UIAlertController(title: "ERROR", message: "Wrong Password", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }
                    })
                }
            }else{
                passField.deleteLastDot(count: newString.count ?? 4)
            }
            
            
            
        }
        
        return true
    }

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
//        print("IN textFieldShouldReturn")
//        print(textField.text)
        return true
    }
    

    
   
}
