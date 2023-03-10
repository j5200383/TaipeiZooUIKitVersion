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
        
    private func setUI() {
        view.backgroundColor = .white
        
        let barAppearance =  UINavigationBarAppearance()
        barAppearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance

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
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        let contentViewHeightAnchor = contentView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 16)
        contentViewHeightAnchor.priority = UILayoutPriority(rawValue: 1)
        contentViewHeightAnchor.isActive = true
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
        updateLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    func setData(_ data: AnimalInfo) {
        title = data.name
        nameLabel.text = data.name + "\n" + data.enName
        alsoknownLabel.text = "??????\n\(data.alsoknown)"
        featureLabel.text = "??????\n\(data.feature)"
        behaviorLabel.text = "??????\n\(data.behavior)"
        updateLabel.text = "???????????????\(data.update)"
        
        if let image = data.image {
            imageView.image = image
        } else if let url = URL(string: data.picUrl) {
            ImageManager.shared.fetchImage(url: url) { image in
                self.imageView.image = image
            }
        }
    }
}
