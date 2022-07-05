//
//  CommonExtensions.swift
//  RemainderPageUI
//
//  Created by navaneeth-pt4855 on 28/06/22.
//

import Foundation
import UIKit

public extension CGSize {
    //for mac
    static let sizeForFormSheet = CGSize(width: 540, height: 564)
    static let sizeForPageSheet = CGSize(width: 500, height: 700)
    static let sizeForTopSheet = CGSize(width: 1000, height: 800)
    
    //for all
    init(withSide side: CGFloat) {
        self.init(width: side, height: side)
    }
    
    static func a4Size(_ width: CGFloat) -> CGSize{
        return CGSize(width: width, height: width * 1.414)
    }
}


//
//  ZColor.swift
//  ZohoSignSDK
//
//  Created by Nagarajan S on 08/10/18.
//  Copyright © 2018 Zoho Corporation. All rights reserved.
//

import UIKit
import AVFoundation
import UIKit

public struct ZColor {

    /*public static var bgColorWhite      =  UIColor.setAppearance(dark: UIColor.secondarySystemBackground, light:  UIColor.white)
    public static var bgColorGray       =   UIColor.systemGroupedBackground//.setAppearance(dark: UIColor.secondarySystemBackground, light:  UIColor.systemGroupedBackground)
    public static var homeBgColor       = UIColor.setAppearance(dark: UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0), light: UIColor(red:0.99, green:0.99, blue:0.99, alpha:1.00))

    public static var seperatorColor    =  UIColor.setAppearance(dark: UIColor.separator, light: UIColor(red:0.88, green:0.88, blue:0.89, alpha:1.00))
    
    public static var ipadListSeperatorColor    =  UIColor.setAppearance(dark: UIColor.opaqueSeparator.withAlphaComponent(0.35), light: UIColor.opaqueSeparator.withAlphaComponent(0.24))
    
    public static var seperatorColorLight = UIColor.opaqueSeparator//.setAppearance(dark:  UIColor.opaqueSeparator, light: UIColor(red: 0.89, green: 0.90, blue: 0.93, alpha: 0.5))
    public static var tintColor        =  UIColor.setAppearance(dark: ZColor.whiteColor, light: ZColor.blueColor)
    public static var listSelectionColor = UIColor.setAppearance(dark: UIColor(red:0.22, green:0.23, blue:0.24, alpha:1.00),light: UIColor(red: 0.86, green: 0.91, blue: 0.97, alpha: 1.00))
    
    
    public static var primaryTextColor         =  UIColor.label
    public static var primaryTextColorLight    =  UIColor.label
    public static var secondaryTextColorDark   =   UIColor.secondaryLabel
    public static var secondaryTextColorLight  =   UIColor.tertiaryLabel
    public static var disableColorLight        =   UIColor(red: 0.82, green: 0.84, blue: 0.89, alpha: 1.00)
    
    public static var tableHeaderTextColor = UIColor(red:0.36, green:0.36, blue:0.36, alpha:1.00)
    public static var tabBarColor          = UIColor.setAppearance(dark: UIColor.systemGroupedBackground, light: UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1))
    
    public static var suggestionViewBgColor     = UIColor.tertiarySystemBackground

    public static var ipadRightSideBarColor     = UIColor.setAppearance(dark: UIColor.tertiarySystemGroupedBackground, light: UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.00))
    
    
    
    
    public static var shimmeringGridBackgroundColor = UIColor.setAppearance(dark: .systemGray5, light: .systemGroupedBackground)
    public static var shimmeringListBackgroundColor = UIColor.setAppearance(dark: .tertiarySystemBackground, light: UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1))
    public static var shimmeringGridViewColor = UIColor.setAppearance(dark: UIColor.systemGray4.withAlphaComponent(0.6) ,light: UIColor(red: 0.90, green: 0.90, blue: 0.94, alpha: 0.9))
    public static var shimmeringCollectionViewColor = UIColor.setAppearance(dark: .systemGray4, light: UIColor(red: 0.87, green: 0.89, blue: 0.93, alpha: 1))
    public static var shimmeringCollectionAndTableBackgroundColor = UIColor.setAppearance(dark: .tertiarySystemBackground, light: UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1))
    public static var shimmeringDraftBackgroundColor = UIColor.setAppearance(dark: .systemGray5 , light: UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.5))
    public static var shimmeringIpadDocslistBackgroundColor = UIColor.setAppearance(dark: .systemGray5, light:#colorLiteral(red: 0.9264881015, green: 0.9266433716, blue: 0.9264676571, alpha: 0.8137929137))
    
    public static var tableHeaderBgColor = ZColor.bgColorGray
    public static var ipadDocsListColor    = ZColor.bgColorWhite

    
    if DeviceType.isMac{
        ZColor.ipadSideBarTextColor  =  .setAppearance(dark: UIColor.label, light: UIColor(red:0.25, green:0.25, blue:0.25, alpha:1.00))

        ZColor.ipadLeftSideBarColor = nil
        ZColor.bgColorGray = .setAppearance(dark: UIColor(red:0.16, green:0.16, blue:0.18, alpha:1.00), light:  UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.00))
        ZColor.ipadRightSideBarColor     = .setAppearance(dark: UIColor(red:0.12, green:0.13, blue:0.13, alpha:1.00), light: UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.00))
        ZColor.ipadListSeperatorColor    =  UIColor.setAppearance(dark: UIColor.opaqueSeparator.withAlphaComponent(0.04), light: UIColor.opaqueSeparator.withAlphaComponent(0.24))
        ZColor.ipadDocsListColor  =  ZColor.bgColorGray

    }

    override init() {
    }
     */
    
