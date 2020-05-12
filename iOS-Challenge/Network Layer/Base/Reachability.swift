//
//  Reachability.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/24/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

// An observable that completes when the app gets online (possibly completes immediately).
//func connectedToInternet() -> Observable<Bool> {
//    return ReachabilityManager.shared.reach
//}

final class Reachability {
    static let shared = Reachability()

    private let reachability = NetworkReachabilityManager()

    var didBecomeReachable: Observable<Void> { return _didBecomeReachable.asObservable() }
    private let _didBecomeReachable = PublishSubject<Void>()

    init() {
        if let reachability = self.reachability {
            reachability.listener = { [weak self] in
                self?.update($0)
            }
            reachability.startListening()
        }
    }

    private func update(_ status: NetworkReachabilityManager.NetworkReachabilityStatus) {
        if case .reachable = status {
            _didBecomeReachable.onNext(())
        }
    }
}


