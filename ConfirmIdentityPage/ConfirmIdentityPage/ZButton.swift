//
//  ZButton.swift
//  ConfirmIdentityPage
//
//  Created by navaneeth-pt4855 on 23/06/22.
//

import SwiftUI

struct ZButton: View{
    
    var bgColor: Color
    var strokeColor: Color?
    
    var title: String
    var titleColor: Color
    
    var completion: (()->Void)
    
    var body: some View{
        Button {
            completion()
        } label: {
            Text(title)
                .font(.system(size: 18))
                .padding()
                .foregroundColor(titleColor)
                .frame(width: 160, height: 48)
        }.background {
            if let strokeColor = strokeColor {
                RoundedRectangle(cornerRadius: 65).strokeBorder(strokeColor, lineWidth: 1.5)
            }else{
                bgColor
                    .clipShape(RoundedRectangle(cornerRadius: 65))
                    
            }
//            Capsule().stroke(lineWidth: 1.5)
        }
        
        
    }
    
}

//struct ZButton_Preview: PreviewProvider{
//    static var previews: some View{
//        HStack{
//            ZButton(bgColor: .buttonColor, strokeColor: nil, title: "Verify", titleColor: .white)
//
//            ZButton(bgColor: .white, strokeColor: .buttonColor, title: "Resend Code", titleColor: .black)
//        }
//    }
//}
