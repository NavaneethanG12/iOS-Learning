//
//  PresentationManager.swift
//  ZohoSignSDK
//
//  Created by somesh-8758 on 03/12/19.
//  Copyright © 2019 Zoho Corporation. All rights reserved.
//

import Foundation
import UIKit

public struct PresentationBarSize {
    public static let noTitleBig: CGFloat = 25
    public static let noTitleSmall: CGFloat = 10
    public static let withTitleSmall: CGFloat = 44
    public static let withTitleBig: CGFloat = 64
    public static let withTitleAndSubtitle: CGFloat = 80

}

public enum PresentationDirection {
    //for iphone and ipad
    case bottom
    case bottomWithCustomHeight
    
    //for mac
    case macFormSheet
    case macPageSheet
    case macTopSheet
    case macTopWithCustomHeight
}


public struct PresentationNavBar {
    public var size: CGFloat
    public var title: String?
    public var subtitle: String?
    public var titleAlignment: NSTextAlignment
    public var backgroundColor: UIColor
    public var isBackButtonAvailable: Bool
    public init(size: CGFloat = PresentationBarSize.noTitleBig, title: String? = nil,subtitle : String? = nil, titleAlignment: NSTextAlignment = .center, backgroundColor: UIColor = .white, isBackButtonAvailable: Bool = false) {
        self.size = size
        self.title = title
        self.subtitle = subtitle
        self.titleAlignment = titleAlignment
        self.backgroundColor = backgroundColor
        self.isBackButtonAvailable = isBackButtonAvailable
    }
}

public class PresentationManager: NSObject {
    // MARK: - Properties
    public var disableCompactHeight = true
    var presentationController: PresentationController!
}

extension PresentationManager: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        presentationController = PresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.delegate = self
        return presentationController
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentationAnimator(direction: presentationController.presentable.direction, transitionStyle: .presentation)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let obj = PresentationAnimator(direction: presentationController.presentable.direction, transitionStyle: .dismissal)
        presentationController = nil
        return obj
    }
    
    /*
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return direction == .bottomWithCustomHeight && presentationController.interactor.hasStarted ? presentationController.interactor : nil
    }
    */
}

extension PresentationManager: UIAdaptivePresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        if traitCollection.verticalSizeClass == .compact && disableCompactHeight {
            return .overFullScreen
        } else {
            return .none
        }
    }
    
    public func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        guard case(.overFullScreen) = style else { return nil }
        
        return controller.presentedViewController
    }
}
