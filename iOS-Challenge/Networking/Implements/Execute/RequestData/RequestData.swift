//
//  RequestData.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

public struct RequestData<T: Encodable> {
    public let path: String
    public let method: HTTPMethod
    public let params: T?
    public let requestType: RequestType?
    public let imageFieldName: String?
    public let imageFileName: String?
    public let imageData: Data?
    public let imageMimeType: String?
    
    public init (
        path: String,
        method: HTTPMethod = .get,
        params: T? = nil,
        requestType: RequestType? = .applicationJson,
        imageFieldName: String? = "picture",
        imageFileName: String? = "imagename.png",
        imageData: Data? = nil,
        imageMimeType: String? = "image/png"
        ) {
        self.path = path
        self.method = method
        self.params = params
        self.requestType = requestType
        self.imageFieldName = imageFieldName
        self.imageFileName = imageFileName
        self.imageData = imageData
        self.imageMimeType = imageMimeType
    }
    
}
