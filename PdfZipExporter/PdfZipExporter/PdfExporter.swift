//
//  PdfExporter.swift
//  PdfZipExporter
//
//  Created by navaneeth-pt4855 on 20/06/22.
//

import Foundation
import PDFKit
import SSZipArchive

enum OutputFileType{
    case mergedPdf
    case zipFile
    case encryptedPdf
    case flattenedPdf
}

class PdfExporter: NSObject{
    
    typealias PdfExporterCompletionHandler = ((URL?,Error?) -> Void)
    
    var fileManager = FileManager.default
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyyHHmmss"
        return formatter
    }()
    
    var myAlert = MyAlert()
    
    var documents: Observable<[ZDocument]> = Observable.init(value: [])
    
    private(set) var encryptedFilesDirectory: URL{
        get{
            return fileManager.getEncryptedDirectory()
        }
        set{
            // setter is private
        }
    }
    
    private(set) var zipFilesDirectory: URL{
        get{
            return fileManager.getZipFilesDirectory()
        }
        set{
            // setter is private
        }
    }
    
    private(set) var mergedFilesDirectory: URL{
        get{
            return fileManager.getMergedDocumentDirectory()
        }
        set{
            // setter is private
        }
    }
    
    var isDir:ObjCBool = true
    
    var rootViewController: UIViewController?
    
    override init() {
        super.init()
        
    }
    
    convenience init(rootVC: UIViewController){
        self.init()
        self.rootViewController = rootVC
    }
    
    private func checkForEncryptedDirectory(){
        if fileManager.fileExists(atPath: encryptedFilesDirectory.path, isDirectory: &isDir){
            print("Encrypted Files Directory Alredy exists")
        }else{
            fileManager.createEncryptedDirectory()
        }
    }
    
    private func checkForMergedDocumentDirectory(){
        if fileManager.fileExists(atPath: mergedFilesDirectory.path, isDirectory: &isDir){
            print("Merged Files Directory Alredy exists")
        }else{
            fileManager.createMergedDocumentDirectory()
        }
    }
    
    private func checkForZipFilesDirectory(){
        if fileManager.fileExists(atPath: zipFilesDirectory.path, isDirectory: &isDir){
            print("Zip Files Directory Alredy exists")
        }else{
            fileManager.createZipFilesDirectory()
        }
    }
    
    private func fileExists(atPath: String) -> Bool{
        return fileManager.fileExists(atPath: atPath)
    }
    
    
    func mergePdf(urls: [URL]) throws -> URL{
        checkForMergedDocumentDirectory()
        
        let pdfDocument = PDFDocument()
        for url in urls{
            guard let document = PDFDocument(url: url) else {
                throw PdfExporterErrors.urlError
            }
            pdfDocument.addPages(from: document)
        }
        let currentDate = Date()
        let createdTime = dateFormatter.string(from: currentDate)
        let fileName = "Merged \(createdTime).pdf"
        let filePath = mergedFilesDirectory.appendingPathComponent(fileName)
        
        if fileExists(atPath: filePath.path){
            throw PdfExporterErrors.fileAlreadyExists
        }
        let success = pdfDocument.write(to: filePath)
        if success{
            return filePath
        }else{
            throw PdfExporterErrors.mergeError
        }
    }
    
    func mergeAvailablePdfs(fileName: String? = nil, completion: @escaping PdfExporterCompletionHandler){
        checkForMergedDocumentDirectory()
        
        guard documents.value.count > 0 else {
            return
            //            completion(nil,PdfExporterErrors.noAvailablePdfs)
        }
        
        unlockAllAvailablePdf(index: 0) { [weak self] unlockedDocuments, success in
            guard let _self = self else { return }
            if success{
                let pdfDocument = PDFDocument()
                guard let unlockedDocuments = unlockedDocuments else { return }
                for document in unlockedDocuments{
                    
                    //                        guard let document = zDocument.pdf
                    //                        else {
                    //                            return
                    //                            //                        completion(nil,PdfExporterErrors.urlError)
                    //                        }
                    pdfDocument.addPages(from: document)
                }
                let filePath = _self.getFilepath(outputFileName: fileName, fileType: .mergedPdf)
                if _self.fileExists(atPath: filePath.path){
                    completion(nil,PdfExporterErrors.fileAlreadyExists)
                }
                
                let success = pdfDocument.write(to: filePath)
                if success{
                    completion(filePath,nil)
                }else{
                    completion(nil,PdfExporterErrors.mergeError)
                }
            }
            
        }
    }
    
    /*
     
     func encryptPdf(for documentUrl: URL, encryptionKey key: String?, encryptFileName: String? = nil) throws {
     
     let fileName: String!
     
     if encryptFileName != nil {
     fileName = encryptFileName! + ".pdf"
     
     }else{
     let currentDate = Date()
     
     let createdTime = dateFormatter.string(from: currentDate)
     
     fileName = "Encrypted \(createdTime).pdf"
     }
     
     let filePath = encryptedFilesDirectory.appendingPathComponent(fileName)
     
     if fileExists(atPath: filePath.path){
     throw PdfExporterErrors.fileAlreadyExists
     }
     
     let success = document.write(to: filePath, withOptions: [.userPasswordOption: key!, .ownerPasswordOption: key!])
     if success{
     print("encryption success")
     }else{
     throw PdfExporterErrors.pdfEncryptionFailed
     }
     }
     
     */
    
    func encryptPdf(for document: PDFDocument, encryptionKey key: String?, encryptFileName: String? = nil) throws {
        checkForEncryptedDirectory()
        let filePath = getFilepath(outputFileName: encryptFileName, fileType: .encryptedPdf)
        
        if fileExists(atPath: filePath.path){
            throw PdfExporterErrors.fileAlreadyExists
        }
        
        let success = document.write(to: filePath, withOptions: [.userPasswordOption: key!, .ownerPasswordOption: key!])
        if success{
            print("encryption success")
        }else{
            throw PdfExporterErrors.pdfEncryptionFailed
        }
    }
    
    func encryptAvailablePdfs(encryptionKey key: String?, encryptFileName: String? = nil, completion: @escaping PdfExporterCompletionHandler) {
        checkForEncryptedDirectory()
        
        guard documents.value.count > 0 else {
            return
            //            completion(nil,PdfExporterErrors.noAvailablePdfs)
        }
        
        unlockAllAvailablePdf(index: 0) {[weak self] unlockedDocuments, success in
            guard let _self = self else { return }
            
            if success{
                let filePath = _self.getFilepath(outputFileName: encryptFileName, fileType: .encryptedPdf)
                
                if _self.fileExists(atPath: filePath.path){
                    completion(nil,PdfExporterErrors.fileAlreadyExists)
                    
                }
                
                _self.mergeAvailablePdfs(fileName: "temp"){ url, error in
                    guard let mergedDocumentUrl = url else { return }
                    do{
                        guard let mergedDocument = PDFDocument(url: mergedDocumentUrl) else {
                            return
                            //                        completion(nil,PdfExporterErrors.urlError)
                        }
                        let success = mergedDocument.write(to: filePath, withOptions: [.userPasswordOption: key!, .ownerPasswordOption: key!])
                        if success{
                            print("encryption success")
                            try _self.fileManager.removeItem(atPath: mergedDocumentUrl.path)
                            completion(filePath,nil)
                        }else{
                            completion(nil,PdfExporterErrors.pdfEncryptionFailed)
                        }
                    }catch{
                        completion(nil,error)
                    }
                }
            }
        }
    }
    
    func zipAvailablePdfs(encryptionKey key: String?, zipFileName: String? = nil, completion: @escaping PdfExporterCompletionHandler){
        checkForZipFilesDirectory()
        
        guard documents.value.count > 0 else {
            return
            //            completion(nil,PdfExporterErrors.noAvailablePdfs)
        }
        
        unlockAllAvailablePdf(index: 0) {[weak self] unlockedDocuments, success in
            guard let _self = self else { return }
            if success{
                guard let unlockedDocuments = unlockedDocuments else { return }
                let zipPath = _self.getFilepath(outputFileName: zipFileName, fileType: .zipFile)
                
                if _self.fileExists(atPath: zipPath.path){
                    completion(nil,PdfExporterErrors.fileAlreadyExists)
                }
                
                let zipSuccess = SSZipArchive.createZipFile(atPath: zipPath.path, withFilesAtPaths: unlockedDocuments.map({ document in
                    (document.documentURL?.path)!
                }), withPassword: key != nil ? key : nil)
                
                if zipSuccess{
                    print("Zipping success")
                    completion(zipPath,nil)
                }else{
                    completion(nil,PdfExporterErrors.zipError)
                }
            }
        }
        
        
    }
    
    func flattenAvailablePdf(outputFileName: String? = nil, completion: @escaping PdfExporterCompletionHandler) {
        checkForMergedDocumentDirectory()
        
        guard documents.value.count > 0 else {
            return
            //            completion(nil,PdfExporterErrors.noAvailablePdfs)
        }
        
        unlockAllAvailablePdf(index: 0) {[weak self] unlockedDocuments, success in
            guard let _self = self else { return }
            if success{
                let filePath = _self.getFilepath(outputFileName: outputFileName, fileType: .flattenedPdf)
                if _self.fileExists(atPath: filePath.path){
                    completion(nil,PdfExporterErrors.fileAlreadyExists)
                    
                }
                _self.mergeAvailablePdfs(fileName: "temp"){ url, error in
                    guard let mergedDocumentUrl = url else { return }
                    do{
                        guard let unFlattenedDocument = PDFDocument(url: mergedDocumentUrl) else {
                            return
                            //                            completion(nil,PdfExporterErrors.urlError)
                        }
                        let flattenedDocument = unFlattenedDocument.flattened(withDPI: 72.0)
                        let success = flattenedDocument.write(to: filePath)
                        if success{
                            try _self.fileManager.removeItem(atPath: mergedDocumentUrl.path)
                            completion(filePath,nil)
                        }else{
                            completion(nil,PdfExporterErrors.pdfEncryptionFailed)
                        }
                        
                    }
                    catch{
                        completion(nil,error)
                    }
                }
            }
            
        }
    }
        
    func unlockAllAvailablePdf(index: Int,
                               completion: @escaping (([PDFDocument]?,Bool)-> Void)){
        if index == documents.value.count{
            completion([],true)
        }else{
            if let document = documents.value[index].pdf{
                if document.isLocked || document.isEncrypted{
                    
                    let alert = UIAlertController(title: "\(documents.value[index].fileName) is encrypted enter password to unlock", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { action in
                        completion(nil,false)
                    }))
                    alert.addTextField()
                    alert.addAction(UIAlertAction(title: "Unlock", style: .default, handler: { action in
                        let password = alert.textFields?.first?.text
                        let success = document.unlock(withPassword: password!)
                        if success{

                            if index == self.documents.value.count-1{
                                completion([document],true)
                            }else{
                                self.unlockAllAvailablePdf(index: index + 1) { documents, success in
                                    if success{
                                        var a = documents
                                        a?.insert(document, at: 0)
                                        completion(a,true)
                                    }
                                }
                            }
                        }else{
                            if index == self.documents.value.count-1{
                                completion(nil,false)
                            }
                        }
                        
                    }))
                    self.rootViewController?.present(alert, animated: true)
                }else{
                    completion([documents.value[index].pdf!],true)
                }
            }
        }
    }
    
    func presentAlertController(zDocument : ZDocument,completion : @escaping ((UIAlertAction) -> Void)){
        let alert = UIAlertController(title: "\(zDocument.fileName) is encrypted enter password to unlock", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { action in
            //            completion(nil,false)
        }))
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Unlock", style: .default, handler: { action in
            completion(action)
        }))
        rootViewController?.present(alert, animated: true)
    }
    
    func getFilepath(outputFileName: String?, fileType: OutputFileType) -> URL{
        
        switch fileType {
        case .mergedPdf:
            let fileName: String!
            
            if outputFileName != nil {
                fileName = outputFileName! + ".pdf"
                
            }else{
                let currentDate = Date()
                let createdTime = dateFormatter.string(from: currentDate)
                fileName = "Merged \(createdTime).pdf"
            }
            
            return mergedFilesDirectory.appendingPathComponent(fileName)
        case .zipFile:
            let fileName: String!
            
            if outputFileName != nil {
                fileName = outputFileName! + ".zip"
                
            }else{
                let currentDate = Date()
                let createdTime = dateFormatter.string(from: currentDate)
                fileName = "Zipped \(createdTime).zip"
            }
            
            return zipFilesDirectory.appendingPathComponent(fileName)
        case .encryptedPdf:
            let fileName: String!
            
            if outputFileName != nil {
                fileName = outputFileName! + ".pdf"
                
            }else{
                let currentDate = Date()
                let createdTime = dateFormatter.string(from: currentDate)
                fileName = "Encrypted \(createdTime).pdf"
            }
            
            return encryptedFilesDirectory.appendingPathComponent(fileName)
        case .flattenedPdf:
            let fileName: String!
            
            if outputFileName != nil {
                fileName = outputFileName! + ".pdf"
                
            }else{
                let currentDate = Date()
                let createdTime = dateFormatter.string(from: currentDate)
                fileName = "Flattened \(createdTime).pdf"
            }
            
            return mergedFilesDirectory.appendingPathComponent(fileName)
        }
    }
    
    func clearAllFileDirectories()throws {
        do{
            if fileManager.fileExists(atPath: mergedFilesDirectory.path, isDirectory: &isDir){
                try fileManager.removeItem(atPath: mergedFilesDirectory.path)
            }
            if fileManager.fileExists(atPath: encryptedFilesDirectory.path, isDirectory: &isDir){
                try fileManager.removeItem(atPath: encryptedFilesDirectory.path)
            }
            if fileManager.fileExists(atPath: zipFilesDirectory.path, isDirectory: &isDir){
                try fileManager.removeItem(atPath: zipFilesDirectory.path)
            }
        }catch{
            throw error
        }
    }
}

