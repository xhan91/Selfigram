//
//  ProfileViewController.swift
//  Selfigram
//
//  Created by han xu on 2016-03-15.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var user: User? {
        didSet {
            usernameLabel.text = user?.username
            profileImageView.image = user?.profileImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        usernameLabel.text = "Josh"
//        if let firstUser = uiRealm.objects(User).first {
//            self.user = firstUser
//        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentUser = PFUser.currentUser() {
            let user = User()
            user.username = currentUser.username!
            
            
            
            if let imageFile = currentUser["profileImage"] as? PFFile {
                imageFile.getDataInBackgroundWithBlock({ (data, error) in
                    if let imageData = data {
                        user.profileImage = UIImage(data: imageData)
                        self.user = user
                    }
                })
            }
            
        }
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!

    @IBAction func cameraButtonPressed(sender: UIButton) {
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
            if let imageData = UIImageJPEGRepresentation(image, 1.0),
                let imageFile = PFFile(data: imageData),
                let currentUser = PFUser.currentUser() {
                currentUser["profileImage"] = imageFile
                currentUser.saveInBackgroundWithBlock({ (success, error) in
                    if success {
                        print("upload and save new profile image")
                    }
                })
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
