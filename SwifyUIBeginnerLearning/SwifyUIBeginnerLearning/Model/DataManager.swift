//
//  DataManager.swift
//  SwifyUIBeginnerLearning
//
//  Created by navaneeth-pt4855 on 01/07/22.
//

import Foundation

class DataManager{
    
     static let shared = DataManager()
    
    private init(){
        
    }
    
    func getPicsumImages(_ urlString: String) async -> [PicsumModel]? {
        guard let url = URL(string: urlString) else { return nil }
        do{
        let (data, _) = try await URLSession.shared.data(from: url)
            let model = try JSONDecoder().decode([PicsumModel].self, from: data)
            return model
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
}
