//
//  NotificationUtility.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/5/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

public enum NotificationNames: String
{
    case recievedTokenFromServer
}

public enum NotificationObjectKeys: String
{
    case oAuthToken
}
extension NotificationCenter
{
    static func postNotification(name notificationName: NotificationNames, userInfo: Dictionary<NotificationObjectKeys,Any>! = nil, object: Any? = nil)
    {
        NotificationCenter.default.post(name: Notification.Name(notificationName.rawValue), object: object, userInfo: userInfo)
    }
    
    static func addObserver(_ observer: Any, selector: Selector, notificationName: NotificationNames, object: Any? = nil)
    {
        NotificationCenter.default.addObserver(observer, selector: selector, name: Notification.Name(notificationName.rawValue), object: object)
    }
    
    static func removeObserver(_ observer: Any, name: NotificationNames? = nil, object: Any? = nil)
    {
        guard let notificationName = name else {
            NotificationCenter.default.removeObserver(observer)
            return
        }
        NotificationCenter.default.removeObserver(observer, name: Notification.Name(notificationName.rawValue), object: object)
    }
}

