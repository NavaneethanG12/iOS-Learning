//
//  PdfExporterErrors.swift
//  PdfZipExporter
//
//  Created by navaneeth-pt4855 on 20/06/22.
//

import Foundation

enum PdfExporterErrors: String, Error{
    case noAvailablePdfs
    case pdfEncryptionFailed
    case fileAlreadyExists
    case mergeError
    case zipError
    case urlError
}

extension PdfExporterErrors : LocalizedError{
    var errorDescription: String?{
        switch self {
        case .noAvailablePdfs:
            return "No available pdfs "
        case .pdfEncryptionFailed:
            return "Encrypting pdf failed"
        case .fileAlreadyExists:
            return "File already Exists"
        case .mergeError:
            return "Merging the Pdfs failed"
        case .zipError:
            return "Error while Zipping"
        case .urlError:
            return "Pdf Couldn't be made from the given urls or Error with urls"
        }
    }
}
