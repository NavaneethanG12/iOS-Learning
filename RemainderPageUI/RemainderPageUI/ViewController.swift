//
//  ViewController.swift
//  RemainderPageUI
//
//  Created by navaneeth-pt4855 on 28/06/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let btn = UIButton(frame: CGRect(x: 150, y: 350, width: 100, height: 52))
        btn.setTitle("Recall", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(showSwiftUI), for: .touchUpInside)
        view.addSubview(btn)
        
        let btn1 = UIButton(frame: CGRect(x: 150, y: 415, width: 100, height: 52))
        btn1.setTitle("Remainder", for: .normal)
        btn1.setTitleColor(.white, for: .normal)
        btn1.backgroundColor = .black
        btn1.addTarget(self, action: #selector(showSwiftUI1), for: .touchUpInside)
        view.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRect(x: 150, y: 480, width: 100, height: 52))
        btn2.setTitle("Reacall UIkit", for: .normal)
        btn2.setTitleColor(.white, for: .normal)
        btn2.backgroundColor = .black
        btn2.addTarget(self, action: #selector(showUIKit), for: .touchUpInside)
        view.addSubview(btn2)
        
        let btn3 = UIButton(frame: CGRect(x: 150, y: 545, width: 100, height: 52))
        btn3.setTitle("Remainder UIkit", for: .normal)
        btn3.setTitleColor(.white, for: .normal)
        btn3.backgroundColor = .black
        btn3.addTarget(self, action: #selector(showUIKit1), for: .touchUpInside)
        view.addSubview(btn3)
        
    }
    @objc func showSwiftUI(){
        
        
        let model1 = BottomModel(iconName: "recall",
                                title: "Recall Document",
                                description: "Recalling the document will make it void and prevent the signers from signing it.",
                                btnTitle: "Recall Now",
                                btnColor: Color.btnColorRed)
        
        var swiftUiView = RemainderPage(model: model1)
        
        let vc = UIHostingController(rootView: swiftUiView)
        vc.modalPresentationStyle = .custom
        let slideInTransitionDelegate = PresentationManager()
        vc.transitioningDelegate = slideInTransitionDelegate
        swiftUiView.setHander {
            vc.dismiss(animated: true)
            print("Recalled")
        }
        vc.rootView = swiftUiView
        present(vc, animated: true)
    }
    
    @objc func showSwiftUI1(){
        let model = BottomModel(iconName: "remainder",
                                title: "Reminder",
                                description: "When send-in-order option is enabled... Reminder will be sent to the next signer. Otherwise... Remainders will be sent to all the signers.",
                                btnTitle: "Send Reminder",
                                btnColor: Color.btnColorGreen)
        
        var swiftUiView = RemainderPage(model: model)
        
        let vc = UIHostingController(rootView: swiftUiView)
        vc.modalPresentationStyle = .custom
        let slideInTransitionDelegate = PresentationManager()
        vc.transitioningDelegate = slideInTransitionDelegate
        swiftUiView.setHander {
            vc.dismiss(animated: true)
            print("Remainder")
        }
        vc.rootView = swiftUiView
        present(vc, animated: true)
    }
    
    @objc func showUIKit(){
        let model = BottomModel(iconName: "remainder",
                                title: "Reminder",
                                description: "When send-in-order option is enabled... Reminder will be sent to the next signer. Otherwise... Remainders will be sent to all the signers.",
                                btnTitle: "Send Reminder",
                                btnColor: Color.btnColorGreen)
        let vc = PopUpViewController(model: model)
        vc.title = "Remainder"
        vc.completion = {
            print("Complettion")
        }
        vc.modalPresentationStyle = .custom
        let slideInTransitionDelegate = PresentationManager()
        vc.transitioningDelegate = slideInTransitionDelegate
        present(vc, animated: true)
    }

    @objc func showUIKit1(){
        let model = BottomModel(iconName: "recall",
                                title: "Recall Document",
                                description: "Recalling the document will make it void and prevent the signers from signing it.",
                                btnTitle: "Recall Now",
                                btnColor: Color.btnColorRed)
        let vc = PopUpViewController(model: model)
        vc.completion = {
            print("Complettion")
        }
        vc.modalPresentationStyle = .custom
        let slideInTransitionDelegate = PresentationManager()
        vc.transitioningDelegate = slideInTransitionDelegate
        present(vc, animated: true)
    }


}

