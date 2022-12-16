//
//  AreaDetailViewModel.swift
//  TaipeiZooUIKitVersion
//
//  Created by user on 2022/12/13.
//

import Foundation
import Combine

class AreaDetailViewModel: BaseViewModel {
    @Published private (set) var animalInfos = [AnimalInfo]()
    var areaInfo: ZooAreaInfo?
    
    func getData() {
        loadingEven = .loading
        APIManager.shared.getAnimalInfo()
            .sink(receiveCompletion: {[weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
                self?.loadingEven = .stop
            }, receiveValue: {[weak self] data in
                self?.animalInfos = data.filter({$0.location == self?.areaInfo?.name})
            })
            .store(in: &cancellable)
    }
    
    func getUrlImage(_ urlString: String, index: Int) {
        guard let url = URL(string: urlString) else {return}
        ImageManager.shared.fetchImage(url: url) {[weak self] image in
            self?.animalInfos[index].image = image
        }
    }
}
