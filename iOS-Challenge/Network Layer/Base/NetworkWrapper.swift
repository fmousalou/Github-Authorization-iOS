//
//  NetworkWrapper.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/28/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//


import Alamofire
import AlamofireObjectMapper
import RxSwift
import ObjectMapper
import KeychainSwift

protocol Wrapable {}

extension Wrapable {
    
    func request<T: Mappable>(url: String,
                              param: Parameters? = nil,
                              method: HTTPMethod = .post,
                              encoding: ParameterEncoding = JSONEncoding.default) -> Observable<Result<T>> {
        print(">>> Service : " ,url , ":::" ,param as Any)
        let observer = PublishSubject<Result<T>>()
        
        Alamofire.request(url,
                          method: method,
                          parameters: param,
                          encoding: encoding)
            .validate()
            .log()
            .responseObject { (response: DataResponse<T>) in
                let json = try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: [])
                print(json as Any)
                switch response.result {
                case .success(let value):
                    observer.onNext(Result.success(value: value))
                case .failure(let error):
                    //                    observer.onNext(Result.failure(error: RaikaError.failure(message: error.localizedDescription)))
                    break;
                }
                observer.onCompleted()
        }
        return observer
    }
    
    func requestWithToken<T: Mappable>(url: String,
                                       param: Parameters? = nil,
                                       method: HTTPMethod = .post,
                                       encoding: ParameterEncoding = JSONEncoding.default) -> Observable<Result<T>> {
        var token = ""
        let keychain = KeychainSwift()
        
        token = keychain.get("token") ?? ""
        
        let header = ["Authorization" : "token \(token)",
            "Accept": "application/vnd.github.v3+json"]
        print(header)
        print(">>> Service : " ,url , ":::" ,param as Any)
        let observer = PublishSubject<Result<T>>()
        
        Alamofire.request(url,
                          method: method,
                          parameters: param,
                          encoding: encoding,
                          headers: header)
            .validate()
            .log()
            .responseObject { (response: DataResponse<T>) in
                let json = try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: [])
                print(json as Any)
                switch response.result {
                case .success(let value):
                    observer.onNext(Result.success(value: value))
                    
                case .failure(let error):
                    //                    observer.onNext(Result.failure(error: )))
                    break;
                }
                observer.onCompleted()
        }
        return observer
    }
}
