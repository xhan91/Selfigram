//
//  Activity.swift
//  Selfigram
//
//  Created by han xu on 2016-04-07.
//  Copyright © 2016 xhan91. All rights reserved.
//

import Foundation
import UIKit
import Parse

class Activity: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return "Acitivity"
    }
    
    @NSManaged var user: PFUser
    @NSManaged var post: Post
    @NSManaged var type: String
    
    convenience init(type: String, post: Post, user: PFUser) {
        self.init()
        self.post = post
        self.user = user
        self.type = type
    }
    
}