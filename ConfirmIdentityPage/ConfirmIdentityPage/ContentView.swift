//
//  ContentView.swift
//  ConfirmIdentityPage
//
//  Created by navaneeth-pt4855 on 23/06/22.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var otpModel = OtpViewModel()
    @State var t: [String] = []
    
    @State var masterOtp = "123456"
    
    @State var lockIcon = "lock_icon"
    @State var bgColor: Color = .bgGray
    @State var showError: Bool = false
    
    var body: some View {
        VStack{
            if showError{
                LockIcon(iconName: lockIcon, bgColor: bgColor)
                .animation(Animation.default.repeatCount(3).speed(3))
            }else{
                LockIcon(iconName: lockIcon, bgColor: bgColor)
            }
            
            Text("Confirm Identity")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.init(top: 23, leading: 10, bottom: 7, trailing: 10))
            
            Text("Please enter the authentication code shared to your email.")
                .font(.system(size: 15))
                .foregroundColor(.listSubtitleColor)
                .frame(width: 238, height: 40, alignment: .center)
                .lineLimit(2)
                .multilineTextAlignment(TextAlignment.center)
            
            if showError{
                Text("Look like authentication code incorrect.")
                    .font(.system(size: 15))
                    .foregroundColor(.red)
                    .animation(Animation.default.repeatCount(5).speed(6))
                
                AuthFieldsView()
                    .environmentObject(otpModel)
                    .padding(.top, 29)
                    .onChange(of: otpModel.otpFields) { newValue in
                        for index in 0...5{
                            if newValue[index].count == 0{
                                lockIcon = "lock_icon"
                                bgColor = .bgGray
                                showError = false
                            }
                        }
                    }
            }else{
                Text("Look like authentication code incorrect.")
                    .hidden()
                    .font(.system(size: 15))
                    .foregroundColor(.red)
                
                AuthFieldsView()
                    .environmentObject(otpModel)
                    .padding(.top, 29)
                    .onChange(of: otpModel.otpFields) { newValue in
                        for index in 0...5{
                            if newValue[index].count == 0{
                                lockIcon = "lock_icon"
                                bgColor = .bgGray
                                showError = false
                            }
                        }
                    }
            }
            
            
            
            HStack{
                ZButton(bgColor: .buttonColor, strokeColor: nil, title: "Verify", titleColor: .white) {
                    if otpModel.otpFields.joined(separator: "") == masterOtp{
                        print("success")
                    }else{
                        lockIcon = "lock_error_icon"
                        bgColor = .bgColorRed
                        showError = true
                            
                    }
                }
                
                ZButton(bgColor: .white, strokeColor: .buttonColor, title: "Resend Code", titleColor: .black) {
                    masterOtp = generateRandomDigits(6)
                    print("Master OTP --- \(masterOtp)")
                }
            }
            .padding(.init(top: 74, leading: 0, bottom: 0, trailing: 0))
        }
       
        
        
    }
    
    func generateRandomDigits(_ digitNumber: Int) -> String {
        var number = ""
        for i in 0..<digitNumber {
            var randomNumber = arc4random_uniform(10)
            while randomNumber == 0 && i == 0 {
                randomNumber = arc4random_uniform(10)
            }
            number += "\(randomNumber)"
        }
        return number
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
