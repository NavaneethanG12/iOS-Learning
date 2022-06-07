//
//  SDropDown.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 07/06/22.
//

import Foundation
import UIKit
import SnapKit



@objc protocol SDropDownDelegate{
    func dropDown(didSelectAt index: Int, dropDown: SDropDown)
    func dropDownDidReset()
}


class SDropDown: UIView{
    
    let tableRowHeight: CGFloat = 45
    
    var delegate: SDropDownDelegate?
    
    var suggesstionTable = UITableView()
    
    var sugesstionTableisShowing: Bool = false
    
    lazy var mainTextField: UITextField = {
        let field = UITextField()
        field.textAlignment = .left
        field.font = UIFont.boldSystemFont(ofSize: 14)
        field.textColor = .black
        field.placeholder = "Select"
        field.backgroundColor = UIColor.white
//        field.isEnabled = false
        field.isUserInteractionEnabled = true
        field.addGestureRecognizer(tapGesture)
        field.rightView = UIImageView(image: UIImage(systemName: "arrowtriangle.down.fill")!.withRenderingMode(.alwaysTemplate).withTintColor(.black))
        field.rightViewMode = .always
        return field
    }()
    
    var dropDownItems: [String]?
    lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showDropDown))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        return tap
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDropDown()
    }
    
    convenience init(placeholder: String, dropDownItems: [String]?){
        self.init()
        
        mainTextField.placeholder = placeholder
        self.dropDownItems = dropDownItems
        self.suggesstionTable.reloadData()
        suggesstionTable.delegate = self
        suggesstionTable.dataSource = self
    }
    
    private func setupDropDown(){
        
        addSubview(mainTextField)
        
        mainTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }
    
    ///Delegate Functions
    @objc private func showDropDown(){
        
        if sugesstionTableisShowing{
            closeDropDown()
            
        }else{
            let tableHeight = CGFloat(Int(tableRowHeight) * (dropDownItems?.count ?? 0))
            self.superview?.addSubview(suggesstionTable)
            
            if ((((self.superview?.frame.maxY)!) - (self.frame.maxY)) <= CGFloat(350)){
                suggesstionTable.snp.makeConstraints { make in
                    make.bottom.equalTo(self.snp.top)
                    if (tableHeight <= 350){
                        make.height.equalTo(tableHeight)
                    }else{
                        make.height.equalTo(350)
                    }
                    make.centerX.equalTo(self)
                    make.width.equalTo(mainTextField)
                }

            }else{
                suggesstionTable.snp.makeConstraints { make in
                    make.top.equalTo(self.snp.bottom)
                    if (tableHeight <= 350){
                        make.height.equalTo(tableHeight)
                    }else{
                        make.height.equalTo(350)
                    }
                    make.centerX.equalTo(self)
                    make.width.equalTo(mainTextField)
                }

            }
            sugesstionTableisShowing = true
        }
    }
    
    private func closeDropDown(){
        suggesstionTable.removeFromSuperview()
        sugesstionTableisShowing = false
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - TableView Delegate and Datasource
extension SDropDown: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dropDownItems?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.row == dropDownItems?.count ?? 0{
            cell.textLabel?.text = "Reset Drop Down"
        }else{
            cell.textLabel?.text = dropDownItems?[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableRowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == dropDownItems?.count ?? 0{
            mainTextField.text = ""
            delegate?.dropDownDidReset()
        }else{
            mainTextField.text = dropDownItems?[indexPath.row]
            delegate?.dropDown(didSelectAt: indexPath.row, dropDown: self)
        }
        closeDropDown()
        
        
    }
    
    
}

//MARK: - TextField Delegate
extension SDropDown {
    
    
    
}
