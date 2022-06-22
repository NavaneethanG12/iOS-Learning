//
//  ZDocument.swift
//  PdfZipExporter
//
//  Created by navaneeth-pt4855 on 21/06/22.
//

import Foundation
import PDFKit

class ZDocument{
    
    var fileName: String
    var fileUrl: URL
    var filePath: String
    
    var pdf: PDFDocument?{
        return PDFDocument(url: fileUrl)
    }
    
    internal init(fileName: String, fileUrl: URL, filePath: String) {
        self.fileName = fileName
        self.fileUrl = fileUrl
        self.filePath = filePath
    }
}