    //custom colors
    public static let  greyColor =   UIColor(red: 0.59, green: 0.62, blue: 0.66, alpha: 1)
    public static let  redColor =  UIColor(red: 0.875, green: 0, blue: 0.42, alpha: 1)//UIColor(red:0.93, green:0.30, blue:0.24, alpha:1.00)
    public static let  greenColor =   UIColor(red: 0.431, green: 0.796, blue: 0.388, alpha: 1)//UIColor(red: 0.55, green: 0.82, blue: 0.49, alpha: 1)
    public static let  blackColor =   UIColor.black
    public static let  whiteColor =   UIColor.white
    public static let  blueColor =   UIColor(red:0.19, green:0.48, blue:0.96, alpha:1.00)
    
    
    
    public static var isNightModeOn = false
    public static var  bgColorWhite  =   UIColor.setAppearance(dark: UIColor.secondarySystemBackground, light:  UIColor.white)
    public static var commentBackgroundColor = UIColor(red: 244/255, green: 244/255, blue: 242/255, alpha: 1)
    
    public static var  contentBackgroundColor =  UIColor(red: 0.918, green: 0.961, blue: 0.906, alpha: 1)// UIColor(red: 0.953, green: 0.969, blue: 0.957, alpha: 1)//UIColor(red:0.96, green:0.97, blue:0.96, alpha:1.00)
    public static var  contentBackgroundColorDark =   UIColor(red: 0.918, green: 0.961, blue: 0.906, alpha: 1)//UIColor(red: 0.878, green: 0.917, blue: 0.888, alpha: 1)

    public static var  bgColorGray  =   UIColor.setAppearance(dark: UIColor.secondarySystemBackground, light:  UIColor.white)

    public static var ipadRightSideBarColor     = UIColor.setAppearance(dark: UIColor.tertiarySystemGroupedBackground, light: UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.00))

    public static var  tintColor      =  UIColor(red: 0.094, green: 0.647, blue: 0.345, alpha: 1)// UIColor(red: 0.012, green: 0.757, blue: 0.58, alpha: 1)


    public static var  navBarColor      =   ZColor.bgColorGray

    public static var  listSelectionColor = UIColor(red: 0.86, green: 0.91, blue: 0.97, alpha: 1.00)
    
    // Newly Added
        
        public static let upgradeButtonColor = UIColor(red: 255/255, green: 1/255, blue: 143/255, alpha: 1)
        public static let planUpgradeCellColor = UIColor(red: 133/255, green: 247/255, blue: 221/255, alpha: 1)
        public static let textColor = UIColor(red: 10/255, green: 29/255, blue: 97/255, alpha: 1)
        public static var  titleTextColor = UIColor(red: 9/255, green: 29/255, blue: 96/255, alpha: 1.00)
    public static var subTitleTextColor = UIColor(red: 9/255, green: 29/255, blue: 96/255, alpha: 0.5)
        public static var bgColorSkin = UIColor(red: 247/255, green: 249/255, blue: 246/255, alpha: 1.0)
        public static var outlineGreen = UIColor(red: 3/255, green: 193/255, blue: 148/255, alpha: 1.0)
    public static var signOutColor = UIColor(red: 237/255, green: 78/255, blue: 130/255, alpha: 1.0)
    public static var bgColorDark = UIColor(white: 0, alpha: 0.9)
    public static var overviewBackgroundColor = UIColor(white: 0, alpha: 0.3)
    public static var iapGrayColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)

        
    //Text colors
    
    public static var  primaryTextColor = UIColor.black//  UIColor.setAppearance(dark: .label, light: UIColor(red: 0.035, green: 0.114, blue: 0.376, alpha: 1))
    public static var  secondaryTextColorDark = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)//UIColor(red:0.55, green:0.56, blue:0.62, alpha:1.00)
