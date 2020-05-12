//
//  RepoBaseResponse.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 2/1/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import ObjectMapper

struct CommitsBaseResponse : Mappable {
    var sha : String?
    var node_id : String?
    var commit : Commit?
    var url : String?
    var html_url : String?
    var comments_url : String?
    var author : Author?
    var committer : Committer?
    var parents : [Parents]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        sha <- map["sha"]
        node_id <- map["node_id"]
        commit <- map["commit"]
        url <- map["url"]
        html_url <- map["html_url"]
        comments_url <- map["comments_url"]
        author <- map["author"]
        committer <- map["committer"]
        parents <- map["parents"]
    }

}
