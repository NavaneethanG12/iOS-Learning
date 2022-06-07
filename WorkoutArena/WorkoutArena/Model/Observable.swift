//
//  Observable.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 03/06/22.
//

import Foundation


class Observable<T>{
    
    typealias Listener = ((T)-> Void)
    var listener: Listener?
    
    var value: T{
        didSet{
            listener?(value)
        }
    }
    
    init(value: T){
        self.value = value
    }
    
    func bind(listener: Listener?){
        self.listener = listener
        self.listener?(value)
    }
}
