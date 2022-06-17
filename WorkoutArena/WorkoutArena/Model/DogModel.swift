//
//  DogModel.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 08/06/22.
//

import Foundation

struct DogModel: Codable{
    
    var id: Int
    var name: String
    var bred_for: String?
    var breed_group: String?
    var life_span: String
    var temperament: String?
    var origin: String?
    
    var image: Image
    
}

struct Image: Codable{
    var id: String
    var width: Int
    var height: Int
    var url: String
}
