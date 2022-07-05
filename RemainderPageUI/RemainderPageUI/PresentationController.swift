//
//  PresentationController.swift
//  ZohoSignSDK
//
//  Created by somesh-8758 on 03/12/19.
//  Copyright © 2019 Zoho Corporation. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class PresentationController: UIPresentationController {
    internal lazy var presentable: ZPresentable = {
        if let nav = presentedViewController as? UINavigationController{
            if let presentable = nav.viewControllers.first as? ZPresentable {
                return presentable
            } else {
                fatalError("\(String(describing: nav.viewControllers.first.self)) should implement ZPresentable")
            }
        } else if let presentable = presentedViewController as? ZPresentable {
            return presentable
        } else {
            fatalError("\(String(describing: presentedViewController.self)) should implement ZPresentable")
        }
    }()
    
    private lazy var presentationContainerView: DragPresentationView = {
        let view = DragPresentationView(with: presentedViewController.view, frame: frameOfPresentedViewInContainerView)
        return view
    }()
    
    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.alpha = 0.0
        if #available(iOS 13, macCatalyst 13, *), presentable.isBlurredDimmingView {
            let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
            visualEffectView.bounds = view.bounds
            visualEffectView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
            view.addSubview(visualEffectView)
        } else {
            view.backgroundColor = UIColor(white: 0.0, alpha: presentable.dimmingViewAlpha)
        }
        let recogniser = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(recogniser)
        return view
    }()
    
    private lazy var dragIndicatorView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 5))
        view.layer.cornerRadius = 2.5
        view.clipsToBounds = true
        view.backgroundColor = UIColor.separator
        return view
    }()
    
    override var presentedView: UIView {
        return presentationContainerView
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerViewSize = self.containerView?.bounds.size else {return .zero}
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerViewSize)
        switch presentable.direction {
            
        case .bottom:
            frame.origin.y = containerViewSize.height * 0.06
        case .bottomWithCustomHeight:
            frame.origin.y = containerViewSize.height - frame.size.height
            
        case .macPageSheet,.macFormSheet:
            frame.origin = CGPoint(x: (containerViewSize.width - frame.size.width)/2, y: (containerViewSize.height - frame.size.height)/2)
        case .macTopSheet,.macTopWithCustomHeight:
            frame.origin = CGPoint(x: (containerViewSize.width - frame.size.width)/2, y: 0)
            
        }
        return frame
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        let maxPopupHeight = (containerView?.frame.height ?? 0) * 0.9
        var viewHeight = presentable.popupHeight
        if presentable.popupHeight > maxPopupHeight {
            viewHeight = maxPopupHeight
        }
        switch presentable.direction {
        case .bottom:
            return CGSize(width: parentSize.width, height: parentSize.height*0.94)
        case .bottomWithCustomHeight:
            return CGSize(width: parentSize.width, height: viewHeight)
            
        case .macTopWithCustomHeight:
            return CGSize(width: 600, height: viewHeight)
        case .macPageSheet:
            return .sizeForPageSheet
        case .macFormSheet:
            return .sizeForFormSheet
        case .macTopSheet:
            return .sizeForTopSheet
        }
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.insertSubview(dimmingView, at: 0)
        dimmingView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        presentedView.frame.size = frameOfPresentedViewInContainerView.size
        containerView?.addSubview(presentedView)
        
        if presentable.direction == .bottomWithCustomHeight {
            addPresentationNavBar(inView: presentedView)
            addPangesture(toView: presentedView)
        }
        
        setPresentedViewFrame(forDirection: presentable.direction)
        
        if presentable.shouldApplyCornerRadius {
            presentedView.layer.cornerRadius = presentable.cornerRadius
            presentedView.clipsToBounds = true
        }
        self.presentedView.backgroundColor = presentable.navBar.backgroundColor.resolvedColor(with: traitCollection)
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 1.0
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        }, completion: nil)
    }
    
    @objc private func dismissView(){
        if presentable.direction == .bottomWithCustomHeight {
            presentedViewController.dismiss(animated: true)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13, *), traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection){
            self.presentedView.backgroundColor = presentable.navBar.backgroundColor.resolvedColor(with: traitCollection)
        }
    }
    
    
    @objc private func handlePanGesture(_ sender: UIPanGestureRecognizer){
        let percentThreshold:CGFloat = 0.4
        let presentedView: UIView! = sender.view

        let frameOfPresentedView = frameOfPresentedViewInContainerView
        let progress = (presentedView.frame.origin.y - frameOfPresentedView.origin.y) / frameOfPresentedView.height
        
        switch sender.state {
        case .began,.changed:
            let translation = sender.translation(in: presentedView)
            presentedView.frame.origin.y = max(presentedView.frame.origin.y + translation.y, frameOfPresentedViewInContainerView.origin.y)
            animateDimmingView(forProgress: 1-progress)
        case .failed,.cancelled,.ended:
            if progress > percentThreshold {
                UIView.animate(withDuration: presentable.transitionAnimationDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [.curveEaseInOut,.allowUserInteraction,.beginFromCurrentState], animations: {
                    presentedView.frame.origin.y = self.containerView?.frame.height ?? 0
                    self.dimmingView.alpha = 0
                }) { (_) in
                    self.presentedViewController.dismiss(animated: true)
                }
            } else {
                UIView.animate(withDuration: presentable.transitionAnimationDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [.curveEaseInOut], animations: {
                    presentedView.frame.origin.y = frameOfPresentedView.origin.y
                    self.dimmingView.alpha = 1
                }, completion: nil)
            }
            break
        default:
            break
        }
        
        sender.setTranslation(.zero, in: presentedView)
        /*
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        guard let interactor = interactor, progress != 0 else { return }
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            presentedViewController.dismiss(animated: true)
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()
        default:
            break
        }
        */
    }
    
    func animateDimmingView(forProgress progress: CGFloat){
        dimmingView.alpha = progress
    }
}

