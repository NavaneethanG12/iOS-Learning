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
    
    func flattened(withDPI dpi: CGFloat) -> PDFDocument {
        let flattenedDocument = PDFDocument()
        for pageIndex in 0..<pageCount {
            if let oldPage = page(at: pageIndex),
               let flattenedPage = PDFPage(image: oldPage.image(withDPI: dpi)) {
                flattenedDocument.insert(flattenedPage, at: flattenedDocument.pageCount)
            }
        }
        return flattenedDocument
    }
    
}


extension PDFPage {
    func image(withDPI dpi: CGFloat) -> UIImage {
        let pageRect = bounds(for: .mediaBox)
        let dpiRatio = dpi / 72  // Default DPI is 72
        let scaleTransform = CGAffineTransform(scaleX: dpiRatio, y: dpiRatio)
        let imageSize = pageRect.size.applying(scaleTransform)
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        return renderer.image { ctx in
            ctx.cgContext.saveGState()
            ctx.cgContext.translateBy(x: 0, y: imageSize.height)
            ctx.cgContext.scaleBy(x: dpiRatio, y: -dpiRatio)
            draw(with: .mediaBox, to: ctx.cgContext)
            ctx.cgContext.restoreGState()
        }
    }
}



