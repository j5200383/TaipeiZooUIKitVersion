//
//  AreaDetailTableViewCell.swift
//  TaipeiZooUIKitVersion
//
//  Created by user on 2022/12/12.
//

import UIKit

class AreaDetailTableViewCell: UITableViewCell {
    private var headerImageView = UIImageView()
    private var infoLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setHeaderImageView()
        setInfoLabel()
    }
    
    private func setHeaderImageView() {
        contentView.addSubview(headerImageView)
        headerImageView.contentMode = .scaleToFill
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        headerImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        headerImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        headerImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
    
    private func setInfoLabel() {
        contentView.addSubview(infoLabel)
        infoLabel.numberOfLines = 0
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 16).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    func setData(_ data: ZooAreaInfo?) {
        guard let data = data else {return}
        
        if let image = data.image {
            headerImageView.image = image
        } else {
            ImageManager.shared.fetchImage(url: URL(string:data.picUrl)!) { image in
                self.headerImageView.image = image
            }
        }
        
        infoLabel.text = data.info
    }
}
