//
//  Authenticator.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 03/06/22.
//

import Foundation
import UIKit

class Authenticator: NSObject{
    
    private var masterPassWord: String = "1234"
    
    typealias authCompletionHandler = ((Bool) -> Void)
    
    var superView: UIViewController?
    
    override init() {
        super.init()
    }
    
    convenience init(vc: UIViewController) {
        self.init()
        self.superView = vc
    }
    
    func presentAuthViewController(){
        let vc = AuthViewController()
        vc.setAuthenticator(authenticator: self)
        let nav = UINavigationController(rootViewController: vc)
        
        superView?.present(nav, animated: true)
    }
    
    func authenticate(with password: String, completion: authCompletionHandler ){
        if password == masterPassWord{
            completion(true)
        }else{
            completion(false)
        }
    }
    
}
