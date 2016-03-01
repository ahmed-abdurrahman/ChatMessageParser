//
//  ViewController.swift
//  ChatMessageParser
//
//  Created by Ahmed Abdurrahman on 2/12/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func getStartedTapped() {
        self.performSegueWithIdentifier("OpenChatScreenSegue", sender: self)
    }
   
}

