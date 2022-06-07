//
//  DashBoardController.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 03/06/22.
//

import Foundation
import UIKit
import SnapKit

class DashBoardController: UIViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        
        self.title = "Welcome"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Purchase", style: .plain, target: self, action: #selector(pushPurchaseController))
        
        
        setupView()
    }
    
    private func setupView(){
        
        
        
    }
    
    @objc func pushPurchaseController(){
        let vc = PurchaseDetailController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
