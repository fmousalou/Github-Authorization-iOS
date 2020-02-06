//
//  SearchResult.swift
//
//  Created by anna on 11/15/1398 AP
//  Copyright (c) . All rights reserved.
//


import Foundation
import ObjectMapper

struct SearchResult : Mappable {
    var total_count : Int?
    var incomplete_results : Bool?
    var items : [Item]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        total_count <- map["total_count"]
        incomplete_results <- map["incomplete_results"]
        items <- map["items"]
    }

}
