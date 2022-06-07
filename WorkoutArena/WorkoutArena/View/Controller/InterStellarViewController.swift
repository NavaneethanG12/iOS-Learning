//
//  InterStellarViewController.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 31/05/22.
//

import Foundation
import UIKit
import SnapKit


class InterStellarViewController: UIViewController{
    
    let imageURLs: [String] = ["https://cdn.spacetelescope.org/archives/images/publicationjpg/heic1509a.jpg",
           "https://cdn.spacetelescope.org/archives/images/publicationjpg/heic1501a.jpg",
           "https://cdn.spacetelescope.org/archives/images/publicationjpg/heic1107a.jpg",
           "https://cdn.spacetelescope.org/archives/images/large/heic0715a.jpg",
           "https://cdn.spacetelescope.org/archives/images/publicationjpg/heic1608a.jpg",
           "https://cdn.spacetelescope.org/archives/images/publicationjpg/potw1345a.jpg",
           "https://cdn.spacetelescope.org/archives/images/large/heic1307a.jpg",
           "https://cdn.spacetelescope.org/archives/images/publicationjpg/heic0817a.jpg",
           "https://cdn.spacetelescope.org/archives/images/publicationjpg/opo0328a.jpg",
           "https://cdn.spacetelescope.org/archives/images/publicationjpg/heic0506a.jpg",
           "https://cdn.spacetelescope.org/archives/images/large/heic0503a.jpg",
           "https://cdn.spacetelescope.org/archives/images/publicationjpg/heic1509a.jpg",
              "https://cdn.spacetelescope.org/archives/images/publicationjpg/heic1501a.jpg",
              "https://cdn.spacetelescope.org/archives/images/publicationjpg/heic1107a.jpg",
              "https://cdn.spacetelescope.org/archives/images/large/heic0715a.jpg",
              "https://cdn.spacetelescope.org/archives/images/publicationjpg/heic1608a.jpg",
              "https://cdn.spacetelescope.org/archives/images/publicationjpg/potw1345a.jpg",
              "https://cdn.spacetelescope.org/archives/images/large/heic1307a.jpg",
              "https://cdn.spacetelescope.org/archives/images/publicationjpg/heic0817a.jpg",
              "https://cdn.spacetelescope.org/archives/images/publicationjpg/opo0328a.jpg",
              "https://cdn.spacetelescope.org/archives/images/publicationjpg/heic0506a.jpg",
              "https://cdn.spacetelescope.org/archives/images/large/heic0503a.jpg"]
    
    let stellarImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = Colors.navBarColor
        return image
    }()
    
    let descriptionView: UITextView = {
        let view = UITextView()
        view.textColor = .white
        view.backgroundColor = UIColor.tintColor
        return view
    }()
    
    
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.navTintColor
        
        setupView()
    }
    
    private func setupView(){
        
        view.addSubview(stellarImage)
        
        stellarImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.height.equalTo(500)
        }
        
        let startButton = UIButton()
        startButton.backgroundColor = .tintColor
        startButton.setTitle("Start Download", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.addTarget(self, action: #selector(startDownload), for: .touchUpInside)
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(52)
            make.top.equalTo(stellarImage.snp.bottom).offset(30)
        }
        startButton.layer.cornerRadius = 26
        
        view.addSubview(descriptionView)
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(startButton.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    func startDownloadImagesWithDataTask() {
        for index in 0..<imageURLs.count {
            dataManager.fetchImageWithDataTask(with: imageURLs[index], index: index) {[weak self] image, index in
                DispatchQueue.main.async {
                    self?.stellarImage.image = image
                    self?.descriptionView.text = (self?.descriptionView.text)! + "\n" + "Downloaded image\(index)"
                }
            }
        }
    }
    
    func startDownloadImagesWithGCD(){
        for index in 0..<imageURLs.count{
//            self.descriptionView.text = (self.descriptionView.text)! + "\n" + "Starting Downloading image\(index)..."
            DispatchQueue.global(qos: .background).async {
                
                guard let image =
                        self.dataManager.fetchImageWithGCD(with: self.imageURLs[index], index: index) else { return }
                
                DispatchQueue.main.async {
                    self.stellarImage.image = image
                    self.descriptionView.text = (self.descriptionView.text)! + "\n" + "Downloaded image\(index)"
                    self.isCodeOnMainThread(named: "Download image\(index) completed")
                }
                
            }
        
        }
    }
    
    @objc func startDownload(){
        startDownloadImagesWithDataTask()
//        startDownloadImagesWithGCD()
    }
    
    func isCodeOnMainThread(named codeDescription:String) -> Bool {
            if Thread.isMainThread {
                print("\(codeDescription) ON MAIN THREAD")
                return true
            } else {
                print("\(codeDescription) ON BACKGROUND THREAD")
                return false
            }
        }
}
