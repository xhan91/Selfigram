//
//  ViewController.swift
//  Selfigram
//
//  Created by han xu on 2016-03-10.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    var image: UIImage? = nil
    
    @IBAction func screenTapped(sender: UITapGestureRecognizer) {
        self.navigationController?.navigationBarHidden = !(self.navigationController?.navigationBarHidden)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postImageView.image = self.image
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBarHidden = true
        self.tabBarController?.tabBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
}

