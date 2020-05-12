//
//  String.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 2/1/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
extension String{
    
    func threeSeperate() -> String {
        let copy = self.replacingOccurrences(of: ",", with: "")
        let num = NSNumber(value: Double(copy) ?? 0)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: num) ?? "0"
    }
}
