//
//  Colors.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 31/05/22.
//

import Foundation
import UIKit


struct Colors{
    public static let navBarColor = UIColor(red: 250/255, green: 238/255, blue: 231/255, alpha: 1)
    public static let navTintColor = UIColor(red: 50/255, green: 82/255, blue: 136/255, alpha: 1)
    public static let btnColor = UIColor(red: 6/255, green: 154/255, blue: 142/255, alpha: 1)
    public static let bgWhiteColor = UIColor.dynamicColor(light: UIColor(white: 1, alpha: 1), dark: UIColor(white: 0, alpha: 1))
    public static let primaryTextColor = UIColor.dynamicColor(light: UIColor(white: 0, alpha: 1), dark: UIColor(white: 1, alpha: 1))
}

extension UIColor{
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
            guard #available(iOS 13.0, *) else { return light }
            return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
        }
}
