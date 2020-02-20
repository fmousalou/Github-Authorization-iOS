//
//  URLExtension.swift
//  iOS-Challenge
//
//  Created by Erfan Andesta on 2/18/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import Alamofire

extension URL {
    func encodeURL(withUrl url: URL,withMethod method: HTTPMethod,withParameters parameters: [String: Any]) -> URL? {
        
        guard let urlRequest = try? URLRequest(url: url, method: method), let requestURL = (try? URLEncoding.default.encode(urlRequest, with:parameters))?.url else {
            return nil
        }
        return requestURL
    }
}
