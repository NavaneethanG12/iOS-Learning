//
//  BottomModel.swift
//  RemainderPageUI
//
//  Created by navaneeth-pt4855 on 28/06/22.
//

import Foundation
import SwiftUI

struct BottomModel{
    
    var iconName: String
    var title: String
    var description: String
    var btnTitle: String
    var btnColor: Color
    
    
    init(iconName: String, title: String, description: String, btnTitle: String, btnColor: Color) {
        self.iconName = iconName
        self.title = title
        self.description = description
        self.btnTitle = btnTitle
        self.btnColor = btnColor
    }
}
