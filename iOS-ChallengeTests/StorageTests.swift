//
//  iOS_ChallengeTests.swift
//  iOS-ChallengeTests
//
//  Created by Farshad Mousalou on 1/28/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import iOS_Challenge





class StorageSpec: QuickSpec {
    
    lazy var sharedPrefrences = {
        SharedPrefrences()
    }()
    
    lazy var userDataHelper = {
        UserDataHelper()
    }()
    
    override func spec() {
        
        // using **sharedPrefrences**
        describe("SP_Test") {
            self.SP_removeAllIsTrue()
            self.SP_tokenNotNilAndSavedCorrectly()
        }
        
        // using **userDataHelper**
        describe("UD_Test") {
            self.SP_removeAllIsTrue() // Delete to get fail <<<<<<<=======
            self.UD_tokenIsNil()
            self.UD_tokenNotNilAndSavedCorrectly()
        }
    }
    
    // MARK: - sharedPrefrences Test (1)
    
    func SP_tokenNotNilAndSavedCorrectly() {
        it("tokenNotNilAndSavedCorrectly", closure: {
            self.sharedPrefrences.set(key: .gitToken, value: "123456789")
            let getVarSecound = self.sharedPrefrences.get(key: .gitToken) as? String
            expect(getVarSecound).toNot(beNil())
            expect(getVarSecound).to(contain("123456789"))
        })
    }
    
    func SP_removeAllIsTrue() {
        it("removeAllIsTrue", closure: {
            self.sharedPrefrences.removeAll()
            self.SP_tokenIsNil()
        })
    }
    
    func SP_tokenIsNil() {
        let getVar = self.sharedPrefrences.get(key: .gitToken)
        expect(getVar).to(beNil())
    }
    
    // MARK: - UserDataHelper Test (2)
    
    private func UD_tokenIsNil() {
        it("tokenIsNil", closure: {
            let token = self.userDataHelper.getToken()
            expect(token).to(beNil())
        })
    }
    
    private func UD_tokenNotNilAndSavedCorrectly() {
        it("tokenNotNilAndSavedCorrectly", closure: {
            self.userDataHelper.setToken(token: "jfhkhkskfs;a")
            let token = self.userDataHelper.getToken()
            expect(token).toNot(beNil())
            expect(token).to(contain("jfhkhkskfs;a"))
        })
    }
    
}

