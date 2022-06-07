//
//  DashBoardController.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 03/06/22.
//

import Foundation
import UIKit
import SnapKit

class DashBoardController: UIViewController, SDropDownDelegate {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        
        self.title = "Welcome"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Purchase", style: .plain, target: self, action: #selector(pushPurchaseController))
        
        
        setupView()
    }
    
    private func setupView(){
        
        let array = ["Lamborgini","Buggatti","Swift","Hyundai","Honda","Benz","Audi"]
        
        let dropDown = SDropDown(placeholder: "Select Cars", dropDownItems: array)
        
        view.addSubview(dropDown)
        dropDown.delegate = self
        
        dropDown.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
    }
    
    func dropDown(didSelectAt index: Int, dropDown: SDropDown) {
        self.navigationItem.title = dropDown.dropDownItems?[index]
    }
    
    func dropDownDidReset() {
        self.navigationItem.title = "Welcome"
    }
    
    @objc func pushPurchaseController(){
        let vc = PurchaseDetailController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
