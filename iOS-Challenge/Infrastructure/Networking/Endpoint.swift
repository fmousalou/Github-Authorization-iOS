//
//  Endpoint.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/7/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Alamofire

public protocol Requestable {
    var baseURLString: String { get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var queryParameters: [String: Any]? { get }
    var headerParamaters: [String: String]? { get }
    var bodyParamaters: [String: Any]? { get }
    var bodyEncoding: ParameterEncoding { get }
    
    func url() throws -> URL
}



public class Endpoint<R>: Requestable {
    public typealias Response = R
    
    public var baseURLString: String
    public var path: String?
    public var method: HTTPMethod
    public var queryParameters: [String: Any]?
    public var headerParamaters: [String: String]?
    public var bodyParamaters: [String: Any]?
    public var bodyEncoding: ParameterEncoding
    
    init(baseURLString: String,
         path: String?,
         method: HTTPMethod = .get,
         queryParameters: [String: Any]? = nil,
         headerParamaters: [String: String]? = nil,
         bodyParamaters: [String: Any]? = nil,
         bodyEncoding: ParameterEncoding = JSONEncoding.prettyPrinted) {
        self.baseURLString = baseURLString
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.headerParamaters = headerParamaters
        self.bodyParamaters = bodyParamaters
        self.bodyEncoding = bodyEncoding
    }
}


enum RequestGenerationError: Error {
    case components
}

// MARK: - Implementation of requestable
extension Requestable {
    
    public func url() throws -> URL {
        guard var finalUrl = URL(string: baseURLString) else  { throw RequestGenerationError.components }

        if let p = path {
            finalUrl = finalUrl.appendingPathComponent(p)
        }
                
        guard var urlComponents = URLComponents(url: finalUrl, resolvingAgainstBaseURL: true) else { throw RequestGenerationError.components }
        var urlQueryItems = [URLQueryItem]()
        
        queryParameters?.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }

        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return url
    }
    
}

fileprivate extension Dictionary {
    var queryString: String {
        
        return self.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}
