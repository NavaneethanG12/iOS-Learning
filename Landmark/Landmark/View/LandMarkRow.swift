//
//  LandMarkRow.swift
//  Landmark
//
//  Created by navaneeth-pt4855 on 04/03/22.
//

import SwiftUI

struct LandMarkRow: View {
    var landmark: LandMark
    
    var body: some View {
        HStack{
            landmark.image
                .resizable()
                .clipShape(Circle())
                .frame(width: 50, height: 50)
                .overlay {
                    Circle()
                        .stroke(.gray, lineWidth: 2)
                }
                .shadow(radius: 2)
            Text(landmark.name)
//                .font(.title)
            Spacer()
            
            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
        .padding()
        
    }
}

struct LandMarkRow_Previews: PreviewProvider {
    static var previews: some View {
        LandMarkRow(landmark: landmarks[1])
            .previewLayout(.fixed(width: 300, height: 70))
        LandMarkRow(landmark: landmarks[0])
            .previewLayout(.fixed(width: 300, height: 70))
        
    }
}
