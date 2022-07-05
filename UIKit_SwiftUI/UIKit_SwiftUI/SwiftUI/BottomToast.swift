//
//  BottomToast.swift
//  UIKit_SwiftUI
//
//  Created by navaneeth-pt4855 on 28/06/22.
//

import SwiftUI

struct BottomToast: View {
    
    var iconName: String
    var toastMessage: String
    
    var body: some View {
        HStack{
            
        }
    }
}

struct BottomToast_Previews: PreviewProvider {
    static var previews: some View {
        BottomToast(iconName: "resent", toastMessage: "The authentication code has been resent to your email.")
    }
}
