//
//  LockIcon.swift
//  ConfirmIdentityPage
//
//  Created by navaneeth-pt4855 on 24/06/22.
//

import SwiftUI

struct LockIcon: View{
    
    var iconName: String
    var bgColor: Color
    
    var body: some View{
        Image(iconName)
            .resizable()
            .scaledToFit()
            .frame(width: 26, height: 35)
            .aspectRatio(contentMode: .fit)
            .background(content: {
                Circle()
                    .frame(width: 71, height: 71)
                    .foregroundColor(bgColor)
            })
    .frame(width: 71, height: 71, alignment: .center)
    }
}
