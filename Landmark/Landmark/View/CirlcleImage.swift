//
//  CirlcleImage.swift
//  Landmark
//
//  Created by navaneeth-pt4855 on 04/03/22.
//

import SwiftUI

struct CirlcleImage: View {
    
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .frame(height: 250)
            .scaledToFit()
            .clipShape(Circle())
            .overlay{
                Circle()
                    .stroke(.red, lineWidth: 2)
//                    .frame(height: 200)
            }
            .shadow(radius: 10)
            
    }
}

struct CirlcleImage_Previews: PreviewProvider {
    static var previews: some View {
        CirlcleImage(image: Image("silversalmoncreek"))
    }
}
