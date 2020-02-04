//
//  MoyaProviderHelper.swift
//  WhiteBoard
//
//  Created by anna on 7/8/1398 AP.
//  Copyright © 1398 AP Atin. All rights reserved.
//

import Moya

public extension MoyaProvider {
    // Original: public final class func customeEndpointMapping(for target: Target) -> Endpoint<Target> {
    // Coused error
    public final class func customeEndpointMapping(for target: Target) -> Endpoint {
        return Endpoint(
            url: URL(target: target).absoluteString.removingPercentEncoding!,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
}
