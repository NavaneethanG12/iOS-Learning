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
        label.textColor = Colors.navBarColor
        label.text = "MAIN LABEl"
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
        view.backgroundColor = Colors.navTintColor

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(pushVC))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "GoToTrivia", style: .plain, target: self, action: #selector(pushTrivia))

        setIOS15Navigation()
        
        
        setupView()
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
            make.bottom.equalToSuperview().offset(-50)
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

