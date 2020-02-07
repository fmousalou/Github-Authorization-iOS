//
//  ProfileViewModel.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/7/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

protocol ProfileViewModelInput {
    
}

protocol ProfileViewModelOutput {
    
}

protocol ProfileViewModel: ProfileViewModelInput, ProfileViewModelOutput { }

final class DefaultProfileViewModel: ProfileViewModel {

}
