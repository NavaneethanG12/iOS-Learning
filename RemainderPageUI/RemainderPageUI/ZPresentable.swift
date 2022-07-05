//
//  ZPresentable.swift
//  ZohoSignSDK
//
//  Created by somesh-8758 on 10/12/19.
//  Copyright © 2019 Zoho Corporation. All rights reserved.
//

import Foundation
import UIKit

public protocol ZPresentable {
    var direction: PresentationDirection { get }
    var popupHeight: CGFloat { get }
    var dimmingViewAlpha: CGFloat { get }
    var navBar: PresentationNavBar { get }
    var isBlurredDimmingView: Bool { get }
    var shouldApplyCornerRadius: Bool { get }
    var cornerRadius: CGFloat { get }
    var transitionAnimationDuration: TimeInterval { get }
}

public extension ZPresentable where Self: UIViewController{
    var direction: PresentationDirection {
        return .bottom
    }
    
    var popupHeight: CGFloat {
        return 420
    }
    
    var dimmingViewAlpha: CGFloat {
        return 0.5
    }
    
    var navBar: PresentationNavBar {
        return PresentationNavBar()
    }
    
    var isBlurredDimmingView: Bool {
        return false
    }
    
    var shouldApplyCornerRadius: Bool {
        return true
    }
    
    var cornerRadius: CGFloat {
        return 10
    }
    
    
    
    var transitionAnimationDuration: TimeInterval {
        let totalScreenHeight = UIScreen.main.bounds.height
        let viewYOrigin = (recursiveSuperView(forView: view) ?? view).frame.origin.y
        let distanceToBeAnimated = totalScreenHeight - viewYOrigin
        let animationFactor = distanceToBeAnimated / 250
        
        return TimeInterval((animationFactor < 250 ? 1 : animationFactor) * 0.3)
    }
}

extension ZPresentable where Self: UIViewController{
    public var bottomMargin: CGFloat {
        return view.window?.safeAreaInsets.bottom ?? 10
    }
    
    public func recursiveSuperView(forView view: UIView) -> UIView?{
        guard let superview = view.superview else {
            return nil
        }
       
        return !(superview is DragPresentationView) ? recursiveSuperView(forView: superview) : superview
    }
}

class DragPresentationView: UIView {
    init(with presentedView: UIView, frame: CGRect) {
        super.init(frame: frame)
        addSubview(presentedView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    var presentationContainerView: UIView? {
        return subviews.first(where: { view -> Bool in
            view is DragPresentationView
        })
    }
}
