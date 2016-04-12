//
//  SelfieCell.swift
//  Selfigram
//
//  Created by han xu on 2016-03-24.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit
import Parse

class SelfieCell: UITableViewCell {

    
    @IBOutlet weak var selfieImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var heartAnimationView: UIImageView!
    
    var post: Post? {
        didSet {
            if let post = post {
                selfieImageView.image = nil
                let imageFile = post.image
                imageFile.getDataInBackgroundWithBlock({ (data, error) in
                    if let data = data {
                        let image = UIImage(data: data)
                        self.selfieImageView.image = image
                    }
                })
                usernameLabel.text = post.user.username
                commentLabel.text = post.comment
                likeButton.selected = false
                let query = post.likes.query()
                query.findObjectsInBackgroundWithBlock({ (users, error) in
                    if let users = users as? [PFUser] {
                        for user in users {
                            if user.objectId == PFUser.currentUser()?.objectId {
                                self.likeButton.selected = true
                            }
                        }
                    }
                })
            }
        }
    }
    
    func tapAnimation() {
        self.heartAnimationView.hidden = false
        self.heartAnimationView.transform = CGAffineTransformMakeScale(1, 1)
        
        UIView.animateWithDuration(1.0, delay: 0, options: [], animations: { 
            self.heartAnimationView.transform = CGAffineTransformMakeScale(3, 3)
            }) { (_) in
                self.heartAnimationView.hidden = true
        }
        likeButtonPressed(likeButton)
    }
    
    @IBAction func likeButtonPressed(sender: UIButton) {
        sender.selected = !sender.selected
        if let post = post, let user = PFUser.currentUser() {
            if sender.selected {
                
                // PFRelation has a useful method called addObject that adds the unique element
                // you are passing in as the argument. It will never add multiple copies
                // of the same element (in this case user)
                post.likes.addObject(user)
                
                // We have modified the likes property on post. We must now save it to Parse
                post.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if success {
                        print("like from user successfully saved")
                        
                        let activity = Activity(type: "like", post: post, user: user)
                        activity.saveInBackgroundWithBlock({ (success, error) in
                            if success {
                                print("activity succesfully saved")
                            }
                        })
                    }else{
                        print("error is \(error)")
                    }
                })
            } else {
                post.likes.removeObject(user)
                post.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if success {
                        print("like from user successfully removed")
                        
                        if let acitivityQuery = Activity.query(){
                            acitivityQuery.whereKey("post", equalTo: post)
                            acitivityQuery.whereKey("user", equalTo: user)
                            acitivityQuery.whereKey("type", equalTo: "like")
                            acitivityQuery.findObjectsInBackgroundWithBlock({ (activities, error) in
                                if let activities = activities {
                                    for activity in activities {
                                        activity.deleteInBackgroundWithBlock({ (success, error) in
                                            if success {
                                                print("deleted activity")
                                            }
                                        })
                                    }
                                }
                            })
                        }
                    }else{
                        print("error is \(error)")
                    }
                })
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
