//
//  PresentationAnimator.swift
//  ZohoSignSDK
//
//  Created by somesh-8758 on 03/12/19.
//  Copyright © 2019 Zoho Corporation. All rights reserved.
//

import Foundation
import UIKit

enum TransitionStyle {
    case presentation
    case dismissal
}

class PresentationAnimator: NSObject {
    let direction: PresentationDirection
    let transitionStyle: TransitionStyle
    
    init(direction: PresentationDirection, transitionStyle: TransitionStyle) {
        self.direction = direction
        self.transitionStyle = transitionStyle
        super.init()
    }
}

extension PresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionStyle == .presentation ? 0.3 : 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch transitionStyle {
        case .presentation:
            animatePresentation(using: transitionContext)
        case .dismissal:
            animateDismissal(using: transitionContext)
        }
    }
    
    private func animatePresentation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
        let fromVC = transitionContext.viewController(forKey: .from) else {return}
        
        fromVC.beginAppearanceTransition(false, animated: true)
        if direction == .bottomWithCustomHeight {
//            HapticFeedbackGenerator.builder()
//                .setSelectionFeedback()
//                .build()
        }
        
        let presentationContainerView: UIView = transitionContext.containerView.presentationContainerView ?? toVC.view
        presentationContainerView.frame = transitionContext.finalFrame(for: toVC)
        
        let initialY: CGFloat
        let finalY: CGFloat = presentationContainerView.frame.origin.y
        switch direction {
        case .bottom,.bottomWithCustomHeight,.macFormSheet,.macPageSheet:
            initialY = transitionContext.containerView.frame.height
        case .macTopSheet,.macTopWithCustomHeight:
            initialY = -presentationContainerView.frame.height
        }
        presentationContainerView.frame.origin.y = initialY
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: [.curveEaseIn, .allowUserInteraction, .beginFromCurrentState], animations: {
            presentationContainerView.frame.origin.y = finalY
        }) { (_) in
            fromVC.endAppearanceTransition()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    private func animateDismissal(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
        let fromVC = transitionContext.viewController(forKey: .from) else {return}
    
        toVC.beginAppearanceTransition(true, animated: true)
        let presentationContainerView: UIView = transitionContext.containerView.presentationContainerView ?? fromVC.view
        
        let finalY: CGFloat
        switch direction {
        case .macTopWithCustomHeight,.macTopSheet:
            finalY = -presentationContainerView.frame.height
        case .macFormSheet,.macPageSheet,.bottom,.bottomWithCustomHeight:
            finalY = transitionContext.containerView.frame.height
        }

        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: [.curveEaseOut, .allowUserInteraction, .beginFromCurrentState], animations: {
            presentationContainerView.frame.origin.y = finalY
        }) { (_) in
//            NotificationCenter.default.post(name: .viewDismissedInCustomPresentation, object: nil)
            fromVC.view.removeFromSuperview()
            toVC.endAppearanceTransition()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
}