extension PresentationController {
    
    private func setPresentedViewFrame(forDirection direction: PresentationDirection) {
        presentedViewController.view.frame = presentedView.bounds
        switch direction {
        case .bottomWithCustomHeight:
            presentedViewController.view.frame.origin.y += presentable.navBar.size
            presentedViewController.view.frame.size.height -= presentable.navBar.size
        default:
            break
        }
    }
    
    private func addPresentationNavBar(inView view: UIView) {
        let dragIndicatorContainerView = UIView()
        dragIndicatorContainerView.addSubview(dragIndicatorView)
        dragIndicatorView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(6)
            make.height.equalTo(5)
            make.width.equalTo(36)
        }
        
        
        
        if let title = presentable.navBar.title {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textColor = ZColor.primaryTextColor
            titleLabel.font = ZSFont.navTitleFontLarge
            titleLabel.textAlignment = presentable.navBar.titleAlignment
            dragIndicatorContainerView.addSubview(titleLabel)
            
            
            if let subtitle = presentable.navBar.subtitle {
                let subtitleLabel = UILabel()
                subtitleLabel.text = subtitle
                subtitleLabel.textColor = ZColor.secondaryTextColorDark
                subtitleLabel.font = ZSFont.navigationSubTitleFont
                subtitleLabel.textAlignment = presentable.navBar.titleAlignment
                subtitleLabel.numberOfLines = 2
                dragIndicatorContainerView.addSubview(subtitleLabel)
                
                titleLabel.snp.makeConstraints { (make) in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(20)
                }
                
                subtitleLabel.snp.makeConstraints { (make) in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(titleLabel.snp.bottom).offset(4)
                }
                
                
                
            }else{
                titleLabel.snp.makeConstraints { (make) in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview().offset(11/2)
                }
            }
            
            if presentable.navBar.isBackButtonAvailable{
                let backButton = UIButton()
                backButton.setBackgroundImage(UIImage(named: "nav_back"), for: .normal)
                backButton.contentMode = .scaleAspectFit
                backButton.addTarget(self, action: #selector(dismissPresentedVc), for: .touchUpInside)
                dragIndicatorContainerView.addSubview(backButton)
                backButton.snp.makeConstraints { make in
                    make.centerY.equalTo(titleLabel)
                    make.leading.equalToSuperview().offset(19)
                    make.height.equalTo(14)
                    make.width.equalTo(8)
                }
                
            }
//            dragIndicatorContainerView.addBorders(edges: [.bottom], color: UIColor.separator, inset: 0, thickness: 0.4)
            //TODO: - check borders
        }
        
        
        view.addSubview(dragIndicatorContainerView)
        dragIndicatorContainerView.snp.makeConstraints { (make) in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(presentable.navBar.size )
        }
    }
    
    @objc func dismissPresentedVc(){
        self.presentedViewController.dismiss(animated: true)
    }
    
    private func addPangesture(toView view: UIView) {
        let pangesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(pangesture)
    }
}
