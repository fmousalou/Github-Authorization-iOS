//
//  Box.swift
//  iOS-Challenge
//
//  Created by Erfan Andesta on 2/19/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

class Box<Element> {
    
    typealias Listener = (Element) -> Void
    private var listener: Listener?
    
    var value: Element {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: Element) {
        self.value = value
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
