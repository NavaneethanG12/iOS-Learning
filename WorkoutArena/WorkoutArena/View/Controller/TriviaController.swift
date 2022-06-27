//
//  TriviaController.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 01/06/22.
//

import Foundation
import UIKit
import SnapKit
import Intents


class TriviaController: UIViewController{
    
    let getButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Trivia", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 26
        return button
    }()
    
    //    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setIOS15Navigation()
        view.backgroundColor = Colors.navTintColor
        
        let imageView = UIImageView()
        
        var imgListArray :[UIImage] = []
//        let image1 = UIImage(named: "1")
//        let image2 = UIImage(named: "2")
//        let mergedImage = image1?.merge(mergewith: image2!)
        for countValue in 1...9
        {
            let strImageName : String = "\(countValue)"
            let image  = UIImage(named:strImageName)!
            imgListArray.append(contentsOf: [image,image,image])
        }
//        imageView.image = drawLineInImageUsingGraphics(image: image1!)
        imageView.animationImages = imgListArray
        imageView.animationDuration = 2.0
        imageView.startAnimating()
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        view.addSubview(getButton)
        
        getButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(52)
        }
        
        getButton.addTarget(self, action: #selector(getRandomTrivia), for: .touchUpInside)
    }
    
    
    @objc func getRandomTrivia(){
        
        
        DataManager().getRandomTrivia { [weak self] trivia in
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Your Random Trivia", message: trivia, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true)
            }
        }
        
        //        INInteraction(intent: GetRandomTriviaIntent(), response: nil).donate(completion: nil)
    }
    
    func drawLineInImageUsingGraphics(image: UIImage)-> UIImage?{
        UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale)
        let area = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        image.draw(in: area)
        let context = UIGraphicsGetCurrentContext()
//        context?.draw(<#T##layer: CGLayer##CGLayer#>, in: area)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    
}

extension UIImage{
    func merge(mergewith:UIImage) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let actualArea = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let mergeArea = CGRect(x: 0, y: size.height - mergewith.size.height, width: size.width, height: mergewith.size.height)
        self.draw(in: actualArea)
        mergewith.draw(in: mergeArea)
        let merged = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return merged
    }
    
}
