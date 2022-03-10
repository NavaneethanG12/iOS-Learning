//
//  ViewController.swift
//  SwiftWidgets
//
//  Created by navaneeth-pt4855 on 02/03/22.
//

import UIKit
import WidgetKit

class ViewController: UIViewController {


    let text: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = "Enter Text"
        return tf
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("SAVE", for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.textColor = .white
        return button
    }()
    
    let singleTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        return gesture
    }()

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(text)
        view.addSubview(saveButton)
      
        
        
        text.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            text.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 10),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            saveButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .tintColor
        
        view.isUserInteractionEnabled = true
        
        view.addGestureRecognizer(singleTapGesture)
        
        singleTapGesture.addTarget(self, action: #selector(gestureHandler))
        
        saveButton.addTarget(self, action: #selector(saveButtonHandler), for: .touchUpInside)
        
    }
    
    
    @objc func saveButtonHandler(){
        text.resignFirstResponder()
        
        let userDefault = UserDefaults(suiteName: "group.swiftwidgetcache")
        
        guard let text = text.text else { return }
        
        userDefault?.setValue(text, forKey: "widgetText")
        WidgetCenter.shared.reloadAllTimelines()
    }
    @objc func gestureHandler(){
        
        print("Tapped")
        text.resignFirstResponder()
    }


}

