//
//  ViewController.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 31/05/22.
//

import UIKit
import IntentsUI
import SnapKit



class ViewController: UIViewController, INUIAddVoiceShortcutViewControllerDelegate, INUIEditVoiceShortcutViewControllerDelegate {
    
    
    typealias checkAvailableCompletion = ((INVoiceShortcut, Bool)->Void)
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = Colors.primaryTextColor
        label.text = "MAIN LABEL"
        return label
    }()
    
    let siriButton = INUIAddVoiceShortcutButton(style: .blackOutline)
    
    lazy var authenticator = Authenticator(vc: self)
    
    var shortcutAvailable: Bool = false
    var inVoiceShortcut: INVoiceShortcut?
    
    lazy var shortcut: INShortcut = {
        let activity = NSUserActivity(activityType: "com.navaneethan.g.WorkoutArena.changeLabel")
        activity.title = "SIRI Commands"
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        
        self.userActivity = activity
        self.userActivity?.becomeCurrent()
        
        let shortcut = INShortcut(userActivity: activity)
        return shortcut
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "HOME"
        view.backgroundColor = Colors.bgWhiteColor

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(pushVC))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "GoToTrivia", style: .plain, target: self, action: #selector(pushTrivia))

        setIOS15Navigation()
        
        
        
        setupView()
//        loadImages()
        print("Main area... function Called")
        callAllAsync()

        print("Main area... function Ended")
    }
    
    func loadImage(index: Int) async -> UIImage {
        let imageURL = URL(string: "https://picsum.photos/200/300")!
        let request = URLRequest(url: imageURL)
        let (data, _) = try! await URLSession.shared.data(for: request, delegate: nil)
        print("Finished loading image \(index)")
        return UIImage(data: data)!
    }

    func loadImages(){
        Task{
            async let image1 = loadImage(index: 1)
            async let image2 = loadImage(index: 2)
            async let image3 = loadImage(index: 3)
            let images = await [image1, image2, image3]
        }
    }

    func fetchDataFromUrl() async -> Data?{
        print("Data fetch Started")
        let urlString = "https://api.thedogapi.com/v1/breeds"
        do {
            let (data, _) = try await URLSession.shared.data(from: (URL(string: urlString))!)
            print("Data fetch Ended")
            return data
        }catch{
            print("network fetch failed due to \(error)")
            return nil
        }
    }

    func doMathOperation() async -> Int{
        print("Math operation Started")
        var count: Int = 1
        for i in Range(0...1000000){
            count += i
        }
        print("Math operation Ended")
        return count
    }


    func myAsyncFunction() async -> (data: Data?, math: Int){
        
        print("Data fetch Started in \(Thread.current)")
        async let data =  fetchDataFromUrl()
        print("Data fetch Ended in \(Thread.current)")
        
        print("Math Operation Started in \(Thread.current)")
        async let calculatedValue = doMathOperation()
        print("Math Operation Ended in \(Thread.current)")
        
        
        let tuple = await (data, calculatedValue)
        print("Tuple is Ready for returning")
        return tuple
        
    }

    func callAllAsync(){
        Task.detached(priority: .background){
            print("myAsync Function Call Started in \(Thread.current)")
            let myTuple = await self.myAsyncFunction()
            print("myAsync Function Call Ended in \(Thread.current)")
            print(myTuple.data!,myTuple.math)
        }
    }

    
   
    
    private func setupView(){
        
        
        view.addSubview(siriButton)
        siriButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(60)
        }
        
        
        siriButton.shortcut = shortcut
        
        checkAllAvailableShortcuts(shortcut: shortcut)
        
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(siriButton.snp.bottom).offset(30)
        }
        
        siriButton.addTarget(self, action: #selector(siriCommand), for: .touchUpInside)
        
        let loginBtn = ZButton(title: "Login", titleColor: .white, bgColor: Colors.btnColor, cornerRadius: 26, target: self, action: #selector(loginBtnTapped))
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(52)
        }
        
    
    }
    
    @objc func loginBtnTapped(_ sender: ZButton){
        print(sender.titleLabel?.text)
        
        authenticator.presentAuthViewController()
    }
    
    func checkAllAvailableShortcuts(shortcut: INShortcut){
        
        checkIfShortcutAvailable(shortcut) { [weak self] siriShortcut, available in
            DispatchQueue.main.async {
                if available{
                    self?.shortcutAvailable = available
                    self?.siriButton.shortcut = siriShortcut.shortcut
                    self?.inVoiceShortcut = siriShortcut
                }else{
                    self?.shortcutAvailable = available
                    self?.inVoiceShortcut = nil
                }
            }
            
        }
    }
    
   
    @objc func siriCommand(_ sender: INUIAddVoiceShortcutButton){
        
        if shortcutAvailable{
            guard let inVoiceShortcut = inVoiceShortcut else {
                return }
            
            presentEditSiriController(inVoiceShortcut, sender)
        }else{
            presentAddSiriController(sender)
        }
        
    }
    
    func presentAddSiriController(_ button: INUIAddVoiceShortcutButton){
        guard let shortcut = button.shortcut else { return }
        let vc = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        vc.delegate = self
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
    
    func presentEditSiriController(_ voiceShortcut: INVoiceShortcut,_ button: INUIAddVoiceShortcutButton){
        button.shortcut = voiceShortcut.shortcut
        let vc = INUIEditVoiceShortcutViewController(voiceShortcut: voiceShortcut)
        vc.delegate = self
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }

    func checkIfShortcutAvailable(_ shortcut: INShortcut, completion: @escaping checkAvailableCompletion){
        
        INVoiceShortcutCenter.shared.getAllVoiceShortcuts { shortcuts , error in
            shortcuts?.forEach({ siriShortcut in
               if siriShortcut.shortcut.userActivity?.activityType == "com.navaneethan.g.WorkoutArena.changeLabel" {
                   completion(siriShortcut, true)
               }else{
                  completion(siriShortcut, false)
               }
            })
        }
        
    }
    
    @objc func pushVC(){
        let vc = InterStellarViewController()
//        vc.view.backgroundColor = .red
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushTrivia(){
        let vc = TriviaController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - SIRI ADD SHORTCUT ViewController DELEGATE METHODS
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        
        checkAllAvailableShortcuts(shortcut: shortcut)
        controller.dismiss(animated: true)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        
        checkAllAvailableShortcuts(shortcut: shortcut)
        controller.dismiss(animated: true)
    }
    
    //MARK: - SIRI EDIT SHORTCUT ViewController DELEGATE METHODS
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        
        checkAllAvailableShortcuts(shortcut: shortcut)
        controller.dismiss(animated: true)
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        
        checkAllAvailableShortcuts(shortcut: shortcut)
        controller.dismiss(animated: true)
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        
        checkAllAvailableShortcuts(shortcut: shortcut)
        controller.dismiss(animated: true)
    }

}

