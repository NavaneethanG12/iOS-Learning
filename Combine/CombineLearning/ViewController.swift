//
//  ViewController.swift
//  Combine
//
//  Created by navaneeth-pt4855 on 05/07/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    let centreLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        
        setupSubscribers()
    }

    private func setupView(){
        view.addSubview(centreLabel)
        centreLabel.text = "Hello"
        centreLabel.textAlignment = .center
        centreLabel.backgroundColor = .tintColor
        centreLabel.textColor = .white
        
        centreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            centreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centreLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centreLabel.widthAnchor.constraint(equalToConstant: 150),
            centreLabel.heightAnchor.constraint(equalToConstant: 50)
        ])

        centreLabel.layer.masksToBounds = true
        centreLabel.layer.cornerRadius = 25
        
        let publisherSwitch = UISwitch()
        view.addSubview(publisherSwitch)
        publisherSwitch.addTarget(self, action: #selector(publishEvent), for: .valueChanged)
        
        publisherSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            publisherSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            publisherSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
        ])
    }
    
    private func setupSubscribers(){
        
        let labelPublisher = NotificationCenter.Publisher(center: .default, name: .labelChange)
            .map { notification -> String? in
                return (notification.object as? LabelModel)?.title ?? ""
            }
        let labelSubscriber = Subscribers.Assign(object: centreLabel, keyPath: \.text)
        
        labelPublisher.subscribe(labelSubscriber)
    }

    @objc func publishEvent(_ sender: UISwitch){
        if sender.isOn{
            let object = LabelModel(title: "senderIsOn", subtitle: "subtitle", id: 12)
            NotificationCenter.default.post(name: .labelChange, object: object)
        }else{
            let object = LabelModel(title: "senderIsOff", subtitle: "subtitle", id: 12)
            NotificationCenter.default.post(name: .labelChange, object: object)
        }
       
    }
}

