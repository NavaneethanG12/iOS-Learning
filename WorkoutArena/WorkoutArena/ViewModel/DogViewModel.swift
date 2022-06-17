//
//  DogViewModel.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 09/06/22.
//

import Foundation
import SVProgressHUD


class DogViewModel{
    
    var model: Observable<[DogModel]> = Observable(value: [])
    
    let dataManager = DataManager()
    
    init(){
        
    }
    
    func fetchModel(urlString: String = "https://api.thedogapi.com/v1/breeds", completion: ((Any)->())? = nil){
        SVProgressHUD.show(withStatus: "Loading")
        dataManager.fetchData(urlString: urlString, type: [DogModel].self) {[weak self] value in
            guard let value = value as? [DogModel] else {
                return
            }
            self?.model.value = value
            if let completion = completion {
                completion(value)
            }
            SVProgressHUD.dismiss()
//            print(value)
        }
    }
}
