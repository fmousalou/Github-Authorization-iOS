//
//  UIView+Shake.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/7/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

extension UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: self.center.x - 4.0, y: self.center.y)
        animation.toValue = CGPoint(x: self.center.x + 4.0, y: self.center.y)
        layer.add(animation, forKey: "position")
    }
}
