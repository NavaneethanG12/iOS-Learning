//
//  OtpViewModel.swift
//  ConfirmIdentityPage
//
//  Created by navaneeth-pt4855 on 23/06/22.
//

import Foundation

class OtpViewModel: ObservableObject, Equatable{
    static func == (lhs: OtpViewModel, rhs: OtpViewModel) -> Bool {
        let value = (lhs.otpFields == rhs.otpFields) && (lhs.otpText == rhs.otpText)
        return value
    }
    
    @Published var otpText: String = ""
    @Published var otpFields: [String] = Array(repeating:" ", count: 6)
    
}
