//
//  HTTPManager.swift
//  iOS-Challenge
//
//  Created by anna on 11/13/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Foundation

final class HTTPManager {
    static let shared = HTTPManager()
    typealias HTTPHeader = (key:String, value: String)
    
    private (set) var headers = [String: String]()
    private (set) var baseUrl: URL!
    
    
    public init() { }
    
    static func configure(with headers: [String: String], baseUrl: URL) {
        self.shared.headers = headers
        self.shared.baseUrl = baseUrl
        
    }
    
    func append(header: HTTPHeader) {
        headers[header.key] = header.value
    }
    
    func append(headers: [String: String]) {
        headers.forEach({ self.headers[$0.key] = $0.value })
    }
    
    func remove(key : String) {
        headers.removeValue(forKey: key)
    }
    
    func clear() {
        headers.removeAll()
    }
}
