//
//  PdfExporter.swift
//  PdfZipExporter
//
//  Created by navaneeth-pt4855 on 20/06/22.
//

import Foundation
import PDFKit
import SSZipArchive

enum PdfExporterErrors: String, Error{
    case noAvailablePdfs
    case pdfEncryptionFailed
    case fileAlreadyExists
    case mergeError = "Merging the files failed"
    case zipError = "Zipping failed"
}

protocol PdfExporterDelegate{
    func pdfExporter(didFinishwitherror error: Alert, pdfExporter: PdfExporter)
}

class PdfExporter: NSObject{
    
    var fileManager = FileManager.default
    
    var delegate: PdfExporterDelegate?
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var documents: Observable<[PDFDocument]> = Observable.init(value: [])
    
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
    
    override init() {
        super.init()
        
        createEncryptedDirectory()
        createMergedDocumentDirectory()
        createZipFilesDirectory()
    }
    
    private func createEncryptedDirectory(){
        fileManager.createEncryptedDirectory()
    }
    
    private func createMergedDocumentDirectory(){
        fileManager.createMergedDocumentDirectory()
    }
    
    private func createZipFilesDirectory(){
        fileManager.createZipFilesDirectory()
    }
    
    func fileExists(atPath: String) -> Bool{
        return fileManager.fileExists(atPath: atPath)
    }

    
    func mergePdf(documents: [PDFDocument]) -> PDFDocument{
        let pdfDocument = PDFDocument()
        
        for document in documents{
            pdfDocument.addPages(from: document)
        }
        
        return pdfDocument
    }
    
    func mergeAvailablePdfs() throws -> PDFDocument{
        
        guard documents.value.count > 0 else {
            throw PdfExporterErrors.noAvailablePdfs
        }
        
        let pdfDocument = PDFDocument()
        
        for document in documents.value{
            pdfDocument.addPages(from: document)
        }
        
        return pdfDocument
    }
    
    func encryptPdf(for document: PDFDocument, encryptionKey key: String?, encryptFileName: String? = nil) throws {
        
        let fileName: String!
        
        if encryptFileName != nil {
            fileName = encryptFileName! + ".pdf"
            
        }else{
            let currentDate = Date()
            
            let createdTime = dateFormatter.string(from: currentDate)
            
            fileName = "Encrypted \(createdTime).pdf"
        }
        
        
        
        let filePath = encryptedFilesDirectory.appendingPathComponent(fileName)

//        print(filePath)
        
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
    
    func encryptAvailablePdfs(encryptionKey key: String?, encryptFileName: String? = nil) throws -> URL {
        
        guard documents.value.count > 0 else {
            throw PdfExporterErrors.noAvailablePdfs
        }
        
        let fileName: String!
        
        if encryptFileName != nil {
            fileName = encryptFileName! + ".pdf"
            
        }else{
            let currentDate = Date()
        
            let createdTime = dateFormatter.string(from: currentDate)
            
            fileName = "Encrypted \(createdTime).pdf"
        }
        
        
        
        let filePath = encryptedFilesDirectory.appendingPathComponent(fileName)

//        print(filePath)
        
        if fileExists(atPath: filePath.path){
            throw PdfExporterErrors.fileAlreadyExists
//            delegate?.pdfExporter(didFinishwitherror: .fileExists("File Already exists"), pdfExporter: self)
//            return
        }
        do{
            let mergedDocument = try mergeAvailablePdfs()
            let success = mergedDocument.write(to: filePath, withOptions: [.userPasswordOption: key!, .ownerPasswordOption: key!])
            if success{
                print("encryption success")
                return filePath
            }else{
                throw PdfExporterErrors.pdfEncryptionFailed
            }
        }catch{
            print(error)
            throw error
        }
        
    }
    
    func zipAvailablePdfs(encryptionKey key: String?, zipFileName: String? = nil) throws -> URL{
        
        guard documents.value.count > 0 else {
            throw PdfExporterErrors.noAvailablePdfs
        }
        let currentDate = Date()
    
        let createdTime = dateFormatter.string(from: currentDate)
        
        let fileName: String!
        
        if zipFileName != nil {
            fileName = zipFileName! + ".zip"
            
        }else{
            
            fileName = "Merged \(createdTime).zip"
        }
        
        let zipPath = zipFilesDirectory.appendingPathComponent(fileName)

//        print(zipPath)
        
        if fileExists(atPath: zipPath.path){
            throw PdfExporterErrors.fileAlreadyExists

        }
        
        let mergedFilePath = mergedFilesDirectory.appendingPathComponent("Merged \(createdTime).pdf")
        
        do{
            let mergedDocument = try mergeAvailablePdfs()
            let success = mergedDocument.write(to: mergedFilePath)
            if success{
                print("Merged Pdf Successfully created")
                let zipSuccess = SSZipArchive.createZipFile(atPath: zipPath.path, withFilesAtPaths: [mergedFilePath.path], withPassword: key)
    
                if zipSuccess{
                    print("Zipping success")
                    try fileManager.removeItem(atPath: mergedFilePath.path)
                    return zipPath
                }else{
                    throw PdfExporterErrors.zipError
                }
                
            }else{
                throw PdfExporterErrors.mergeError
            }
        }catch{
            
            print(error)
            throw error
        }
    }
}
