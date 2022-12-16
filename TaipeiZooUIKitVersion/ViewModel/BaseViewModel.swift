//
//  BaseViewModel.swift
//  TaipeiZooUIKitVersion
//
//  Created by user on 2022/12/16.
//

import Foundation
import Combine

enum LoadingEven {
    case loading
    case stop
}

class BaseViewModel {
    @Published var errorMessage: String?
    @Published var loadingEven: LoadingEven = .stop
    var cancellable = Set<AnyCancellable>()
}
