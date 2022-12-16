//
//  APIManager.swift
//  TaipeiZooUIKitVersion
//
//  Created by user on 2022/12/16.
//

import Foundation
import Combine

class APIManager {
    static let shared = APIManager()
    let baseURL = "https://data.taipei/api/v1/dataset/"
    
    private init() {}
    
    func requestAPI<T: Codable>(url: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: NetworkError.urlError).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getAreaInfo() -> AnyPublisher<[ZooAreaInfo], Error> {
        let url = baseURL + "5a0e5fbb-72f8-41c6-908e-2fb25eff9b8a?scope=resourceAquire"
        
        let publisher: AnyPublisher<Response<[ZooAreaInfo]>, Error> = requestAPI(url: url)
        return publisher.map({$0.result.results}).eraseToAnyPublisher()
    }
    
    func getAnimalInfo() -> AnyPublisher<[AnimalInfo], Error> {
        let url = baseURL + "a3e2b221-75e0-45c1-8f97-75acbd43d613?scope=resourceAquire&limit=1000"

        let publisher: AnyPublisher<Response<[AnimalInfo]>, Error> = requestAPI(url: url)
        return publisher.map({$0.result.results}).eraseToAnyPublisher()
    }
}

enum NetworkError: Error {
    case urlError
}
