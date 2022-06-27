//
//  Int_to_Array.swift
//  ConfirmIdentityPage
//
//  Created by navaneeth-pt4855 on 23/06/22.
//

import Foundation

extension Int{
    func array()-> [Int]{
        var digits: [Int] = []
                var num = self
                
                digits.append(num % 10)
                
                while num >= 10  {
                    num = num / 10
                    digits.append(num % 10)
                }
                
                return digits.reversed()
    }
}
