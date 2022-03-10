//
//  SecondViewController.swift
//  Sample123
//
//  Created by navaneeth-pt4855 on 07/03/22.
//

import UIKit

class SecondViewController: UIViewController {

    let toggleSwitch = UISwitch()
    
    let topView = UIView()
    
    let buttonView = UIButton()
    
    let labelView = UILabel()
    
    let textView = UITextField()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        toggleSwitch.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        
        topView.backgroundColor = .blue
        topView.frame = CGRect(x: 250, y: 250, width: 100, height: 100)
        
        buttonView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        buttonView.setTitle("Hello", for: .normal)
        buttonView.setTitleColor(.white, for: .normal)
        buttonView.setTitle("selected", for: .selected)
        buttonView.backgroundColor = .purple
        
        topView.addSubview(buttonView)
        view.addSubview(topView)
        view.addSubview(toggleSwitch)
        
        _ = UIImage(named: "rainbowlake")
        
        buttonView.addTarget(self, action: #selector(buttonViewHandler), for: .touchUpInside)
    }
    

    
    @objc func buttonViewHandler(){
        print("hello")
//        buttonView.setTitle("Bye", for: .normal)
        buttonView.setTitle("Selected", for: .selected)
        print(buttonView.title(for: .selected))
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
