//
//  UIViewControllerExtension.swift
//  ChatMessageParser
//
//  Created by Ahmed Abdurrahman on 3/2/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

import UIKit

extension UIViewController {
    func spring(delay: NSTimeInterval, animations: ()->Void, completion: ((finished: Bool)->Void)?) {
        UIView.animateWithDuration(0.8, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 5, options: .CurveEaseInOut, animations: animations, completion: completion)
    }
    
    func spring(delay: NSTimeInterval, animations: ()->Void){
        spring(delay, animations: animations, completion: nil)
    }
    
    func delay(delayInSeconds:Double, closure:()->()) {
        
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            dispatch_after(
                dispatch_time(
                    DISPATCH_TIME_NOW,
                    Int64(delayInSeconds * Double(NSEC_PER_SEC))
                ),
                dispatch_get_main_queue(), closure)
        })
    }
}