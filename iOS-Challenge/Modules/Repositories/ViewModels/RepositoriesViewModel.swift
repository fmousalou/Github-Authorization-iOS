//
//  RepositoriesViewModel.swift
//  iOS-Challenge
//
//  Created by Erfan Andesta on 2/18/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import Alamofire

class RepositoriesViewModel {
    
    private var accessToken: String? {
        return UserDefaultsService.shared.getToken()
    }
    private(set) var repositories = [GithubRepo]()
    
    func getRepositories(forQuery query: String, completionHandler: @escaping ((Swift.Result<Void, Error>) -> Void)) {
        Search.setQuery(query: query)
        guard let url = URL(string: URLs.searchURL), let requestURL = url.encodeURL(withUrl: url, withMethod: .get, withParameters: Search.parameters) else {
            completionHandler(.failure(APIError.notURL))
            return
        }
        AF.request(requestURL, method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: [
        "Accept": "application/json",
        "Authorization": "token \(UserDefaultsService.shared.getToken() ?? "")"
        ], interceptor: nil)
            .validate()
            .responseDecodable { (response: DataResponse<GithubRepositories, AFError>) in
                switch response.result {
                case .success(let repos):
                    self.repositories = repos.items
                    completionHandler(.success(()))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
        }
        
        
    }
}
