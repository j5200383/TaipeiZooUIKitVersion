//
//  Response.swift
//  TaipeiZooUIKitVersion
//
//  Created by user on 2022/12/16.
//

import Foundation

struct Response<T:Codable>: Codable {
    var result: Result<T>
}

struct Result<T: Codable>: Codable {
    var limit: Int?
    var offset: Int?
    var count: Int?
    var sort: String?
    var results: T
}
