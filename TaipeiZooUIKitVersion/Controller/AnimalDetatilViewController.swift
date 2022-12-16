//
//  AnimalDetatilViewController.swift
//  TaipeiZooUIKitVersion
//
//  Created by user on 2022/12/14.
//

import UIKit

class AnimalDetatilViewController: BaseViewController {
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var imageView = UIImageView()
    private var nameLabel = UILabel()
    private var alsoknownLabel = UILabel()
    private var featureLabel = UILabel()
    private var behaviorLabel = UILabel()
    private var updateLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.layoutIfNeeded()
        scrollView.contentSize.height = contentView.frame.height
    }
    
    private func setUI() {
        setScrollView()
        setContentView()
        setImageView()
        setNameLabel()
        setAlsoknownLabel()
        setFeatureLabel()
        setBehaviorLabel()
        setUpdateLabel()
    }
    
    private func setScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    private func setContentView() {
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func setImageView() {
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func setNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.numberOfLines = 0
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
    }
    
    private func setAlsoknownLabel() {
        contentView.addSubview(alsoknownLabel)
        alsoknownLabel.numberOfLines = 0
        
        alsoknownLabel.translatesAutoresizingMaskIntoConstraints = false
        alsoknownLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 36).isActive = true
        alsoknownLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        alsoknownLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
    }
    
    private func setFeatureLabel() {
        contentView.addSubview(featureLabel)
        featureLabel.numberOfLines = 0

        featureLabel.translatesAutoresizingMaskIntoConstraints = false
        featureLabel.topAnchor.constraint(equalTo: alsoknownLabel.bottomAnchor, constant: 36).isActive = true
        featureLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        featureLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
    }
    
    private func setBehaviorLabel() {
        contentView.addSubview(behaviorLabel)
        behaviorLabel.numberOfLines = 0

        behaviorLabel.translatesAutoresizingMaskIntoConstraints = false
        behaviorLabel.topAnchor.constraint(equalTo: featureLabel.bottomAnchor, constant: 36).isActive = true
        behaviorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        behaviorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
    }
    
    private func setUpdateLabel() {
        contentView.addSubview(updateLabel)
        updateLabel.numberOfLines = 0

        updateLabel.translatesAutoresizingMaskIntoConstraints = false
        updateLabel.topAnchor.constraint(equalTo: behaviorLabel.bottomAnchor, constant: 36).isActive = true
        updateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        updateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        updateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    func setData(_ data: AnimalInfo) {
        title = data.name
        imageView.image = data.image
        nameLabel.text = data.name + "\n" + data.enName
        alsoknownLabel.text = "別名\n\(data.alsoknown)"
        featureLabel.text = "特徵\n\(data.feature)"
        behaviorLabel.text = "行爲\n\(data.behavior)"
        updateLabel.text = "最後更新：\(data.update)"
    }
}
