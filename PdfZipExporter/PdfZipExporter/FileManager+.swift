//
//  FileManager+.swift
//  PdfZipExporter
//
//  Created by navaneeth-pt4855 on 18/06/22.
//

import Foundation

extension FileManager{
    func getDocumentDirectory() -> URL{
        return self.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func getMergedDocumentDirectory() -> URL{
        let dirPath = getDocumentDirectory().appendingPathComponent("MergedDocuments")
        
        return dirPath
    }
    
    func createMergedDocumentDirectory(){
        
        let dirPath = getDocumentDirectory().appendingPathComponent("MergedDocuments").path
        
        do {
            try FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
            print("MergedDocuments Directory created Successfully")
        } catch {
            print(error)
        }
    }
    
    func createZipFilesDirectory(){
        let dirPath = getDocumentDirectory().appendingPathComponent("ZipFiles").path
        
        do {
            try FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
            print("ZipFiles Directory created Successfully")
        } catch {
            print(error)
        }
    }
    
    func getZipFilesDirectory() -> URL{
        let dirPath = getDocumentDirectory().appendingPathComponent("ZipFiles")
        
        return dirPath
    }
    
    func createEncryptedDirectory(){
        let dirPath = getDocumentDirectory().appendingPathComponent("EncryptedDocuments").path
        
        do {
            try FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
            print("EncryptedDocuments Directory created Successfully")
        } catch {
            print(error)
        }
    }
    
    func getEncryptedDirectory() -> URL{
        let dirPath = getDocumentDirectory().appendingPathComponent("EncryptedDocuments")
        
        return dirPath
    }
    
}
