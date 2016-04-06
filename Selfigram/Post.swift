//
//  Post.swift
//  Selfigram
//
//  Created by han xu on 2016-03-17.
//  Copyright © 2016 xhan91. All rights reserved.
//

import Foundation
import UIKit
import Parse

class Post: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return "Post"
    }
    
    @NSManaged var user: PFUser
    @NSManaged var image: PFFile
    @NSManaged var comment: String
    
    convenience init(image:PFFile, user:PFUser, comment: String) {
        self.init()
        self.image = image
        self.user = user
        self.comment = comment
    }
    
}