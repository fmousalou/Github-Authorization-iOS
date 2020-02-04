//
//  MoyaResponse+Data.swift
//  Watchlist
//
//  Created by Ali Baqbani on 5/12/17.
//  Copyright © 2017 7Watchlist. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper


typealias JSONType = [String: Any]
///Implemented functions to convert & map JSON to readable Model alongside being Observable.
extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    
    
    fileprivate func HandlePublicErrors(_ status: Int) {
        switch status {
        case ResponseStatus.unAuthorized.rawValue:
            UIApplication.shared.logOut()
            break
        default:
            break
        }
    }
    
    func objects<T: Mappable>(_ type: T.Type,resultKey:String, urlString:String? = nil) -> Observable<[T]> {
        return
            self.asObservable()
                .flatMap({ response -> Observable<[T]> in
                    do {
                        if let json = try response.mapJSON() as? [String: Any] {
                            let message = json["Message"] as? String
                            if let status = json["Status"] as? Int {
                                if status == ResponseStatus.success.rawValue {
                                    if let result = json["Result"] as? [String: Any] {
                                        if let jsonArray = result[resultKey] as? [[String: Any]] {
                                            let result = Mapper<T>().mapArray(JSONArray: jsonArray)
                                            return Observable.just(result)
                                        } else {
                                            let result = Mapper<T>().mapArray(JSONArray: [result])
                                            return Observable.just(result)
                                        }
                                    } else if  let jsonArray = json["Result"] as? [[String: Any]]  {
                                        let result = Mapper<T>().mapArray(JSONArray: jsonArray)
                                        return Observable.just(result)
                                    }else{
                                        return Observable.empty()
                                    }
                                } else if let message = message {
                                    self.HandlePublicErrors(status)
                                    return Observable.error(ResponseError(message: message, statusCode: status, validationError: []))
                                }
                            }
                        }
                        
                    } catch let error {
                        return Observable.error(error)
                    }
                    
                    return Observable.empty()
                })
    }
    
    
    func objectWithStatus<T:Mappable>(_ type: T.Type) -> Observable<(String , Int ,T?)> {
        
        return parse()
            .asObservable()
            .flatMap({ (value) -> Observable<(String , Int ,T?)> in
                
                
                guard let status = value["Status"] as? Int else { return Observable.empty() }
                
                let message = value["Message"] as? String ?? ""
                var object:T?
                if let result = value["Result"] as? [String:Any] {
                    if let data = result["Data"] as? [String: Any] {
                    object = Mapper<T>().map(JSON: data)!
                    }else{
                    object =  Mapper<T>().map(JSON: result)
                    }
                }
                
                return Observable.just((message,status ,object))
            })
    }
    
    
    func getStatusCode() -> Observable<Int> {
        return
            self.asObservable()
                .flatMap({ (response) -> Observable<Int> in
                    do {
                        if let json = try response.mapJSON() as? [String: Any] {
                            if let status = json["Status"] as? Int {
                                return Observable.just(status)
                            }
                        }
                    } catch let error {
                        return Observable.error(error)
                    }
                    return Observable.empty()
                })
    }
    
    
    func object<T: Mappable>(_ type: T.Type, resultKey: String) -> Observable<T> {
        
        return
            self.asObservable()
                .flatMap({ response -> Observable<T> in
                    do {
                        if let json = try response.mapJSON() as? [String: Any] {
                            
                            guard resultKey != "CheckUserStatus" else {
                                let convertedResult = Mapper<T>().map(JSON: json)!
                                return Observable.just(convertedResult)
                            }
                            
                            let message = json["Message"] as? String
                            if let status = json["Status"] as? Int {
                                if status == ResponseStatus.success.rawValue {
                                    if let result = json["Result"] as? [String: Any] {
                                        if let data = result[resultKey] as? [String: Any] {
                                            let convertedResult = Mapper<T>().map(JSON: data)!
                                            return Observable.just(convertedResult)
                                            
                                        } else {
                                            let convertedResult = Mapper<T>().map(JSON: result)!
                                            return Observable.just(convertedResult)
                                        }
                                    } else {
                                        return Observable.empty()
                                    }
                                } else if let message = message {
                                    
                                    var validationErrors : [ValidationError] = []
                                    if let result = json["Result"] as? [String: Any] {
                                        if let validationErrorArray = result["ValidationErrors"] as? [Any] {
                                            if let validationErrorElement = validationErrorArray.first as? [String: Any] {
                                                validationErrors = [Mapper<ValidationError>().map(JSON: validationErrorElement)!]
                                            }
                                        }
                                    }
                                    
                                    return Observable.error(ResponseError(message: message, statusCode: status, validationError: validationErrors))
                                }
                            }
                        }
                        
                    } catch let error {
                        return Observable.error(error)
                    }
                    
                    return Observable.empty()
                })
    }

    
    func primitive<T>(_ type: T.Type) -> Observable<T?> {
        return
            self.asObservable()
                .flatMap({ response -> Observable<T?> in
                    do {
                        guard let json = try response.mapJSON() as? [String: Any] else {
                            throw ResponseError(message: "Invalid data", statusCode: 0, validationError: [])
                        }
                        
                        guard let status = json["Status"] as? Int,
                            let message = json["Message"] as? String else {
                                throw ResponseError(message: "Invalid data", statusCode: 0, validationError: [])
                        }
                        
                        if status == ResponseStatus.success.rawValue {
                            if let result = json["Result"] as? [String: Any] {
                                let mapped = result as! T
                                return Observable.just(mapped)
                            }
                        }
                        
                        throw ResponseError(message: message, statusCode: 0, validationError: [])
                        
                    } catch let error {
                        return Observable.error(error)
                    }
                })
    }
    
    
    ///message,message,objects,nextPageAvailable
    func objectWithStatus<T:Mappable>(_ type: T.Type) -> Observable<(String , Int ,T?,Bool)> {
        
        return parse()
            .asObservable()
            .flatMap({ (value) -> Observable<(String , Int ,T?,Bool)> in
                
                
                guard let status = value["Status"] as? Int else { return Observable.empty() }
                
                let message = value["Message"] as? String ?? ""
                var object:T?
                if let result = value["Result"] as? [String:Any]{
                 if let data = result["Data"] as? [String: Any] {
                   object = Mapper<T>().map(JSON: data)!
                   }else{
                   object =  Mapper<T>().map(JSON: result)
                   }
                }
                
                let nextPage = value["nextPage"] as? Bool ?? false
                
                return Observable.just((message,status ,object,nextPage))
            })
    }
    
    ///message,message,[objects],nextPageAvailable
    func objectsWithStatus<T:Mappable>(_ type: T.Type) -> Observable<(String , Int ,[T]?,Bool)> {
        
        return parse()
            .asObservable()
            .flatMap({ (value) -> Observable<(String , Int ,[T]?,Bool)> in
                
                
                guard let status = value["Status"] as? Int else { return Observable.empty() }
                
                let message = value["Message"] as? String ?? ""
                var objects:[T]?
                var nextPage = false
                if let result = value["Result"] as? [String:Any]{
                    if let jsonArray = result["Data"] as? [[String: Any]] {
                        objects = Mapper<T>().mapArray(JSONArray: jsonArray)
                    }
                    nextPage = ((result["TotalPages"] as? Int ?? 0) > 0 ) ?? false
                } else if let result = value["Result"] as? [[String:Any]] {
                    objects = Mapper<T>().mapArray(JSONArray: result)
                    nextPage = ((value["TotalPages"] as? Int ?? 0) > 0 ) ?? false
                }
                return Observable.just((message,status ,objects,nextPage))
            })
    }

    
    private func parse() -> Single<JSONType>  {
        
       return filterSuccessfulStatusCodes()
            .flatMap({ (response) -> PrimitiveSequence<SingleTrait, JSONType> in
                guard let json = try response.mapJSON() as? JSONType else {
                    return Single.error(ResponseError(message: "Invalid data", statusCode: 0, validationError: []))
                }
                return Single.just(json)
            })
    }
    
