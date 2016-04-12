//
//  FeedTableViewController.swift
//  Selfigram
//
//  Created by han xu on 2016-03-22.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }

    func updateData() {
        if let query = Post.query() {
            query.orderByDescending("createdAt")
            query.includeKey("user")
            query.findObjectsInBackgroundWithBlock{ (posts, error) in
                if let posts = posts as? [Post] {
                    self.posts = posts
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    @IBAction func doubleTappedSelfie(sender: UITapGestureRecognizer) {
        let tapLocation = sender.locationInView(tableView)
        if let indexPathAtTapLocation = tableView.indexPathForRowAtPoint(tapLocation){
            let cell = tableView.cellForRowAtIndexPath(indexPathAtTapLocation) as! SelfieCell
            cell.tapAnimation()
        }
    }
    
    @IBAction func cameraButtonPressed(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) -> Void in
            self.setPhotoSource("Camera")
        }
        let libraryAction = UIAlertAction(title: "Library", style: .Default) { (action) -> Void in
            self.setPhotoSource("Library")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func setPhotoSource(source: String) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        if (source == "Camera") {
            pickerController.sourceType = .Camera
            pickerController.cameraDevice = .Front
            pickerController.cameraCaptureMode = .Photo
        } else {
            pickerController.sourceType = .PhotoLibrary
        }
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if let imageData = UIImageJPEGRepresentation(image, 0.25),
                let imageFile = PFFile(data: imageData),
                let user = PFUser.currentUser() {
                    let comment = "This is my Selfie"
                    let post = Post(image: imageFile, user: user, comment: comment)
                    post.saveInBackgroundWithBlock({ (success, error) in
                        if success {
                            print("Upload a new photo successfully")
                            self.posts.insert(post, atIndex: 0)
                            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                        }
                    })
                }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func refreshPulled(sender: UIRefreshControl) {
        updateData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "fromFeedToPost":
                if let destination = segue.destinationViewController as? PostViewController,
                    let cell = sender as? SelfieCell {
                    if let image = cell.selfieImageView.image {
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
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! SelfieCell
        let post = posts[indexPath.row]
        cell.post = post
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
