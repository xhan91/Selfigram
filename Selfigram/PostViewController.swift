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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postImageView.image = self.image
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

