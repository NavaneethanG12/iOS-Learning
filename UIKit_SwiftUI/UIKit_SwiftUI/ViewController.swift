//
//  ViewController.swift
//  UIKit_SwiftUI
//
//  Created by navaneeth-pt4855 on 24/06/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let contentView = UIHostingController(rootView: ContentView())
        
        view.backgroundColor = .white
        let btn = UIButton(frame: CGRect(x: 150, y: 350, width: 100, height: 52))
        btn.setTitle("Show UI", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(showSwiftUI), for: .touchUpInside)
        view.addSubview(btn)
//
//        view.addSubview(contentView.view)
//        contentView.view.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            contentView.view.topAnchor.constraint(equalTo: view.topAnchor),
//            contentView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            contentView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
        
//        let theContainer = UIView()
//        theContainer.frame = view.bounds
//
//        view.addSubview(theContainer)
//
//        let childView = UIHostingController(rootView: ContentView())
//                addChild(childView)
//                childView.view.frame = theContainer.bounds
//                theContainer.addConstrained(subview: childView.view)
//                childView.didMove(toParent: self)
    }
    
    @objc func showSwiftUI(){
        let vc = UIHostingController(rootView: ConfirmIdentityView())
        present(vc, animated: true)
    }

}


extension UIView {
    func addConstrained(subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
