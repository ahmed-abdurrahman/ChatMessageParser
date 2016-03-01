//
//  ViewController.swift
//  ChatMessageParser
//
//  Created by Ahmed Abdurrahman on 2/12/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let message = "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
    override func viewDidLoad() {
        super.viewDidLoad()
        

       MessageParser.parseMessage(message) { (parsedMessageJSON) -> Void in
            print(parsedMessageJSON)
        }
    }
   
}

