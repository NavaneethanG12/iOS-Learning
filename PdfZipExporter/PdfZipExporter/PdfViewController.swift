//
//  PdfViewController.swift
//  PdfZipExporter
//
//  Created by navaneeth-pt4855 on 17/06/22.
//

import Foundation
import UIKit
import PDFKit
import SnapKit

class PdfViewController: UIViewController{
    
    var document: PDFDocument!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    convenience init (document: PDFDocument){
        self.init()
        
        self.document = document
    }
    
    private func setupView(){
        let pdfview = PDFView()
        
        
        view.addSubview(pdfview)
        pdfview.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        pdfview.document = document
    }
}
