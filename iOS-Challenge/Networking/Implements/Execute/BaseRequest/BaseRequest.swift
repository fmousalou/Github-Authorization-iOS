//
//  BaseRequest.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

public protocol BaseRequest {
    associatedtype RequestType: Encodable
    associatedtype ResponseType: Decodable
    associatedtype ErrorType: Decodable
    var data: RequestData<RequestType> { get }
}

public extension BaseRequest {
    func execute (
        dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
        onSuccess: @escaping (ResponseType) -> Void,
        onError: @escaping (ErrorType) -> Void,
        onConnectionError: @escaping (ConnError) -> Void
        ) {
        dispatcher.dispatch(
            request: self.data,
            onSuccess: { (responseData: Data, statusCode: Int) in
                do {
                    print("NETWORK RESPONSE: \(String(data: responseData, encoding: .utf8))")
                    print("NETWORK STATUS CODE: \(statusCode)")
                    
                    if statusCode > 499 {
                        onConnectionError(ConnError.underDevelopment)
                    }
                    
                    let jsonDecoder = JSONDecoder()
                    var result: ResponseType
                    let jsonErrorDecoder = JSONDecoder()
                    var errorData: ErrorType
                    let emptyString: Data = "{}".data(using: .utf8) ?? Data()
                    
                    if 200..<300 ~= statusCode {
                        result = try jsonDecoder.decode(ResponseType.self, from: responseData)
                        errorData = try jsonErrorDecoder.decode(ErrorType.self, from: emptyString)
                    } else if 400..<500 ~= statusCode {
                        result = try jsonDecoder.decode(ResponseType.self, from: emptyString)
                        errorData = try jsonErrorDecoder.decode(ErrorType.self, from: responseData)
                    } else {
                        result = try jsonDecoder.decode(ResponseType.self, from: emptyString)
                        errorData = try jsonErrorDecoder.decode(ErrorType.self, from: emptyString)
                    }
                    
                    DispatchQueue.main.async {
                        if 200..<300 ~= statusCode {
                            onSuccess(result)
                        } else if 400..<500 ~= statusCode {
                            onError(errorData)
                        } else {
                            onConnectionError(ConnError.underDevelopment)
                        }
                    }
                    
                } catch _ {
                    DispatchQueue.main.async {
                        onConnectionError(ConnError.internetConnection)
                    }
                }
        },
            onError: { (error: Error) in
                DispatchQueue.main.async {
                    onConnectionError(ConnError.internetConnection)
                }
        }
        )
    }
}
