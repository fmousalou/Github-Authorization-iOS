//
//  ProfileViewModel.swift
//  iOS-Challenge
//
//  Created by Erfan Andesta on 2/19/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import Alamofire

class ProfileViewModel {
    
    private(set) var profile: Box<Profile?> = Box(Profile())
    
    func getProfile(completionHandler: @escaping ((Swift.Result<Void, Error>) -> Void)) {
        guard let url = URL(string: URLs.userURL) else {
            completionHandler(.failure(APIError.notURL))
            return
        }
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: [
        "Accept": "application/json",
        "Authorization": "token \(UserDefaultsService.shared.getToken() ?? "")"
        ], interceptor: nil)
            .validate()
            .responseDecodable(completionHandler: { (response: DataResponse<Profile, AFError>) in
                switch response.result {
                case .success(let profile):
                    self.profile.value = profile
                    completionHandler(.success(()))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            })
    }
}
