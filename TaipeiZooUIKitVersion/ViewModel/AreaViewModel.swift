//
//  AreaViewModel.swift
//  TaipeiZooUIKitVersion
//
//  Created by user on 2022/12/12.
//

import Foundation
import Combine

class AreaViewModel: BaseViewModel {
    @Published private (set) var zooAreaInfos = [ZooAreaInfo]()
    
    func getData() {
        loadingEven = .loading
        APIManager.shared.getAreaInfo()
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
                self.loadingEven = .stop
            } receiveValue: {[weak self] data in
                guard let `self` = self else {return}
                self.zooAreaInfos = data
            }
            .store(in: &cancellable)
    }
    
    func getUrlImage(_ urlString: String, index: Int) {
        guard let url = URL(string: urlString) else {return}
        ImageManager.shared.fetchImage(url: url) {[weak self] image in
            guard let `self` = self else {return}
            self.zooAreaInfos[index].image = image
        }
    }
}