//=======
//    public static var  primaryTextColor =  UIColor.setAppearance(dark: .label, light: UIColor(red: 0.035, green: 0.114, blue: 0.376, alpha: 1))
//    public static var  secondaryTextColorDark = UIColor(red: 0.035, green: 0.114, blue: 0.376, alpha: 0.5)
//>>>>>>> 103ce570232b87781880eae665c74867bb7b942c
    public static var  secondaryTextColorLight = UIColor(red: 0.035, green: 0.114, blue: 0.376, alpha: 0.3)
    public static var  seperatorColor =   UIColor.setAppearance(dark: UIColor.separator, light: UIColor(red: 0.035, green: 0.114, blue: 0.376, alpha: 0.1))
    
    public static var  seperatorColorLight = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1)
   

    public static var tableHeaderTextColor = secondaryTextColorDark

    public static var  buttonColor = tintColor

    public static var  suggestionViewBgColor = UIColor(red: 0.94, green: 0.96, blue: 0.99, alpha: 1)
    public static var  notifyBgColor = UIColor(red:0.18, green:0.16, blue:0.20, alpha:1.00)
    
    public static var descriptionEmailAttributeColor = tintColor
    public static var descritpionTextColor = UIColor(red: 102, green: 102, blue: 102, alpha: 1.0)
    
    public struct TabbarColor{
        public static var  background = UIColor(red:0.18, green:0.18, blue:0.23, alpha:1.00)
        public static var  normalTintColor = UIColor(red:0.67, green:0.67, blue:0.69, alpha:1.00)
        public static var  selectedTintColor = ZColor.tintColor

    }
    


    public struct StatusColor{
        //status colors
        public static let  draft      =   UIColor(red:0.46, green:0.78, blue:0.96, alpha:1.00)
        public static let  inprogress  =   UIColor(red:0.97, green:0.82, blue:0.30, alpha:1.00)
        public static let  completed =   greenColor
        public static let  expiring =   UIColor(red: 1, green: 0.24, blue: 0, alpha: 1)//UIColor(red: 0.97, green: 0.58, blue: 0.37, alpha: 1)
        public static let  expired  =   UIColor(red: 0.875, green: 0, blue: 0.42, alpha: 1)//UIColor(red: 0.78, green: 0.33, blue: 0.47, alpha: 1)
        public static let  recalled =   UIColor(red: 0.24, green: 0.41, blue: 0.56, alpha: 1)
        public static let  trash    =   UIColor(red: 0.63, green: 0.59, blue: 0.59, alpha: 1)
        public static let  declined =   redColor
        
    }

       
    public struct ShimmeringViewColor{
//        public static var  gridBackground = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.5)
//        public static var  listBackground = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
//        public static var  gridView = UIColor(red: 0.90, green: 0.90, blue: 0.94, alpha: 0.7)
//        public static var  collectionAndTableBackground = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
//        public static var  collectionViewColor = UIColor(red: 0.87, green: 0.89, blue: 0.93, alpha: 1)
//        public static var  draftBackground = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.5)
//        public static var ipadDocslistBackground = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.5)
    }
    

   
    
    
    // Advanced Search
