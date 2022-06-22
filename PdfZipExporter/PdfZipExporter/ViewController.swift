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
    
    lazy var pdfExporter = PdfExporter(rootVC: self)
    
    lazy var pdfCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var mergedFilePath: URL!
    
    var myAlert = MyAlert()
    
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
        
        let clearBtn = UIButton()
        clearBtn.setTitle("Clear All Directories", for: .normal)
        clearBtn.setTitleColor(.red, for: .normal)
        clearBtn.addTarget(self, action: #selector(clearAllFileDirectories), for: .touchUpInside)
        
        view.addSubview(clearBtn)
        
        clearBtn.snp.makeConstraints { make in
            make.top.equalTo(pdfCountLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        let addButton = ZButton(title: "Add Pdf", titleColor: .white, bgColor: .tintColor, cornerRadius: 26, target: self, action: #selector(addPdfDocuments))
        
        view.addSubview(addButton)
        
        addButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(52)
            make.center.equalToSuperview()
        }
        
        let viewPdf = ZButton(title: "View Merged Pdf", titleColor: .white, bgColor: .tintColor, cornerRadius: 26, target: self, action: #selector(showMergedpdf))
        
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
            make.bottom.equalTo(viewPdf.snp.top).offset(-15)
        }
        
        let mergePdf = ZButton(title: "Merge all Pdfs", titleColor: .white, bgColor: .tintColor, cornerRadius: 26, target: self, action: #selector(mergeAllPdfs))
        
        view.addSubview(mergePdf)
        
        mergePdf.snp.makeConstraints { make in
            make.width.equalTo(175)
            make.height.equalTo(52)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(zipPdf.snp.top).offset(-15)
        }
        
        let flatPdf = ZButton(title: "Flat Pdf", titleColor: .white, bgColor: .tintColor, cornerRadius: 26, target: self, action: #selector(flatAllPdfs))
        
        view.addSubview(flatPdf)
        
        flatPdf.snp.makeConstraints { make in
            make.width.equalTo(175)
            make.height.equalTo(52)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(mergePdf.snp.top).offset(-15)
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
    
    @objc func mergeAllPdfs(){

            pdfExporter.mergeAvailablePdfs { url, error in
                guard let mergedFilePath = url else { return }
                print("Merged File Path ---- \(mergedFilePath)")
                self.mergedFilePath = mergedFilePath
            }
     
  
    }
    
    @objc func flatAllPdfs(){
        
        pdfExporter.flattenAvailablePdf { url, error in
            guard let url = url else { return }
            print("Flattened document path --------- \(url)")
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

            _self.pdfExporter.zipAvailablePdfs(encryptionKey: encryptionKey == "" ? nil : encryptionKey) { url, error in
                guard let zippedPath = url else { return }
                print("Zipped file path ---- \(zippedPath)")
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
            _self.pdfExporter.encryptAvailablePdfs(encryptionKey: encryptionKey == "" ? nil : encryptionKey) { url, error in
                guard let encryptPath = url else { return }
                print("Encrypted file path ---- \(encryptPath)")
            }
                
        }))
        present(alert, animated: true)
    }
    
    @objc func clearAllFileDirectories(){
        try? pdfExporter.clearAllFileDirectories()
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
    
    @objc func showMergedpdf(){
        guard let pdfDocument = PDFDocument(url: mergedFilePath) else { return }
       
            let pdfVC = PdfViewController(document: pdfDocument)
            
            self.navigationController?.pushViewController(pdfVC, animated: true)
    }
}


extension ViewController: UIDocumentPickerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        for url in urls {
            let document = ZDocument(fileName: url.lastPathComponent, fileUrl: url, filePath: url.path)
            pdfExporter.documents.value.append(document)
        }
        
           
    }
    
}



