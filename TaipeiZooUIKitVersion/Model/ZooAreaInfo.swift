//
//  ZooAreaInfo.swift
//  TaipeiZooUIKitVersion
//
//  Created by user on 2022/12/12.
//

import UIKit

enum ZooAreaInfoSection {
    case zooArea
    case zoo
}

struct ZooAreaInfo: Codable, Hashable {
    var name: String
    var picUrl: String
    var info: String
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case name = "e_name"
        case picUrl = "e_pic_url"
        case info = "e_info"
    }
}
