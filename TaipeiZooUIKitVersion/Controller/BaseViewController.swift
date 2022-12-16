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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonDisplayMode = .minimal
    }
}
