//
//  ShadowView.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 2/1/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit

class ShadowView: UIView {
    
    @IBInspectable
    var borderColor: UIColor = .white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = 1
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 7{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat = 3
    
    @IBInspectable
    var shadowOffset: CGSize = CGSize(width: 1, height: 1)
    
    @IBInspectable
    var shadowOpacity: Float = 0.3
       
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        
        self.layer.cornerRadius = cornerRadius
    }
}
