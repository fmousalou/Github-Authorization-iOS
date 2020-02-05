//
//  AppDIContainer.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

final class AppDIContainer
{
    lazy var appConfigurations = AppConfigurations()
    
    func makeAuthorizationSceneDIContainer() -> AuthorizationSceneDIContainer {
        return AuthorizationSceneDIContainer(dependency: AuthorizationSceneDIContainer.Dependency(
            clientId: appConfigurations.apiClientId,
            redirectUrl: appConfigurations.redirectUrl,
            clientSecret: appConfigurations.apiClientSecret,
            state: appConfigurations.state, keychainServiceKey: appConfigurations.keychainServiceKey, tokenKey: appConfigurations.keychainKey))
    }
}

