//
//  PassField.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 03/06/22.
//

import Foundation
import UIKit
import SnapKit

class PassField: UIView{
    
    var fieldCount = 4
    private let diameter = 13
    private let dotSpacing = 20
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tag = -1
        setUpPassField()
    }
    
    func setUpPassField(){
        for i in 0..<4{
            let view = UIView()
            view.backgroundColor = .clear
            view.layer.cornerRadius = CGFloat(diameter/2)
            view.layer.borderColor = Colors.btnColor.cgColor
            view.layer.borderWidth = 1
            view.tag = i
            self.addSubview(view)
            
            let calculatedValue = (2*diameter) + dotSpacing + (dotSpacing/2)
            
            view.snp.makeConstraints { make in
                make.width.height.equalTo(diameter)
                make.centerY.equalToSuperview()
                if i == 0{
                    make.leading.equalTo(self.snp.centerX).offset(-calculatedValue)
                }else{
                    make.leading.equalTo(viewWithTag(i-1)!.snp.trailing).offset(dotSpacing)
                }
                
            }
            
        }
    }
    
    func updateDots(count: Int){
        
//        print("Updating dots for count \(count)")
        
        for i in 0..<count{
            let view = viewWithTag(i)
            view?.backgroundColor = Colors.btnColor
        }
        
    }
    
    func deleteLastDot(count: Int){
        
        for i in stride(from: 3, through: count, by: -1){
            let view = viewWithTag(i)
            view?.backgroundColor = .clear
        }
        
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
