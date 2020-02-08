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
    lazy var apiDataTransferService: DataTransferService = {
        let apiDataTransferService = DefaultDataTransferService()
        return apiDataTransferService
    }()
    
    lazy var keyChainBearerTokenRepository: BearerTokenRepository = {
        return KeyChainBearerTokenRepository(dependency: KeyChainBearerTokenRepository.Dependency(
            serviceKey: appConfigurations.keychainServiceKey,
            tokenKey: appConfigurations.keychainKey))
    }()
        
    func makeAuthorizationSceneDIContainer() -> AuthorizationSceneDIContainer {
        return AuthorizationSceneDIContainer(dependency: AuthorizationSceneDIContainer.Dependency(
            clientId: appConfigurations.apiClientId,
            redirectUrl: appConfigurations.redirectUrl,
            clientSecret: appConfigurations.apiClientSecret,
            state: appConfigurations.state,
            scopes: appConfigurations.githubScopes,
            keychainServiceKey: appConfigurations.keychainServiceKey,
            tokenKey: appConfigurations.keychainKey,
            apiDataTransferService: apiDataTransferService,
            bearerTokenRepository: keyChainBearerTokenRepository))
    }
    
    func makeMainSceneDIContainer() -> MainSceneDIContainer {
        return MainSceneDIContainer(
            dependency: MainSceneDIContainer.Dependency(
                apiDataTransferService: apiDataTransferService,
                bearerTokenRepository: keyChainBearerTokenRepository,
                appDIContainer: self))
    }
}