//    func filterResponseOnSuccessful() -> Single<JSONType> {
//        return parse()
//            .flatMap({ json -> PrimitiveSequence<SingleTrait, JSONType> in
//                guard let status = json["Status"] as? Int,
//                    status == ResponseStatus.success.rawValue else {
//                        if let message = json["Message"] as? String {
//                            return Single.error(AuthenticationError(message: message))
//                        } else if let status = json["Status"] as? Int {
//                            return Single.error(ResponseError(message: "Invalid data", statusCode: status, validationError: []))
//                        } else {
//                            return Single.error(AuthenticationError(message: "Invalid data"))
//                        }
//                }
//                return Single.just(json)
//            })
//    }
    
    
   
}

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == JSONType {
    
    private func filterJSONResult()
        -> Single<JSONType> {
        return self.flatMap({ (value) -> PrimitiveSequence<SingleTrait, JSONType> in
            guard let result = value["Result"] as? [String: Any] else {
                return Single.error(ResponseError(message: "Invalid data", statusCode: 0, validationError: []))
            }
            return Single.just(result)
        })
    }
    
    private func filterJSONArray()
        -> Single<[JSONType]> {
        return self.filterJSONResult()
            .flatMap({ (value) -> PrimitiveSequence<SingleTrait, [JSONType]> in
                guard let data = value["Data"] as? [[String: Any]] else {
                    return Single.error(ResponseError(message: "Invalid data", statusCode: 0, validationError: []))
                }
                return Single.just(data)
            })
    }
    
    func ignore() -> Single<Void> {
        return self.flatMap({ (value) -> PrimitiveSequence<SingleTrait, Void> in
            return Single.just(())
        })
    }
    
    func filterObjectAndMap<T: Mappable>(_ type: T.Type)
        -> Single<T> {
        return filterJSONResult()
            .flatMap({ (value) -> PrimitiveSequence<SingleTrait, T> in
                
                guard let mapped = Mapper<T>().map(JSON: value) else {
                    return Single.error(ResponseError(message: "Invalid data", statusCode: 0, validationError: []))
                }
                return Single.just(mapped)
            })
    }
    
    func filterObjectAndMap<T>(_ type: T.Type)
        -> Single<T> {
            return filterJSONResult()
                .flatMap({ (value) -> PrimitiveSequence<SingleTrait, T> in
                    guard let mapped = value as? T else {
                        return Single.error(ResponseError(message: "Invalid data", statusCode: 0, validationError: []))
                    }
                    return Single.just(mapped)
                })
    }
}

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == [JSONType] {
    func filterObjectsAndMap<T: Mappable>(_ type: T.Type)
        -> Single<[T]> {
            return flatMap(
                { value -> PrimitiveSequence<SingleTrait, [T]> in
                    let mapped = Mapper<T>().mapArray(JSONArray: value)
                    return Single.just(mapped)
            })
    }
}

