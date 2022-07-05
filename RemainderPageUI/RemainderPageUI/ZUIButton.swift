//
//  ZUIButton.swift
//  RemainderPageUI
//
//  Created by navaneeth-pt4855 on 28/06/22.
//

import SwiftUI

struct ZUIButton: View{
    
    var bgColor: Color
    var strokeColor: Color?
    
    var title: String
    var titleColor: Color
    
    var completion: (()->Void)
    
    var body: some View{
        Button {
            completion()
        } label: {
//            GeometryReader{ geo in
                Text(title)
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(titleColor)
                    .frame(maxWidth: .infinity , minHeight: 48, idealHeight: 48, maxHeight: 48)
                    .background {
                        if let strokeColor = strokeColor {
                            RoundedRectangle(cornerRadius: 65).strokeBorder(strokeColor, lineWidth: 1.5)
                        }else{
                            bgColor
                                .clipShape(RoundedRectangle(cornerRadius: 65))
                                
                        }
                    }
                    .padding()
//            }
            
                
        }
        
        
    }
    
}


struct ZUIButton_Previews: PreviewProvider {
    static var previews: some View {
        ZUIButton(bgColor: .red, title: "jhhue", titleColor: .white) {
            print("hgcfhc")
        }
    }
}
