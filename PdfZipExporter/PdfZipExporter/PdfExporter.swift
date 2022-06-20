//
//  PdfExporter.swift
//  PdfZipExporter
//
//  Created by navaneeth-pt4855 on 20/06/22.
//

import Foundation
import PDFKit

enum PdfExporterErrors: Error {
    case noAvailablePdfs
    case pdfEncryptionFailed
    case fileAlreadyExists
}

protocol PdfExporterDelegate{
    func pdfExporter(didFinishwitherror error: Alert, pdfExporter: PdfExporter)
}

class PdfExporter: NSObject{
    
    var fileManager = FileManager.default
    
    var delegate: PdfExporterDelegate?
    
    var documents: Observable<[PDFDocument]> = Observable.init(value: [])
    
    private(set) var encryptedFilesDirectory: URL{
        get{
        return fileManager.getEncryptedDirectory()
        }
        set{
            // setter is private
        }
    }
    
    func createEncryptedDirectory(){
        fileManager.createEncryptedDirectory()
    }
    
    func createMergedDocumentDirectory(){
        fileManager.createMergedDocumentDirectory()
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
        
        if documents.value.count == 0{
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
            
            let formatter = DateFormatter();
            
            formatter.timeStyle = .short
            formatter.dateStyle = .medium
            
            let createdTime = formatter.string(from: currentDate)
            
            fileName = "Encrypted \(createdTime).pdf"
        }
        
        
        
        let filePath = encryptedFilesDirectory.appendingPathComponent(fileName)

        print(filePath)
        
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
    
    func encryptAvailablePdfs(encryptionKey key: String?, encryptFileName: String? = nil) throws {
        
        let fileName: String!
        
        if encryptFileName != nil {
            fileName = encryptFileName! + ".pdf"
            
        }else{
            let currentDate = Date()
            
            let formatter = DateFormatter();
            
            formatter.timeStyle = .short
            formatter.dateStyle = .medium
            
            let createdTime = formatter.string(from: currentDate)
            
            fileName = "Encrypted \(createdTime).pdf"
        }
        
        
        
        let filePath = encryptedFilesDirectory.appendingPathComponent(fileName)

        print(filePath)
        
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
            }else{
                throw PdfExporterErrors.pdfEncryptionFailed
            }
        }catch{
            print(error)
        }
        
    }
    
}
