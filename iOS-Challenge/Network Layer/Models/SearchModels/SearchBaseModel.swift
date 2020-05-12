//
//  SearchBaseModel.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/30/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import ObjectMapper

struct SearchBaseModel<T:Mappable> : Mappable {
    var total_count : Int?
    var incomplete_results : Bool?
    var items : [T]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        total_count <- map["total_count"]
        incomplete_results <- map["incomplete_results"]
        items <- map["items"]
    }

}
