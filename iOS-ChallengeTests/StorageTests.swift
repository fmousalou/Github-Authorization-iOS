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
    
   
    
    override func spec() {
        
        // using **sharedPrefrences**
        describe("SP_Test") {
            self.SP_removeAllIsTrue()
            self.SP_tokenNotNilAndSavedCorrectly()
        }
        

    }
    
    // MARK: - sharedPrefrences Test (1)
    
    func SP_tokenNotNilAndSavedCorrectly() {
        it("tokenNotNilAndSavedCorrectly", closure: {
            self.sharedPrefrences.set(key: .gitTokenTest, value: "123456789")
            let getVarSecound = self.sharedPrefrences.get(key: .gitTokenTest) as? String
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
        let getVar = self.sharedPrefrences.get(key: .gitTokenTest)
        expect(getVar).to(beNil())
    }
    
  
    
}

