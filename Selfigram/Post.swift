//
//  Post.swift
//  Selfigram
//
//  Created by han xu on 2016-03-17.
//  Copyright © 2016 xhan91. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Post: Object {
    
    
    dynamic var user: User?
    dynamic var comment: String = ""
    dynamic var imageData: NSData? = NSData()
    
    var image: UIImage? {
        get { return UIImage(data: imageData!) }
        set { imageData = UIImageJPEGRepresentation(newValue!, 1.0)! }
    }
    
    override static func ignoredProperties() -> [String] {
        return ["image"]
    }

}