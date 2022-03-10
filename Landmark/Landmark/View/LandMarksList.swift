//
//  LandMarksList.swift
//  Landmark
//
//  Created by navaneeth-pt4855 on 04/03/22.
//

import SwiftUI

struct LandMarksList: View {
    var body: some View {
        NavigationView{
            List(landmarks, id: \.id){ landmark in
                NavigationLink{
                    LandMarkDetails(landmark: landmark)
                } label: {
                    LandMarkRow(landmark: landmark)
                }
            
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct LandMarksList_Previews: PreviewProvider {
    static var previews: some View {
        LandMarksList()
    }
}
