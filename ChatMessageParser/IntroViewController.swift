//
//  ViewController.swift
//  ChatMessageParser
//
//  Created by Ahmed Abdurrahman on 2/12/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var getStartedButton: UIButton!
    
    @IBOutlet weak var aboutCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var welcomeCenterConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.prepareForAnimation()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animateScreenElementsIn()
    }

    func prepareForAnimation(){
        logoImage.alpha = 0
        
        let xTransform = +1*view.bounds.width
        welcomeLabel.transform = CGAffineTransformMakeTranslation(xTransform, 0)
        aboutLabel.transform = CGAffineTransformMakeTranslation(xTransform, 0)
        getStartedButton.transform = CGAffineTransformMakeTranslation(xTransform, 0)
    }
    
    func animateScreenElementsIn(){
        UIView.animateWithDuration(0.5) { () -> Void in
            self.logoImage.alpha = 1
        }
        
        
        spring(0.2) {
            self.welcomeLabel.transform = CGAffineTransformMakeTranslation(0, 0)
        }

        spring(0.4) {
            self.aboutLabel.transform = CGAffineTransformMakeTranslation(0, 0)
        }
        
        
        spring(0.6) {
            self.getStartedButton.transform = CGAffineTransformMakeTranslation(0, 0)
        }
    }
    
    func animateScreenElementsOut(){
        let xTransform = -1*view.bounds.width

        spring(0) {
            self.getStartedButton.transform = CGAffineTransformMakeTranslation(xTransform, 0)
            self.logoImage.alpha = 0
        }
        
        spring(0.1) {
            self.aboutLabel.transform = CGAffineTransformMakeTranslation(xTransform, 0)
        }

        spring(0.2){
            self.welcomeLabel.transform = CGAffineTransformMakeTranslation(xTransform, 0)
        }
    }
    
    @IBAction func getStartedTapped() {
        self.animateScreenElementsOut()
        self.delay(0.4){
            self.performSegueWithIdentifier("OpenChatScreenSegue", sender: self)
        }
    }
   
}

