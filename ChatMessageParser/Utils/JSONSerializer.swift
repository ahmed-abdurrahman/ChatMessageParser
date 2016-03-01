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
                options: NSJSONWritingOptions(rawValue: 0))
            let theJSONText = NSString(data: theJSONData,
                encoding: NSASCIIStringEncoding)
            
            guard let serializedJSONText = theJSONText else {return "{}"}
            
            return serializedJSONText as String
        } catch let error as NSError {
            print(error)
            return "{}"
        }
    }
}