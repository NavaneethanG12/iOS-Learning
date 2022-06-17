//
//  ZButton.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 03/06/22.
//

import Foundation
import UIKit

class ZButton: UIButton {
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String, titleColor: UIColor, bgColor: UIColor, cornerRadius: CGFloat, target: Any?, action: Selector) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = bgColor
        self.addTarget(target, action: action, for: .touchUpInside)
        self.layer.cornerRadius = cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
