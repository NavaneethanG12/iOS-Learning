//
//  DogTableCell.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 08/06/22.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class DogTableCell: UITableViewCell{
    
    let dogImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .tertiarySystemBackground
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "placeholder")
        return image
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
     func setupCell(){
        contentView.addSubview(dogImage)
        
        contentView.layoutIfNeeded()
        dogImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
//            make.width.equalTo(200)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        dogImage.layoutIfNeeded()
        textLabel!.snp.makeConstraints({ make in
            make.leading.equalTo(dogImage.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalToSuperview()
        })
        detailTextLabel!.snp.makeConstraints({ make in
            make.leading.equalTo(dogImage.snp.trailing).offset(5)
            make.top.equalTo(textLabel!.snp.bottom).offset(15)
        })
         textLabel?.layoutIfNeeded()
         detailTextLabel?.layoutIfNeeded()
    }
    
    func configureCell(viewModel: DogViewModel, indexPath: IndexPath){
        
        dogImage.kf.indicatorType = .activity
        dogImage.kf.setImage(with: URL(string: viewModel.model.value[indexPath.row].image.url), placeholder: UIImage(named: "placeholder"), options: [
            .fromMemoryCacheOrRefresh,
            .transition(.flipFromLeft(1))
                                                                    ])
        textLabel?.text = viewModel.model.value[indexPath.row].name
        detailTextLabel?.text = viewModel.model.value[indexPath.row].life_span
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dogImage.image = nil
        textLabel?.text = ""
        detailTextLabel?.text = ""
    }
}
