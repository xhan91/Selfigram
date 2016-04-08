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
    
    var username: String = ""
    var profileImageData: NSData? = NSData()
    var profileImage: UIImage? {
        get { return UIImage(data: profileImageData!) }
        set { profileImageData = UIImageJPEGRepresentation(newValue!, 1.0)! }
    }
}