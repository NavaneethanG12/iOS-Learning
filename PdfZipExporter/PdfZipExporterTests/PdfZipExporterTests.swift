//
//  PdfZipExporterTests.swift
//  PdfZipExporterTests
//
//  Created by navaneeth-pt4855 on 23/06/22.
//

import XCTest
@testable import PdfZipExporter

class PdfZipExporterTests: XCTestCase {

    /*
     
    func test_unlocking_pdfs(){
        let vc = UIViewController()
        let sut = PdfExporter(rootVC: vc)
        
        let file1Url = URL(fileURLWithPath: "/Users/navaneeth-pt4855/Library/Developer/CoreSimulator/Devices/0B5A8EA2-9122-4FA9-83A9-3C14C329A8A4/data/Containers/Shared/AppGroup/8C096E8F-CBEE-4339-82CF-27B7CE1D949C/File Provider Storage/Downloads/Encrypted 1.pdf")
        let file2Url = URL(fileURLWithPath: "/Users/navaneeth-pt4855/Library/Developer/CoreSimulator/Devices/0B5A8EA2-9122-4FA9-83A9-3C14C329A8A4/data/Containers/Shared/AppGroup/8C096E8F-CBEE-4339-82CF-27B7CE1D949C/File Provider Storage/Downloads/Encrypted 2.pdf")
        let file3Url = URL(fileURLWithPath: "/Users/navaneeth-pt4855/Library/Developer/CoreSimulator/Devices/0B5A8EA2-9122-4FA9-83A9-3C14C329A8A4/data/Containers/Shared/AppGroup/8C096E8F-CBEE-4339-82CF-27B7CE1D949C/File Provider Storage/Downloads/Encrypted 3.pdf")
        let file4Url = URL(fileURLWithPath: "/Users/navaneeth-pt4855/Library/Developer/CoreSimulator/Devices/0B5A8EA2-9122-4FA9-83A9-3C14C329A8A4/data/Containers/Shared/AppGroup/8C096E8F-CBEE-4339-82CF-27B7CE1D949C/File Provider Storage/Downloads/Encrypted 4.pdf")
        
        let urls = [file1Url,file2Url,file3Url,file4Url]
        
        let promise = expectation(description: "unlocking documents")
        
        for url in urls {
            let document = ZDocument(fileName: url.lastPathComponent, fileUrl: url, filePath: url.path)
            sut.documents.value.append(document)
        }
        
        sut.unlockAllAvailablePdf(index: 0) { unlockedDocuments, failedIndeces, success in
            if success{
                guard let unlockedDocuments = unlockedDocuments else { return }
                for document in unlockedDocuments {
                    XCTAssertFalse(document.isLocked)
                }
                promise.fulfill()
            }
        }
        
        wait(for: [promise], timeout: 10000)
    }
     
     */

    func test_merging_pdfs_without_encryption(){
        let vc = UIViewController()
        let sut = PdfExporter(rootVC: vc)
        
        let file1Url = URL(fileURLWithPath: "/Users/navaneeth-pt4855/Library/Developer/CoreSimulator/Devices/0B5A8EA2-9122-4FA9-83A9-3C14C329A8A4/data/Containers/Shared/AppGroup/8C096E8F-CBEE-4339-82CF-27B7CE1D949C/File Provider Storage/Downloads/pdf.pdf")
        let file2Url = URL(fileURLWithPath: "/Users/navaneeth-pt4855/Library/Developer/CoreSimulator/Devices/0B5A8EA2-9122-4FA9-83A9-3C14C329A8A4/data/Containers/Shared/AppGroup/8C096E8F-CBEE-4339-82CF-27B7CE1D949C/File Provider Storage/Downloads/pdf-sample.pdf")
        let file3Url = URL(fileURLWithPath: "/Users/navaneeth-pt4855/Library/Developer/CoreSimulator/Devices/0B5A8EA2-9122-4FA9-83A9-3C14C329A8A4/data/Containers/Shared/AppGroup/8C096E8F-CBEE-4339-82CF-27B7CE1D949C/File Provider Storage/Downloads/sample.pdf")
        
        let urls = [file1Url,file2Url,file3Url]
        
        let promise = expectation(description: "unlocking documents")
        
        for url in urls {
            let document = ZDocument(fileName: url.lastPathComponent, fileUrl: url, filePath: url.path)
            sut.documents.value.append(document)
        }
        
        sut.mergeAvailablePdfs(fileName: "MyTestMerge") { url, error in
            
            if let error = error{
                XCTFail("Error occurred --- \(error.localizedDescription)")
            }
            
            
            guard let url = url else { XCTFail("No url returned")
                return
            }
            
            XCTAssertEqual("MyTestMerge.pdf", url.lastPathComponent)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 1000)
    }
    
    func test_flattenning_pdfs_without_encryption(){
        let vc = UIViewController()
        let sut = PdfExporter(rootVC: vc)
        
        let file1Url = URL(fileURLWithPath: "/Users/navaneeth-pt4855/Library/Developer/CoreSimulator/Devices/0B5A8EA2-9122-4FA9-83A9-3C14C329A8A4/data/Containers/Shared/AppGroup/8C096E8F-CBEE-4339-82CF-27B7CE1D949C/File Provider Storage/Downloads/pdf.pdf")
        let file2Url = URL(fileURLWithPath: "/Users/navaneeth-pt4855/Library/Developer/CoreSimulator/Devices/0B5A8EA2-9122-4FA9-83A9-3C14C329A8A4/data/Containers/Shared/AppGroup/8C096E8F-CBEE-4339-82CF-27B7CE1D949C/File Provider Storage/Downloads/pdf-sample.pdf")
        let file3Url = URL(fileURLWithPath: "/Users/navaneeth-pt4855/Library/Developer/CoreSimulator/Devices/0B5A8EA2-9122-4FA9-83A9-3C14C329A8A4/data/Containers/Shared/AppGroup/8C096E8F-CBEE-4339-82CF-27B7CE1D949C/File Provider Storage/Downloads/sample.pdf")
        
        let urls = [file1Url,file2Url,file3Url]
        
        let promise = expectation(description: "unlocking documents")
        
        for url in urls {
            let document = ZDocument(fileName: url.lastPathComponent, fileUrl: url, filePath: url.path)
            sut.documents.value.append(document)
        }
        
        sut.flattenAvailablePdf(outputFileName: "MyTestFlat") { url, error in
            
            if let error = error{
                XCTFail("Error occurred --- \(error.localizedDescription)")
            }
            
            guard let url = url else { XCTFail("No url returned")
                return
            }
            
            XCTAssertEqual("MyTestFlat.pdf", url.lastPathComponent)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 1000)
    }
}
