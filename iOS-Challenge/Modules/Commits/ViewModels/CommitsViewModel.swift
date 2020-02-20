//
//  CommitsViewModel.swift
//  iOS-Challenge
//
//  Created by erfan on 12/1/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Foundation
import Alamofire

class CommitsViewModel {
    
    private(set) var commits = [Commit]()
    private(set) var owner: String
    private(set) var repo: String
    
    init(owner: String, repo: String) {
        self.owner = owner
        self.repo = repo
    }
    func getCommits(completionHandler: @escaping ((Swift.Result<Void, Error>) -> Void)) {
        guard let url = URL(string: URLs.commitsURL(forOwner: owner, forRepo: repo)) else {
            completionHandler(.failure(APIError.notURL))
            return
        }
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: [
        "Accept": "application/json",
        "Authorization": "token \(UserDefaultsService.shared.getToken() ?? "")"
        ], interceptor: nil)
            .validate()
            .responseDecodable { (response: DataResponse<[Commit], AFError>) in
                switch response.result {
                case .success(let commits):
                    self.commits = commits
                    completionHandler(.success(()))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
        }
        
        
    }
}
 
