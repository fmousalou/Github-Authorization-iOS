//
//  AuthorizationViewModel.swift
//  iOS-Challenge
//
//  Created by Erfan Andesta on 2/18/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import Alamofire

enum AuthorizationError: Error {
    case failedRequest
    case notURL
}
class AuthorizationViewModel {
    
    //MARK: - Vars -
    
    //MARK: - Functions -
    
    func login(completionHandler: (Swift.Result<URL, AuthorizationError>) -> Void) {
        Authorization.resetCode()
        guard let url = URL(string: URLs.authorizationURL), let requestURL = url.encodeURL(withUrl: url, withMethod: .get, withParameters: Authorization.parameters) else {
            completionHandler(.failure(.notURL))
            return
        }
        completionHandler(.success(requestURL))
    }
    func getAuthentication(with code: String, completionHandler: @escaping (Swift.Result<AccessTokenResponse, AuthorizationError>) -> Void) {
        
        guard let url = URL(string: URLs.authorizationAccessCodeURL) else {
            completionHandler(.failure(.notURL))
            return
        }
        Authorization.setCode(code: code)
        
        Alamofire.request(url, method: .post,
                          parameters: Authorization.parameters, encoding: JSONEncoding.prettyPrinted,
                          headers: ["Accept":"application/json"])
            .validate()
            .responseDecodable { (response : DataResponse<AccessTokenResponse>) in
                switch response.result {
                case .success(let accessToken):
                    completionHandler(.success(accessToken))
                case .failure( _):
                    completionHandler(.failure(.failedRequest))
                }
        }
    }
}
