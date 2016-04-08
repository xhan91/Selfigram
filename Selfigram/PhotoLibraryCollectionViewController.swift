//
//  photoLibraryCollectionViewController.swift
//  Selfigram
//
//  Created by han xu on 2016-03-25.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit
import Parse

private let reuseIdentifier = "Cell"

class PhotoLibraryCollectionViewController: UICollectionViewController {

    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        // user = uiRealm.objects(User).first
        updateData()
    }
    
    func updateData() {
        if let query = Post.query(), let user = PFUser.currentUser() {
            query.whereKey("user", equalTo: user)
            query.orderByDescending("createdAt")
            query.findObjectsInBackgroundWithBlock({ (posts, error) in
                if let posts = posts as? [Post] {
                    self.posts = posts
                    self.collectionView!.reloadData()
                }
            })
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "fromPhotoLibraryToPost":
                if let destination = segue.destinationViewController as? PostViewController,
                    let cell = sender as? PhotoLibraryCollectionViewCell {
                    if let image = cell.photoImageView.image {
                        destination.image = image
                    } else {
                        print("image is nil")
                    }
                }
            default:
                break
            }
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count ?? 0
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoLibraryCollectionViewCell
        let post = posts[indexPath.row]
        let imageFile = post.image
        imageFile.getDataInBackgroundWithBlock { (data, error) in
            if let data = data {
                let image = UIImage(data: data)
                cell.photo = image
            }
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
