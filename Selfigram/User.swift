//
//  User.swift
//  Selfigram
//
//  Created by han xu on 2016-03-17.
//  Copyright © 2016 xhan91. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class User: Object {
    
    dynamic var username: String = ""
    dynamic var profileImageData: NSData? = NSData()
    var profileImage: UIImage? {
        get { return UIImage(data: profileImageData!) }
        set { profileImageData = UIImageJPEGRepresentation(newValue!, 1.0)! }
    }
    
    override static func ignoredProperties() -> [String] {
        return ["profileImage"]
    }
}