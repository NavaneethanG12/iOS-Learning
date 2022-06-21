//
//  FileManager+.swift
//  PdfZipExporter
//
//  Created by navaneeth-pt4855 on 18/06/22.
//

import Foundation

extension FileManager{
    func getCacheDirectory() -> URL{
        return self.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    
    func getMergedDocumentDirectory() -> URL{
        let dirPath = getCacheDirectory().appendingPathComponent("MergedDocuments")
        
        return dirPath
    }
    
    func createMergedDocumentDirectory(){
        
        let dirPath = getCacheDirectory().appendingPathComponent("MergedDocuments").path
        
        do {
            try FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
            print("MergedDocuments Directory created Successfully")
        } catch {
            print(error)
        }
    }
    
    func createZipFilesDirectory(){
        let dirPath = getCacheDirectory().appendingPathComponent("ZipFiles").path
        
        
        do {
            try FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
            print("ZipFiles Directory created Successfully")
        } catch {
            print(error)
        }
    }
    
    func getZipFilesDirectory() -> URL{
        let dirPath = getCacheDirectory().appendingPathComponent("ZipFiles")
        
        return dirPath
    }
    
    func createEncryptedDirectory(){
        let dirPath = getCacheDirectory().appendingPathComponent("EncryptedDocuments").path
        
        do {
            try FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
            print("EncryptedDocuments Directory created Successfully")
        } catch {
            print(error)
        }
    }
    
    func getEncryptedDirectory() -> URL{
        let dirPath = getCacheDirectory().appendingPathComponent("EncryptedDocuments")
        
        return dirPath
    }
    
}
