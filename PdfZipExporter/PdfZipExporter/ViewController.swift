//
//  ViewController.swift
//  PdfZipExporter
//
//  Created by navaneeth-pt4855 on 17/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    var pdfCount: Int = 0
    
    lazy var pdfCountLabel: UILabel = {
        let label = UILabel()
        label.text = "No of pdf Added : \(pdfCount)"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "PDF Exporter"
        
        view.backgroundColor = .white
        
        setupView()
    }

    private func setupView(){
        
    }

}

