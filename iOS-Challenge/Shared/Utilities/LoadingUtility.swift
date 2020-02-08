//
//  LoadingUtility.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/5/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import PKHUD

public class LoadingUtility: NSObject
{
    public static func showLoading()
    {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
    }
    
    public static func hideLoading()
    {
        PKHUD.sharedHUD.hide(true)
    }
}
