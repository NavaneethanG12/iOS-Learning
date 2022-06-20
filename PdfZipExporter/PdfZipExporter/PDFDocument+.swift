//
//  PDFDocument+.swift
//  PdfZipExporter
//
//  Created by navaneeth-pt4855 on 17/06/22.
//

import Foundation
import PDFKit

extension PDFDocument {
   
       func addPages(from document: PDFDocument) {
           let pageCountAddition = document.pageCount
   
           for pageIndex in 0..<pageCountAddition {
               guard let addPage = document.page(at: pageIndex) else {
                   break
               }
   
               self.insert(addPage, at: self.pageCount)
           }
       }
   
   }
