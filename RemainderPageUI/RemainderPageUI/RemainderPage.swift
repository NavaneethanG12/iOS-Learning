//
//  RemainderPage.swift
//  RemainderPageUI
//
//  Created by navaneeth-pt4855 on 28/06/22.
//

import SwiftUI

protocol RemainderPageDelegate: NSObject{
    func btnDidClicked()
}

struct RemainderPage: View {
   
    typealias btnHandler = (()->Void)
    
    var model: BottomModel
    
    @State var customPopUpHeight: CGFloat = 400
    
    var completion: btnHandler?
    
    init(model: BottomModel, completion: RemainderPage.btnHandler? = nil, bindingHeight: Binding<CGFloat> = .constant(0.0)) {
        self.model = model
        self.completion = completion
    }
    
 
    
    var body: some View {
        GeometryReader{proxy in
            VStack{
                
                ImageIcon(fillColor: Color.bgGray, imageName: model.iconName)

                Text(model.title)
                    .padding(.init(top: 23, leading: 0, bottom: 7, trailing: 0))
                    .font(.system(size: 20, weight: .bold, design: .default))
                
                descriptionTest(text: model.description)
                
                ZUIButton(bgColor: model.btnColor, title: model.btnTitle, titleColor: .white) {
                    completion?()
                }
                .onAppear{
                    customPopUpHeight = proxy.size.height
                }
                
            }
            .frame( maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        }
    }
    
    public func setPopUpHeight(height: Binding<CGFloat>){
        
    }
    
    fileprivate func ImageIcon(fillColor: Color, imageName: String)-> some View{
        ZStack{
            Circle()
                .fill(fillColor)
                .frame(width: 71, height: 71, alignment: .center)
            Image(imageName)
        }.padding(.top, 57.35)
    }
    
    fileprivate func descriptionTest(text: String)-> some View{
        Text(text)
            .lineLimit(nil)
            .font(.system(size: 15))
            .multilineTextAlignment(.center)
            .padding(.bottom, 33)
            .frame(width: 339)
    }
    
    mutating func setHander(completion: @escaping btnHandler){
        self.completion = completion
    }
    
}

struct RemainderPage_Previews: PreviewProvider {
    static var previews: some View {
        RemainderPage(model: BottomModel(iconName: "remainder",
                                         title: "Reminder",
                                         description: "When send-in-order option is enabled... Reminder will be sent to the next signer. Otherwise... Remainders will be sent to all the signers.",
                                         btnTitle: "Send Reminder", btnColor: Color.btnColorGreen))
    }
}

extension RemainderPage:ZPresentable{
    var cornerRadius: CGFloat {
        10
    }
    
    var direction: PresentationDirection {
        .bottomWithCustomHeight
    }
    
    var popupHeight: CGFloat {
        
        customPopUpHeight
    }
    
    var dimmingViewAlpha: CGFloat {
        0.2
    }
    
    var navBar: PresentationNavBar {
        .init(size: 0.0, title: nil, subtitle: nil, titleAlignment: .center, backgroundColor: .white)
    }
    
    var isBlurredDimmingView: Bool {
        true
    }
    
    var shouldApplyCornerRadius: Bool {
        true
    }
    
    var transitionAnimationDuration: TimeInterval {
        1
    }
    
    
}

class CustomHostingController<T>: UIHostingController<T> where T: View{

    @State var customHostingPopUpHeight: CGFloat = 0
    
    override init(rootView: T) {
        super.init(rootView: rootView)
        
        bindPopUpHeight()
    }
    
    private func bindPopUpHeight(){
        
        guard let remainderView = rootView as? RemainderPage else { return }
        remainderView.setPopUpHeight(height: $customHostingPopUpHeight)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIHostingController: ZPresentable{
    
    public var transitionAnimationDuration: TimeInterval {
        guard let rootView = rootView as? ZPresentable else { return 1 }
        return rootView.transitionAnimationDuration
    }
    
    public var cornerRadius: CGFloat {
        guard let rootView = rootView as? ZPresentable else { return 10 }
        return rootView.cornerRadius
    }
    
    public var direction: PresentationDirection {
        guard let rootView = rootView as? ZPresentable else { return .bottomWithCustomHeight }
        return rootView.direction
    }
    
    public var popupHeight: CGFloat {
//         return customHostingPopUpHeight
        guard let rootView = rootView as? ZPresentable else { return 350 }
        return rootView.popupHeight
    }
    
    public var dimmingViewAlpha: CGFloat {
        guard let rootView = rootView as? ZPresentable else { return 0.3 }
        return rootView.dimmingViewAlpha
    }
    
    public var navBar: PresentationNavBar {
        guard let rootView = rootView as? ZPresentable else { return .init(size: 0.0, title: nil, subtitle: nil, titleAlignment: .center, backgroundColor: .white) }
        return rootView.navBar
        
    }
    
    public var isBlurredDimmingView: Bool {
        guard let rootView = rootView as? ZPresentable else { return true }
        return rootView.isBlurredDimmingView
    }
    
    public var shouldApplyCornerRadius: Bool {
        guard let rootView = rootView as? ZPresentable else { return true }
        return rootView.shouldApplyCornerRadius
    }
        
}
