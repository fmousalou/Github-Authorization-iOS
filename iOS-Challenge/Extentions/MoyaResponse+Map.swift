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
    
    func  object<T: Mappable>(_ type: T.Type) -> Observable<T?>  {
        return
            self.asObservable()
                .flatMap({ response -> Observable<T?> in
                    do {
                        if let json = try response.mapJSON() as? [String: Any] {
                            let message = json["message"] as? String
                            if let errors = json["errors"] as? [[String: Any]],
                                let error = errors.first {
                                let code =  error["code"] as? Int
                                 self.HandlePublicErrors(code ?? 0)
                                return Observable.error(ResponseError(message: message ?? "Api error", statusCode: code ?? 0, validationError: []))
                            }else{
                                let object = Mapper<T>().map(JSON: json)
                                return Observable.just(object)
                            }
                            
                        }
                    
                } catch let error {
                    return Observable.error(error)
        }
        
        return Observable.empty()
    })
}

//    func object<T: Mappable>(_ type: T.Type) -> Observable<T?> {
//
//        return parse()
//            .asObservable()
//            .flatMap({ (value) -> Observable<T?>  in
//                let object = Mapper<T>().map(JSON: value)
//                return Observable.just(object)
//            })
//    }

//    private func parse() -> Single<JSONType>  {
//
//        return filterSuccessfulStatusCodes()
//            .flatMap({ (response) -> PrimitiveSequence<SingleTrait, JSONType> in
//                guard let json = try response.mapJSON() as? JSONType else {
//                    return Single.error(ResponseError(message: "Invalid data", statusCode: 0, validationError: []))
//                }
//                return Single.just(json)
//            })
//    }

}



