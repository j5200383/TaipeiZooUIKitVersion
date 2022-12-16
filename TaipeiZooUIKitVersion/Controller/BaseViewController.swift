//
//  BaseViewController.swift
//  TaipeiZooUIKitVersion
//
//  Created by user on 2022/12/16.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    var cancellable = Set<AnyCancellable>()
    var loadingView = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonDisplayMode = .minimal
        setLoadingView()
    }
    
    private func setLoadingView() {
        loadingView.center = view.center
        view.addSubview(loadingView)

    }
    
    func startLoadingView() {
        view.bringSubviewToFront(loadingView)
        loadingView.startAnimating()
    }
    
    func stopLoadingView() {
        loadingView.stopAnimating()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "確定", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
