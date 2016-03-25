//
//  User.swift
//  Selfigram
//
//  Created by han xu on 2016-03-17.
//  Copyright © 2016 xhan91. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    let username: String
    let profileImage: UIImage
    
    init (username: String, profileImage: UIImage) {
        self.username = username
        self.profileImage = profileImage
    }
    
}