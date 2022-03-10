//
//  LandMarkDetails.swift
//  Landmark
//
//  Created by navaneeth-pt4855 on 04/03/22.
//

import SwiftUI
import CoreLocation

struct LandMarkDetails: View {
    
    var landmark: LandMark
    
    var body: some View {
        NavigationView{
            ScrollView {
                MapView(coordinate: landmark.locationCoordinate)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 300)
                
                CirlcleImage(image: landmark.image)
                    .offset(y: -130)
                    .padding(.bottom, -130)
                
                VStack(alignment: .leading) {
                    
                    Text(landmark.name)
                        .foregroundColor(.teal)
                        .fontWeight(.heavy)
                        .font(.title)
                    HStack {
                        Text(landmark.park)
                        Text(landmark.state)
                        
                    }
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    
                    Divider()
                    
                    Text("About \(landmark.name)")
                        .foregroundColor(.teal)
                        .fontWeight(.heavy)
                        .font(.title)
                    
                    Text(landmark.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    //                Spacer()
                }
                .padding()
            }
            .navigationTitle(landmark.name)
            //        .padding()
            //        Spacer()
        }
    }
    
}

struct LandMarkDetails_Previews: PreviewProvider {
    static var previews: some View {
        LandMarkDetails(landmark: landmarks[0])
    }
}
