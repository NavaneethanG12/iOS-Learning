//
//  Alert.swift
//  PdfZipExporter
//
//  Created by navaneeth-pt4855 on 20/06/22.
//

import Foundation
import UIKit

enum Alert{
    case noData(String)
    case fileExists(String)
    case noAvailablePdfs(String)
    case defaultAlert(String)
    case passAlert(String)
}


class MyAlert: NSObject {
        
    var sharedAlert: UIAlertController!
    
    func showAlert(inView: UIViewController, alert: Alert){
        switch alert {
        case .noData(let message):
            sharedAlert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        case .fileExists(let message):
            sharedAlert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        case .noAvailablePdfs(let message):
            sharedAlert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        case .defaultAlert(let message):
            sharedAlert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        case .passAlert(let message):
            sharedAlert = UIAlertController(title: message, message: "", preferredStyle: .alert)
            sharedAlert.addTextField { textField in
                textField.placeholder = "Enter Password"
            }
        }
        sharedAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
        inView.present(sharedAlert, animated: true)
    }
    
    
}

