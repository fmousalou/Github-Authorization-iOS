//
//  Owner.swift
//
//  Created by anna on 11/15/1398 AP
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

struct Owner : Mappable {
    var login : String?
    var id : Int?
    var node_id : String?
    var avatar_url : String?
    var gravatar_id : String?
    var url : String?
    var received_events_url : String?
    var type : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        login <- map["login"]
        id <- map["id"]
        node_id <- map["node_id"]
        avatar_url <- map["avatar_url"]
        gravatar_id <- map["gravatar_id"]
        url <- map["url"]
        received_events_url <- map["received_events_url"]
        type <- map["type"]
    }

}
