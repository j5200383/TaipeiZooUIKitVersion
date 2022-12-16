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
        guard let url = URL(string: "https://data.taipei/api/v1/dataset/a3e2b221-75e0-45c1-8f97-75acbd43d613?scope=resourceAquire&limit=1000") else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .compactMap({try? JSONSerialization.jsonObject(with: $0.data) as? [String : Any]})
            .compactMap({$0["result"] as? [String : Any]})
            .compactMap({$0["results"] as? [[String : Any]]})
            .compactMap({try? JSONSerialization.data(withJSONObject: $0)})
//            .compactMap { String(data: $0, encoding:. utf8) }
            .decode(type: [AnimalInfo].self, decoder: JSONDecoder())
            .filter({$0.contains(where: {$0.location == self.areaInfo?.name})})
            .sink(receiveCompletion: {print("completion:\($0)")}, receiveValue: { data in
                self.animalInfos = data.filter({$0.location == self.areaInfo?.name})
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
