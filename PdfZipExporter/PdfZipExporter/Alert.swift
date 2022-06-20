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
}


class MyAlert: NSObject {
    
    static let shared: MyAlert = MyAlert()
    
    var sharedAlert: UIAlertController!
    
    private override init() {
        
    }

    func showAlert(inView: UIViewController, alert: Alert){
        switch alert {
        case .noData(let message):
            sharedAlert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        case .fileExists(let message):
            sharedAlert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        case .noAvailablePdfs(let message):
            sharedAlert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        default:
            sharedAlert = UIAlertController(title: "Something went wrong!", message: "", preferredStyle: .alert)
        }
        sharedAlert.addAction(UIAlertAction(title: "OK", style: .default))
        inView.present(sharedAlert, animated: true)
    }
    
    
}

