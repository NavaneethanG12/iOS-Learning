//
//  PdfExporter.swift
//  PdfZipExporter
//
//  Created by navaneeth-pt4855 on 20/06/22.
//

import Foundation
import PDFKit
import SSZipArchive

class PdfExporter: NSObject{
    
    var fileManager = FileManager.default
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMYYHHmmss"
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .medium
        return formatter
    }()
    
    var documentUrls: Observable<[URL]> = Observable.init(value: [])
    
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
    
    override init() {
        super.init()
        
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
    
    func mergeAvailablePdfs(fileName: String? = nil) throws -> URL{
        checkForMergedDocumentDirectory()
        
        guard documentUrls.value.count > 0 else {
            throw PdfExporterErrors.noAvailablePdfs
        }
        let pdfDocument = PDFDocument()
        
        for url in documentUrls.value{
            guard let document = PDFDocument(url: url) else {
                throw PdfExporterErrors.urlError
            }
            pdfDocument.addPages(from: document)
        }
        
        let mergeFileName: String!
        
        if fileName != nil {
            mergeFileName = fileName! + ".pdf"
            
        }else{
            let currentDate = Date()
            
            let createdTime = dateFormatter.string(from: currentDate)
            
            mergeFileName = "Merged \(createdTime).pdf"
        }
        
        let filePath = mergedFilesDirectory.appendingPathComponent(mergeFileName)
        
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
    
    func encryptAvailablePdfs(encryptionKey key: String?, encryptFileName: String? = nil) throws -> URL {
        checkForEncryptedDirectory()
        
        guard documentUrls.value.count > 0 else {
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
        
        if fileExists(atPath: filePath.path){
            throw PdfExporterErrors.fileAlreadyExists
            
        }
        do{
            let mergedDocumentUrl = try mergeAvailablePdfs(fileName: "temp")
            guard let mergedDocument = PDFDocument(url: mergedDocumentUrl) else {
                throw PdfExporterErrors.urlError
            }
            let success = mergedDocument.write(to: filePath, withOptions: [.userPasswordOption: key!, .ownerPasswordOption: key!])
            if success{
                print("encryption success")
                try fileManager.removeItem(atPath: mergedDocumentUrl.path)
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
        checkForZipFilesDirectory()
        
        guard documentUrls.value.count > 0 else {
            throw PdfExporterErrors.noAvailablePdfs
        }
        let currentDate = Date()
        
        let createdTime = dateFormatter.string(from: currentDate)
        
        let fileName: String!
        
        if zipFileName != nil {
            fileName = zipFileName! + ".zip"
        }else{
            fileName = "Zipped \(createdTime).zip"
        }
        
        let zipPath = zipFilesDirectory.appendingPathComponent(fileName)
        
        if fileExists(atPath: zipPath.path){
            throw PdfExporterErrors.fileAlreadyExists
        }
        
        do{
            let zipSuccess = SSZipArchive.createZipFile(atPath: zipPath.path, withFilesAtPaths: documentUrls.value.map({ url in
                url.path
            }), withPassword: key != nil ? key : nil)
            
            if zipSuccess{
                print("Zipping success")
                return zipPath
            }else{
                throw PdfExporterErrors.zipError
            }
        }catch{
            print(error)
            throw error
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
