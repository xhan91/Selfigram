//
//  PhotoLibraryCollectionViewCell.swift
//  Selfigram
//
//  Created by han xu on 2016-03-27.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit

class PhotoLibraryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photo: UIImage? {
        didSet {
            photoImageView.image = photo
        }
    }
    
}
