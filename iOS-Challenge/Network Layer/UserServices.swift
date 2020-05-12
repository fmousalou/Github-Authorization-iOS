//
//  UserServices.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/28/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RxSwift

struct UserService : Wrapable {
    
    static let shared = UserService()
    
    func getUserProfile() -> Observable<Result<User>> {
//        let params = ["username":mobileNumber]
        
        return requestWithToken(url: Route.UserServicesRoute(.user).url, param: nil, method: .get)
    }
    
}

struct SearchServices:Wrapable {
    static let shared = SearchServices()
    
    func SearchRepo(SearchText:String) -> Observable<Result<SearchBaseModel<RepoSearchItems>>>{
        let params = ["q":SearchText]
        return request(url: Route.SearchServices(.repo).url, param: params, method: .get, encoding: URLEncoding.default)
    }
}





struct RepoServices:Wrapable {
    static let shared = RepoServices()
    
    func getCommits(owner:String , repo:String) -> Observable<Result<CommitsBaseResponse>>{
        return request(url: Route.RepoServices(.Commits).url + "/\(owner)/\(repo)" + "/commits", param: nil, method: .get, encoding: URLEncoding.default)
    }
}













struct User: Mappable {
    mutating func mapping(map: Map) {
        avatarUrl <- map["avatar_url"]
        blog <- map["blog"]
        company <- map["company"]
        contributions <- map["contributions"]
        createdAt <- (map["created_at"], ISO8601DateTransform())
//        descriptionField <- map["description"]
        email <- map["email"]
        followers <- map["followers"]
        following <- map["following"]
        htmlUrl <- map["html_url"]
        location <- map["location"]
        login <- map["login"]
        name <- map["name"]
        repositoriesCount <- map["public_repos"]
//        type <- map["type"]
//        updatedAt <- (map["updated_at"], ISO8601DateTransform())
        bio <- map["bio"]
    }
    
     init?(map: Map) {}
    
    var avatarUrl: String?  // A URL pointing to the user's public avatar.
    var blog: String?  // A URL pointing to the user's public website/blog.
    var company: String?  // The user's public profile company.
    var contributions: Int?
    var createdAt: Date?  // Identifies the date and time when the object was created.
    var email: String?  // The user's publicly visible profile email.
    var followers: Int?  // Identifies the total count of followers.
    var following: Int? // Identifies the total count of following.
    var htmlUrl: String?  // The HTTP URL for this user
    var location: String?  // The user's public profile location.
    var login: String?  // The username used to login.
    var name: String?  // The user's public profile name.
//    var type: UserType = .user
    var updatedAt: Date?  // Identifies the date and time when the object was last updated.
    var starredRepositoriesCount: Int?  // Identifies the total count of repositories the user has starred.
    var repositoriesCount: Int?  // Identifies the total count of repositories that the user owns.
    var issuesCount: Int?  // Identifies the total count of issues associated with this user
    var watchingCount: Int?  // Identifies the total count of repositories the given user is watching
    var viewerCanFollow: Bool?  // Whether or not the viewer is able to follow the user.
    var viewerIsFollowing: Bool?  // Whether or not this user is followed by the viewer.
    var isViewer: Bool?  // Whether or not this user is the viewing user.
//    var pinnedRepositories: [Repository]?  // A list of repositories this user has pinned to their profile
//    var organizations: [User]?  // A list of organizatio
    
     var bio: String?  // The user's public profile bio.
}
