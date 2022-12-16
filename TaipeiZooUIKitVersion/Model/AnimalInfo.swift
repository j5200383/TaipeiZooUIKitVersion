//
//  AnimalInfo.swift
//  TaipeiZooUIKitVersion
//
//  Created by user on 2022/12/13.
//

import UIKit

enum AnimalSectionType {
    case zooAreaInfo
    case animalInfo
}

struct AnimalInfo: Codable, Hashable {
    var name: String
    var enName: String
    var alsoknown: String
    var feature: String
    var behavior: String
    var location: String
    var picUrl: String
    var image: UIImage?
    var update: String
    
    enum CodingKeys: String, CodingKey {
        case name = "a_name_ch"
        case enName = "a_name_en"
        case alsoknown = "a_alsoknown"
        case feature = "a_feature"
        case behavior = "a_behavior"
        case location = "a_location"
        case picUrl = "a_pic01_url"
        case update = "a_update"
    }
}
