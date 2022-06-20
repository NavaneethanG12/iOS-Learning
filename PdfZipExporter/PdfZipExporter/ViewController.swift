//
//  ViewController.swift
//  PdfZipExporter
//
//  Created by navaneeth-pt4855 on 17/06/22.
//

import UIKit
import SnapKit
import MobileCoreServices
import UniformTypeIdentifiers
import PDFKit


class ViewController: UIViewController {
    
    
    var pdfCount: Observable<Int> = Observable.init(value: 0)
    
    var encryptionKey: String?
    
    var pdfDocuments: [PDFDocument] = []
        
    var pdfExporter = PdfExporter()
    
    lazy var pdfCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "PDF Exporter"
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Set Password", style: .plain, target: self, action: #selector(showPasswordAlert))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Remove All pdf", style: .plain, target: self, action: #selector(removeAllPdf))
        
        setupView()
    }

    @objc func removeAllPdf(){
        pdfExporter.documents.value.removeAll()
//        pdfCount.value = pdfDocuments.count
    }
    
    private func setupView(){
        

        view.addSubview(pdfCountLabel)
        
        pdfCountLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.centerX.equalToSuperview()
        }
        
        let addButton = ZButton(title: "Add Pdf", titleColor: .white, bgColor: .tintColor, cornerRadius: 26, target: self, action: #selector(addPdfDocuments))
        
        view.addSubview(addButton)
        
        addButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(52)
            make.center.equalToSuperview()
        }
        
        let viewPdf = ZButton(title: "View Merged Pdf", titleColor: .white, bgColor: .tintColor, cornerRadius: 26, target: self, action: #selector(shorMergedpdf))
        
        view.addSubview(viewPdf)
        
        viewPdf.snp.makeConstraints { make in
            make.width.equalTo(175)
            make.height.equalTo(52)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        let zipPdf = ZButton(title: "Zip all Pdfs", titleColor: .white, bgColor: .tintColor, cornerRadius: 26, target: self, action: #selector(zipAllPdfs))
        
        view.addSubview(zipPdf)
        
        zipPdf.snp.makeConstraints { make in
            make.width.equalTo(175)
            make.height.equalTo(52)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(viewPdf.snp.top).offset(-25)
        }
        
        pdfExporter.documents.bind {[weak self] value in
//            if value.count == 0{
//                self?.navigationItem.rightBarButtonItem?.isEnabled = false
//                viewPdf.isUserInteractionEnabled = false
//                viewPdf.layer.opacity = 0.5
//            }else{
//                self?.navigationItem.rightBarButtonItem?.isEnabled = true
//                viewPdf.isUserInteractionEnabled = true
//                viewPdf.layer.opacity = 1.0
//            }
            self?.pdfCountLabel.text = "No of pdf Added : \(value.count)"
        }
        
    }
    
    @objc func zipAllPdfs(){
        
        let alert = UIAlertController(title: "Set Your Password", message: "This is the password used for encrypting your pdf", preferredStyle: .alert)
        alert.addTextField { passField in
            passField.placeholder = "Enter your PassWord"
        }
        
        alert.addAction(UIAlertAction(title: "SET", style: .default, handler: {[weak self] alerAction in
            let encryptionKey =  alert.textFields?.first?.text
            
            guard let _self = self else {
                print("\(String(describing: self)) was destroyed")
                return
            }
            do{
                let zippedPath = try _self.pdfExporter.zipAvailablePdfs(encryptionKey: encryptionKey)
                
                print("Zipped file path ---- \(zippedPath)")
            }catch{
                print(error)
                if let error = error as? PdfExporterErrors{
                    if error == .fileAlreadyExists{
                        MyAlert.shared.showAlert(inView: _self, alert: .fileExists("File Already Exists"))
                    }else if error == .noAvailablePdfs{
                        MyAlert.shared.showAlert(inView: _self, alert: .noAvailablePdfs("No available pdf to encrypt"))
                    }
                }
            }
        }))
        present(alert, animated: true)
        
    }
    
    @objc func showPasswordAlert(){
        let alert = UIAlertController(title: "Set Your Password", message: "This is the password used for encrypting your zip file", preferredStyle: .alert)
        alert.addTextField { passField in
            passField.placeholder = "Enter your PassWord"
        }
        
        alert.addAction(UIAlertAction(title: "SET", style: .default, handler: {[weak self] alerAction in
            let encryptionKey =  alert.textFields?.first?.text
            
            guard let _self = self else {
                print("\(String(describing: self)) was destroyed")
                return
            }
            do{
                let encryptPath = try _self.pdfExporter.encryptAvailablePdfs(encryptionKey: encryptionKey)
                print("Encrypted file path ---- \(encryptPath)")
            }catch{
                print(error)
                if let error = error as? PdfExporterErrors{
                    if error == .fileAlreadyExists{
                        MyAlert.shared.showAlert(inView: _self, alert: .fileExists("File Already Exists"))
                    }else if error == .noAvailablePdfs{
                        MyAlert.shared.showAlert(inView: _self, alert: .noAvailablePdfs("No available pdf to encrypt"))
                    }
                }
            }
        }))
        present(alert, animated: true)
    }
    

    @objc func addPdfDocuments(){
        var documentPicker: UIDocumentPickerViewController!
        if #available(iOS 14, *) {
            // iOS 14 & later
            let supportedTypes: [UTType] = [UTType.pdf]
            documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes)
        } else {
            // iOS 13 or older code
            let supportedTypes: [String] = [kUTTypePDF as String]
            documentPicker = UIDocumentPickerViewController(documentTypes: supportedTypes, in: .import)
        }
        documentPicker.allowsMultipleSelection = true
        documentPicker.delegate = self
        
        present(documentPicker, animated: true)
    }
    
    @objc func shorMergedpdf(){
        do{
            let pdfDocument = try pdfExporter.mergeAvailablePdfs()
            let pdfVC = PdfViewController(document: pdfDocument)
            
            self.navigationController?.pushViewController(pdfVC, animated: true)
        }catch{
            print(error)
        }
    }
}


extension ViewController: UIDocumentPickerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        for url in urls {
            if let document = PDFDocument(url: url){
                pdfExporter.documents.value.append(document)
            }
        }
    }
    
}



