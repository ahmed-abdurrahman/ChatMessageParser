//
//  JSONSerializer.swift
//  ChatMessageParser
//
//  Created by Ahmed Abdurrahman on 3/1/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

import Foundation
class JSONSerializer {
    static func JSONSerialize(dictionary: [String: AnyObject]) -> String {
        do {
            
            let theJSONData = try NSJSONSerialization.dataWithJSONObject(
                dictionary ,
                options: NSJSONWritingOptions.PrettyPrinted )
            let theJSONText = NSString(data: theJSONData,
                encoding: NSASCIIStringEncoding)
            
            guard let serializedJSONText = theJSONText else {return "{}"}
            
            //NSJSONSerialization converts a URL string from http://... to http:\/\/... remove the extra escapes
            let serializedCleanJSON = serializedJSONText.stringByReplacingOccurrencesOfString("\\/", withString: "/")
            return serializedCleanJSON
        } catch let error as NSError {
            print(error)
            return "{}"
        }
    }
}