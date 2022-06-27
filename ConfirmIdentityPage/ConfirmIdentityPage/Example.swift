//
//  Example.swift
//  ConfirmIdentityPage
//
//  Created by navaneeth-pt4855 on 24/06/22.
//

import SwiftUI

struct Example: View {
    var body: some View {
        VStack{
            Image("image")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
        }
    }
}

struct Example_Previews: PreviewProvider {
    static var previews: some View {
        Example()
            .previewInterfaceOrientation(.landscapeRight)
        Example()
            .preferredColorScheme(.dark)
    }
}
