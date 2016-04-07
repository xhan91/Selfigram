//
//  SelfieCell.swift
//  Selfigram
//
//  Created by han xu on 2016-03-24.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit

class SelfieCell: UITableViewCell {

    
    @IBOutlet weak var selfieImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var post: Post? {
        didSet {
            if let imageFile = post?.image {
                imageFile.getDataInBackgroundWithBlock({ (data, error) in
                    if let data = data {
                        let image = UIImage(data: data)
                        self.selfieImageView.image = image
                    }
                })
            }
            usernameLabel.text = post?.user.username
            commentLabel.text = post?.comment
        }
    }
    
    @IBAction func likeButtonPressed(sender: UIButton) {
        sender.selected = !sender.selected
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
