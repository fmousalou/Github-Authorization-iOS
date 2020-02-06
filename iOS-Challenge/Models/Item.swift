//
//  Items.swift
//
//  Created by anna on 11/15/1398 AP
//  Copyright (c) . All rights reserved.
//
import Foundation
import ObjectMapper

struct Item : Mappable {
    var id : Int?
    var node_id : String?
    var name : String?
    var full_name : String?
    var owner : Owner?
    var html_url : String?
    var description : String?
    var fork : Bool?
    var url : String?
    var created_at : String?
    var updated_at : String?
    var pushed_at : String?
    var homepage : String?
    var size : Int?
    var stargazers_count : Int?
    var watchers_count : Int?
    var language : String?
    var forks_count : Int?
    var open_issues_count : Int?
    var master_branch : String?
    var default_branch : String?
    var score : Double?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        node_id <- map["node_id"]
        name <- map["name"]
        full_name <- map["full_name"]
        owner <- map["owner"]
        html_url <- map["html_url"]
        description <- map["description"]
        fork <- map["fork"]
        url <- map["url"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        pushed_at <- map["pushed_at"]
        homepage <- map["homepage"]
        size <- map["size"]
        stargazers_count <- map["stargazers_count"]
        watchers_count <- map["watchers_count"]
        language <- map["language"]
        forks_count <- map["forks_count"]
        open_issues_count <- map["open_issues_count"]
        master_branch <- map["master_branch"]
        default_branch <- map["default_branch"]
        score <- map["score"]
    }

}
