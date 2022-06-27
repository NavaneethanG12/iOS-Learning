//
//  AuthFieldsView.swift
//  ConfirmIdentityPage
//
//  Created by navaneeth-pt4855 on 23/06/22.
//

import SwiftUI

struct AuthFieldsView: View{
    
    @EnvironmentObject var otpModel: OtpViewModel
    
    @FocusState private var fieldInFocus: OtpField?
    
    @State var otp: [Int] = []
    
    var body: some View{
        HStack(spacing: 8){
            
            ForEach(0..<otpModel.otpFields.count, id: \.self){ index in
                ZStack{
                    RoundedRectangle(cornerRadius: 11)
                                .fill(Color.bgGray)
                                .frame(width: 44, height: 54)
                    TextField("", text: $otpModel.otpFields[index])
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($fieldInFocus, equals: activeStateForIndex(index: index))
                        .frame(width: 15, height: 28, alignment: .center)
                        .font(.system(size: 23))
                        
                }
                .tag(index)
                
                }
                
            }.onChange(of: otpModel.otpFields) { newValue in
                OtpConditon(value: newValue)
        }
    }
    
    
    func OtpConditon(value: [String]){
        for index in 0..<5{
            if value[index].count == 1 && fieldInFocus == activeStateForIndex(index: index){
                fieldInFocus = activeStateForIndex(index: index + 1)
            }
        }
        
        for index in 1..<6{
            if value[index].count == 0 && fieldInFocus == activeStateForIndex(index: index){
                fieldInFocus = activeStateForIndex(index: index - 1)
            }
        }
        
        for index in 0...5{
            if value[index].count > 1{
                otpModel.otpFields[index] = String(value[index].last!)
            }
        }
    }
        
    
    func activeStateForIndex(index: Int)-> OtpField{
        switch index{
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        case 3: return .field4
        case 4: return .field5
        default: return .field6
        }
    }
}

enum OtpField{
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
}

struct AuthFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        AuthFieldsView()
            .environmentObject(OtpViewModel.init())
    }
}
