//
//  PopUpViewController.swift
//  RemainderPageUI
//
//  Created by navaneeth-pt4855 on 28/06/22.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class PopUpViewController: UIViewController{
    
    typealias BtnHandler = (()-> Void)
    
    var model: BottomModel?
    var customPopUpHeight: CGFloat = 0
    
    var completion: BtnHandler?
    
    convenience init(model: BottomModel){
        self.init()
        self.model = model
        
        print("Pop up view Controller inited")
    }
    
    override func loadView() {
        super.loadView()
        print("Pop up view controller will load")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print("pop up view controller did load")
        view.backgroundColor = ZColor.bgColorWhite
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Pop up view controller will appear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("Pop up view controller will layout subviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("Pop up view controller did layout subviews")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Pop up view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("Pop up view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("Pop up view did disappear")
    }
    
    func setupView(){
        let icon = UIImageView(image: UIImage(named: model?.iconName ?? ""))
        icon.contentMode = .center
        icon.backgroundColor = UIColor(Color.bgGray)
        
        view.addSubview(icon)
        
        customPopUpHeight += 57.35
        
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(57.35)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(71)
        }
        icon.layoutIfNeeded()
        icon.layer.cornerRadius = 71/2.0
        
        customPopUpHeight += icon.frame.height
        
        let titleLabel = UILabel()
        titleLabel.text = model?.title
        titleLabel.textColor = ZColor.blackColor
        titleLabel.font = ZSFont.headerFont
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon.snp.bottom).offset(23)
        }
        titleLabel.layoutIfNeeded()
        
        customPopUpHeight += (titleLabel.frame.height + 23)
        
        let description = UITextView()
        description.text = model?.description
        description.textColor = ZColor.blackColor
        description.font = ZSFont.listValueFont
        description.textAlignment = .center
        description.isEditable = false
        description.isScrollEnabled = false
        description.sizeToFit()
        
        view.addSubview(description)
        
        description.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
            make.width.equalTo(339)
        }
        
        description.layoutIfNeeded()
        customPopUpHeight += (description.frame.height + 7)
        
        let bottomBtn = UIButton()
        bottomBtn.setTitle(model?.btnTitle, for: .normal)
        bottomBtn.setTitleColor(ZColor.whiteColor, for: .normal)
        bottomBtn.backgroundColor =  UIColor(model?.btnColor ?? Color.btnColorRed)
        bottomBtn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        
        view.addSubview(bottomBtn)
        
        bottomBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(description.snp.bottom).offset(33)
            make.height.equalTo(48)
            make.width.equalToSuperview().multipliedBy(0.75)
        }
        bottomBtn.layoutIfNeeded()
        bottomBtn.layer.cornerRadius = 48/2.0
        customPopUpHeight += (bottomBtn.frame.height + 33)
        
        customPopUpHeight += 50
    }
    
    @objc func btnAction(_ sender: UIButton){
        
        /*

        let backgroundQueue = DispatchQueue(label: "Background", qos: .background, attributes: .concurrent)
        print(Thread.current)
        
        
        
        DispatchQueue.main.async {
            print(Thread.current)
//            self.dismiss(animated: true)
        }

        backgroundQueue.async {
            print(Thread.current)
            
            DispatchQueue.main.async {
                print(Thread.current)
    //            self.dismiss(animated: true)
            }
            DispatchQueue.main.async {
                print(Thread.current)
    //            self.dismiss(animated: true)
            }
        }
        
        backgroundQueue.sync {
            print(Thread.current)
        }
//        completion?() */
        
        weak var _self = self
        dismiss(animated: true) {
            _self?.completion?()
        }
    }
    
    deinit{
        print("popup view controller deinited")
    }
    
}

extension PopUpViewController: ZPresentable{
    var popupHeight: CGFloat{
        customPopUpHeight
    }
    
    var direction: PresentationDirection{
        .bottomWithCustomHeight
    }
    
    var dimmingViewAlpha: CGFloat{
        0.1
    }
}