//        public static var borderColor      = UIColor(red:0.88, green:0.88, blue:0.89, alpha:1.00)
//
//        //Recent Search
//        public static var keywordTextColor = UIColor.lightGray
//        public static var searchTextColor  = UIColor.black
//
    
    //MARK:- Helpers
    public static func hexString(fromColor : UIColor) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        fromColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    
    public static func color(hexString : String) -> UIColor {
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        return  UIColor(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    static let recepientColors : [RecepientColorSet] =  {
        let blueColor = RecepientColorSet(selectedColor: UIColor(red:0.28, green:0.53, blue:0.91, alpha:1.00), unSelectedColor: UIColor(red:0.86, green:0.91, blue:0.98, alpha:1.00))
        let greenColor = RecepientColorSet(selectedColor: UIColor(red:0.43, green:0.87, blue:0.70, alpha:1.00), unSelectedColor: UIColor(red:0.90, green:1.00, blue:0.97, alpha:1.00))
        let darkYellowColor = RecepientColorSet(selectedColor: UIColor(red:0.97, green:0.80, blue:0.33, alpha:1.00), unSelectedColor: UIColor(red:0.98, green:0.88, blue:0.83, alpha:1.00))
        let purpleColor = RecepientColorSet(selectedColor: UIColor(red:0.68, green:0.42, blue:0.83, alpha:1.00), unSelectedColor: UIColor(red:0.86, green:0.91, blue:0.98, alpha:1.00))
        let yellowColor = RecepientColorSet(selectedColor: UIColor(red:0.89, green:0.83, blue:0.28, alpha:1.00), unSelectedColor: UIColor(red:1.00, green:0.99, blue:0.83, alpha:1.00))
        let skyblueColor = RecepientColorSet(selectedColor: UIColor(red:0.42, green:0.89, blue:0.90, alpha:1.00), unSelectedColor: UIColor(red:0.88, green:1.00, blue:1.00, alpha:1.00))
        let violetColor = RecepientColorSet(selectedColor:  UIColor(red:0.28, green:0.53, blue:0.91, alpha:1.00), unSelectedColor: UIColor(red:0.86, green:0.91, blue:0.98, alpha:1.00))
        let lightGreenColor = RecepientColorSet(selectedColor:  UIColor(red:0.43, green:0.87, blue:0.70, alpha:1.00), unSelectedColor: UIColor(red:0.90, green:1.00, blue:0.97, alpha:1.00))
        
        return [blueColor,greenColor,darkYellowColor,purpleColor,yellowColor,skyblueColor,violetColor,lightGreenColor]
    }()
}


public struct RecepientColorSet{
    public var selectedColor : UIColor
    public var unSelectedColor : UIColor
}



//
//  ZSFont.swift
//  ZohoSignSDK
//
//  Created by Nagarajan S on 16/10/18.
//  Copyright © 2018 Zoho Corporation. All rights reserved.
//

import UIKit

public struct ZSFont {
    
    fileprivate static var currentFontStyle : ZohoSignAppFont {
        return ZohoSignAppFont(type: FontType(rawValue: ZSUserDefaults.preferredFontName)!)
    }
    
    public static var navTitleFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .largeTitle)
    }

    public static var navTitleFontLarge: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .title1)
    }

    public static var navigationSubTitleFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .caption1)
    }
    
    public static var tableHeaderFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .caption2)
    }

    public static var bodyFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .body)
    }

    public static var footnoteFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .footnote)
    }

    public static var listTitleFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .subheadline)
    }

    public static var listSubtitleFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .body)
    }

    public static var listKeyFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .body)
    }

    public static var listValueFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .body)
    }

    public static var buttonFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .subheadline)
    }

    public static var homeSegmentFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .body)
    }
    public static var homeSegmentSelectedFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .body)
    }
    
    public static var contactImageNameFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .body)
    }
    
    
    public static var headerFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .headline)
    }

    public static var createListKeyFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .caption2)
    }
    

    public static var createListValueFont: UIFont{
        currentFontStyle.preferredFont(forTextStyle: .body)
    }

    
}



//
//  FontProperties.swift
//  ZohoSignSDK
//
//  Created by Nagarajan S on 08/06/22.
//

import Foundation
import UIKit

enum FontType: String {
    case system = "system"
    case helveticaNeue = "HelveticaNeue"
}


struct ZSUserDefaults {
    @UserDefaultWrapper("Preferred Font", defaultValue: FontType.system.rawValue)
    public static var preferredFontName: String
    
}



struct FontProperties {
    
    static func styleDictionary(forType type: FontType) -> FontStyleDictionary {
        switch type {
        case .helveticaNeue:
            return self.helveticaNeueStyle()
        case .system:
            return [:]
        }
    }
    
