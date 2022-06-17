//
//  DogViewController.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 08/06/22.
//

import Foundation
import UIKit
import Kingfisher
import SVProgressHUD

class DogViewController: UITableViewController{
    
    var viewModel = DogViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = Colors.bgWhiteColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(DogTableCell.self, forCellReuseIdentifier: "Dog")
        
        viewModel.fetchModel(){ _ in
            
        }
        
        viewModel.model.bind(listener: {[weak self] value in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                KingfisherManager.shared.cache.clearMemoryCache()
                KingfisherManager.shared.cache.clearDiskCache()
                KingfisherManager.shared.cache.cleanExpiredDiskCache()
            }
            
        })
        
        let bt1 = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(changeModel))
        bt1.tag = 0
        
        let bt2 = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(changeModel))
        bt2.tag = 1
        
        navigationItem.rightBarButtonItems = [bt1,bt2]
    }
    
    @objc func changeModel(_ sender: UIBarButtonItem){
        if sender.tag == 0{
            viewModel.model.value = [DogModel(id: 1, name: "Hello", life_span: "1 - 10", image: Image(id: "hello", width: 10, height: 10, url: "https://cdn2.thedogapi.com/images/pk1AAdloG.jpg"))]
        }else if sender.tag == 1{
            viewModel.fetchModel(){ _ in
                
            }
        }
        
    }
    
    
    //MARK: - TableView Delegate and Datasource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Dog", for: indexPath) as? DogTableCell else { return UITableViewCell() }
        cell.configureCell(viewModel: viewModel, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.height * 0.1
    }
}
