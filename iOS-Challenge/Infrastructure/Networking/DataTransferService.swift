//
//  DataTransferService.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/7/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Alamofire

public class endpointError:Error {}

public protocol DataTransferService {
    func request<T: Decodable, E: Requestable>(with endpoint: E,
                                               completion: @escaping (Swift.Result<T, Error>) -> Void)
}

public protocol DataTransferErrorLogger {
    func log(error: Error)
}

public final class DefaultDataTransferService {
    
    private let errorLogger: DataTransferErrorLogger
    
    public init(errorLogger: DataTransferErrorLogger = DefaultDataTransferErrorLogger()) {
        self.errorLogger = errorLogger
    }
}

extension DefaultDataTransferService: DataTransferService {
    
    public func request<T: Decodable, E: Requestable>(with endpoint: E,
                                                      completion: @escaping (Swift.Result<T, Error>) -> Void) {
        guard let url = try? endpoint.url() else {
            completion(.failure(endpointError()))
            return
        }
        
        Alamofire.request(url,
                          method: endpoint.method,
                          parameters: endpoint.bodyParamaters,
                          encoding: endpoint.bodyEncoding,
                          headers: endpoint.headerParamaters)
            .validate()
            .responseDecodable { [weak self] (response : DataResponse<T>) in
                switch response.result {
                case .success(let responseDecodable):
                    DispatchQueue.main.async { completion(Swift.Result.success(responseDecodable)) }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.errorLogger.log(error: error)
                        completion(Swift.Result.failure(error)) }
                }
        }
    }
}

// MARK: - Logger
final public class DefaultDataTransferErrorLogger: DataTransferErrorLogger {
    public init() { }
    
    public func log(error: Error) {
        #if DEBUG
        print("-------------")
        print("error: \(error)")
        #endif
    }
}
