//
//  IntentHandler.swift
//  TriviaIntent
//
//  Created by navaneeth-pt4855 on 01/06/22.
//

import Intents

class GetRandomTriviaHandler: NSObject, GetRandomTriviaIntentHandling{
    
    
    func confirm(intent: GetRandomTriviaIntent, completion: @escaping (GetRandomTriviaIntentResponse) -> Void) {
        
        completion(GetRandomTriviaIntentResponse(code: .ready, userActivity: nil))
    }
    
    func handle(intent: GetRandomTriviaIntent, completion: @escaping (GetRandomTriviaIntentResponse) -> Void) {
        
        DataManager().getRandomTrivia { trivia in
            completion(.success(trivia: trivia))
        }
        
    }
    
    
}

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is GetRandomTriviaIntent else{
            fatalError("Unspecified Intent")
        }
        
        return GetRandomTriviaHandler()
    }
    
}
