//
//  SearchLicense.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/30/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import Foundation
import ObjectMapper

struct SearchLicense : Mappable {
    var key : String?
    var name : String?
    var spdx_id : String?
    var url : String?
    var node_id : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        key <- map["key"]
        name <- map["name"]
        spdx_id <- map["spdx_id"]
        url <- map["url"]
        node_id <- map["node_id"]
    }

}
