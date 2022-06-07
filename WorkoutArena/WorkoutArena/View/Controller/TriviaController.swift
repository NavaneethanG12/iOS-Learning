//
//  TriviaController.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 01/06/22.
//

import Foundation
import UIKit
import SnapKit
import Intents


class TriviaController: UIViewController{
    
    let getButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Trivia", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 26
        return button
    }()
    
//    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.navTintColor
        
        view.addSubview(getButton)
        
        getButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(52)
        }
        
        getButton.addTarget(self, action: #selector(getRandomTrivia), for: .touchUpInside)
    }
    
    
    @objc func getRandomTrivia(){
        
        
        DataManager().getRandomTrivia { [weak self] trivia in
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Your Random Trivia", message: trivia, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true)
            }
        }
        
//        INInteraction(intent: GetRandomTriviaIntent(), response: nil).donate(completion: nil)
    }   
}
