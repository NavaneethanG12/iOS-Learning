//
//  DataManager.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 31/05/22.
//

import Foundation
import UIKit
import Alamofire


class DataManager{
    
    typealias imageFetchCompletion = ((UIImage, Int) -> Void)
    typealias randomTriviaCompletion = ((String) -> Void)
    
    func fetchImageWithDataTask(with urlString: String, index: Int,  completion: @escaping imageFetchCompletion){
        
        let request = AF.request(urlString)
        
        request.responseData { data in
            if let data = data.value{
                let image = UIImage(data: data)
                completion(image ?? UIImage(), index)
            }
        }
        
    }
    
    func fetchImageWithGCD(with urlString: String, index: Int) -> UIImage? {
        
        _ = self.isCodeOnMainThread(named: "start GCD image \(index) downloading...")
        
//        print("Start downloading image \(index)")
        let imageURL = URL(string: urlString)
        
        let imageData = NSData(contentsOf: imageURL!)
        
        let image = UIImage(data: imageData! as Data)
        
        return image
        
    }
    
    func isCodeOnMainThread(named codeDescription:String) -> Bool {
            if Thread.isMainThread {
                print("\(codeDescription) ON MAIN THREAD")
                return true
            } else {
                print("\(codeDescription) ON BACKGROUND THREAD")
                return false
            }
        }
    
    func getRandomTrivia(completion: @escaping randomTriviaCompletion){
        
        let urlString = "http://numbersapi.com/random/trivia"
        
        let request = AF.request(urlString)
        
        request.responseData { data in
            if let data = data.value{
                let trivia = String(data: data, encoding: .utf8)
                    completion(trivia ?? "Fetch Error")
            }
        }
    }
}
