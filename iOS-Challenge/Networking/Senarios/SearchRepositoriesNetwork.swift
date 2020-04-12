//
//  SearchRepositoriesNetwork.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

/// - SearchRepositoriesResponse
struct SearchRepositoriesResponse: Decodable {
    let items: [SearchRepositoriesItemResponse]
}

/// - SearchRepositoriesResponse
struct SearchRepositoriesItemResponse: Decodable {
    let id: Int?
    let node_id: String?
    let name: String?
    let full_name: String?
    let html_url: String?
    let description: String?
    let url: String?
    let size: Int?
    let stargazers_count: Int?
    let watchers_count: Int?
    let score: Float?
}

/// - SearchRepositoriesErrorResponse
struct SearchRepositoriesErrorResponse: Decodable {
    let detail: String?
}

/// - SearchRepositoriesNetwork
struct SearchRepositoriesNetwork: BaseRequest {
    typealias RequestType = NilRequest
    typealias ResponseType = SearchRepositoriesResponse
    typealias ErrorType = SearchRepositoriesErrorResponse
    
    var q: String = ""
    
    init(q: String) {
        self.q = q
    }
    
    var data: RequestData<NilRequest> {
        return RequestData(path: ConstantURLs.api + "search/repositories?q=\(q)&sort=stars&order=desc",
                           method: HTTPMethod.get,
                           params: NilRequest())
    }
    
}
