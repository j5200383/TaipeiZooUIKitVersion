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
        guard let url = URL(string: "https://data.taipei/api/v1/dataset/5a0e5fbb-72f8-41c6-908e-2fb25eff9b8a?scope=resourceAquire") else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .compactMap({try? JSONSerialization.jsonObject(with: $0.data) as? [String : Any]})
            .compactMap({$0["result"] as? [String : Any]})
            .compactMap({$0["results"] as? [[String : Any]]})
            .compactMap({try? JSONSerialization.data(withJSONObject: $0)})
//            .compactMap { String(data: $0, encoding:. utf8) }
            .decode(type: [ZooAreaInfo].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            }, receiveValue: {[weak self] data in
                guard let `self` = self else {return}
                self.zooAreaInfos = data
            })
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
