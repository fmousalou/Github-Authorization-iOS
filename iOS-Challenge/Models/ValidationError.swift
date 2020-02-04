//
//  ValidationError.swift
//  iOS-Challenge
//
//  Created by anna on 11/15/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Foundation
import ObjectMapper



public class ValidationError: Mappable {
    
    // MARK: - Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let key = "Key"
        static let errorMessages = "ErrorMessages"

    }
    
    // MARK: - Properties
    public var key: String?
    public var errorMessages: [String]?
    
    
    // MARK: - ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map){
    }

    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        
        key <- map[SerializationKeys.key]
        errorMessages <- map[SerializationKeys.errorMessages]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = key { dictionary[SerializationKeys.key] = value }
        if let value = errorMessages { dictionary[SerializationKeys.errorMessages] = value }

        return dictionary
    }
    
}


