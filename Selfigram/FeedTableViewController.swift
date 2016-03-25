//
//  FeedTableViewController.swift
//  Selfigram
//
//  Created by han xu on 2016-03-22.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var words = ["Hello","my","name","is","Selfigram"]
    var posts = [Post]()
    //var newPost: Post?
    
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
            let me = User(username: "Josh", profileImage: UIImage(named: "Grumpy-Cat")!)
            let post = Post(image: image, user: me, comment: "My Selfie")
            posts.insert(post, atIndex: 0)
        }
        dismissViewControllerAnimated(true, completion: nil)
        tableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let me = User(username: "Josh", profileImage: UIImage(named: "Grumpy-Cat")!)
        let post0 = Post(image: UIImage(named: "Grumpy-Cat")!, user: me, comment: "post0")
        let post1 = Post(image: UIImage(named: "Grumpy-Cat")!, user: me, comment: "post1")
        let post2 = Post(image: UIImage(named: "Grumpy-Cat")!, user: me, comment: "post2")
        let post3 = Post(image: UIImage(named: "Grumpy-Cat")!, user: me, comment: "post3")
        let post4 = Post(image: UIImage(named: "Grumpy-Cat")!, user: me, comment: "post4")
        posts = [post0, post1, post2, post3, post4]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
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