    //MARK: DYNAMIC FONT PROPERTIES
    private static func helveticaNeueStyle() -> FontStyleDictionary {
        return [
            .largeTitle: .init(fontSize: 22, fontName: "Inter-Bold"),
            .title1: .init(fontSize: 20, fontName: "Inter-Bold"),
            .title2: .init(fontSize: 18, fontName: "Inter-SemiBold"),
            .title3: .init(fontSize: 16, fontName: "Inter-SemiBold"),
            .headline: .init(fontSize: 16, fontName: "Inter-Bold"),
            .subheadline: .init(fontSize: 16, fontName: "Inter-SemiBold"),
            .body: .init(fontSize: 15, fontName: "Inter-Regular"),
            .callout: .init(fontSize: 16, fontName: "Inter-Regular"),
            .footnote: .init(fontSize: 14, fontName: "Inter-Regular"),
            .caption1: .init(fontSize: 12, fontName: "Inter-Regular"),
            .caption2: .init(fontSize: 12, fontName: "Inter-Medium")
        ]
    }
}

struct FontDescription {
    let fontSize: CGFloat
    let fontName: String
}

typealias FontStyleDictionary = [UIFont.TextStyle: FontDescription]


class ZohoSignAppFont {
    private var styleDictionary: FontStyleDictionary
    
    init(type: FontType) {
        styleDictionary = FontProperties.styleDictionary(forType: .helveticaNeue)
    }
    
    public func staticFont(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        guard let fontDescription = styleDictionary[textStyle],
            let font = UIFont(name: fontDescription.fontName, size: fontDescription.fontSize) else {
            return UIFont.preferredFont(forTextStyle: textStyle) //Dynamic system font will be handled here
        }
        
        return font
    }
    
    public func preferredFont(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        guard let fontDescription = styleDictionary[textStyle],
            let font = UIFont(name: fontDescription.fontName, size: fontDescription.fontSize) else {
            return UIFont.preferredFont(forTextStyle: textStyle) //Dynamic system font will be handled here
        }
        
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        return fontMetrics.scaledFont(for: font)
    }
}

//class StaticFont {
//    private var styleDictionary: FontStyleDictionary
//    init(type: FontType) {
//        styleDictionary = FontProperties.styleDictionary(forType: .helveticaNeue)
//    }
//
//    public func preferredFont(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
//
//        guard let fontDescription = styleDictionary[textStyle],
//            let font = UIFont(name: fontDescription.fontName, size: fontDescription.fontSize) else {
//            return UIFont.preferredFont(forTextStyle: textStyle) //Dynamic system font will be handled here
//        }
//
//        return font
//    }
//}


//
//  UserDefault.swift
//  ZohoSignSDK
//
//  Created by somesh-8758 on 04/05/20.
//  Copyright © 2020 Zoho Corporation. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefaultWrapper<T> {
    var key: String
    var defaultValue: T
    
    /// Property wrapper for Handling UserDefaults
    /// - Parameters:
    ///   - key: it is used to fetch the correspoding value stored in the UserDefaults Table.
    ///   - defaultValue: it will be subtituted when the value for a given key is not found.
    public init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get{
            UserDefaults.standard.value(forKey: key) as? T ?? defaultValue
        }
        set {
            
            if (newValue is String || newValue is Data || newValue is Bool || newValue is Int){
                UserDefaults.standard.set(newValue, forKey: key)
            }else{
                UserDefaults.standard.removeObject(forKey: key)
            }
            UserDefaults.standard.synchronize()
        }
    }
}




//
//  UIColor+.swift
//  ZohoSignSDK
//
//  Created by somesh-8758 on 24/12/19.
//  Copyright © 2019 Zoho Corporation. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    @available(iOS 13, *)
    static func setAppearance(dark: UIColor,light: UIColor) -> UIColor {
        return UIColor {(trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                return dark
            } else {
                return light
            }
        }
    }
    
    static func setColor(dark: UIColor,light: UIColor) -> UIColor {
        if #available(iOS 13, *){
            return .setAppearance(dark: dark, light: light)
        } else {
            return light
        }
    }
    
    func resolveDynamicColor(with traitCollection: UITraitCollection) -> UIColor{
        if #available(iOS 13, *){
            return resolvedColor(with: traitCollection)
        } else {
            return self
        }
    }
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: rgb >> 16 & 0xFF,
            green: rgb >> 8 & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
}
