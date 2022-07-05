//
//  PicsumModel.swift
//  SwifyUIBeginnerLearning
//
//  Created by navaneeth-pt4855 on 01/07/22.
//

import Foundation
import SwiftUI

struct PicsumModel: Codable, Hashable{
    
    var imageId: String
    var author: String
    var imageUrl: URL
    var width: Int
    var height: Int
    
    enum CodingKeys: String, CodingKey{
        case imageId = "id"
        case author
        case imageUrl = "download_url"
        case width
        case height
    }
}
