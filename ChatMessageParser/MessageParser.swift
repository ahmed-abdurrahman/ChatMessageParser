//
//  MessageParser.swift
//  ChatMessageParser
//
//  Created by Ahmed Abdurrahman on 2/12/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

import Foundation

enum Regex:String {
    case URL = "(?i)https?://(?:www\\.)?\\S+(?:/|\\b)"
//    case Mention = ""
//    case Emoticon = ""
}

class MessageParser {
    
    /**
     Conversts chat message string into a JSON string containing information about its contents.
     
     Special content to look for includes:
     
     1. @mentions - A way to mention a user. Always starts with an '@' and ends when hitting a non-word character. (http://help.hipchat.com/knowledgebase/articles/64429-how-do-mentions-work-)
     2. Emoticons - For this exercise, you only need to consider 'custom' emoticons which are alphanumeric strings, no longer than 15 characters, contained in parenthesis. You can assume that anything matching this format is an emoticon. (https://www.hipchat.com/emoticons)
     3. Links - Any URLs contained in the message, along with the page's title.
     Note, URLs must start with http or https

     # Example
     - Input: "@chris, good morning! (megusta) (coffee). See this:  http://www.nbcolympics.com"
     - Return (string):
     {
        "mentions": [
             "chris"
         ],
        "emoticons": [
            "megusta",
            "coffee"
        ],
         "links": [{
            "url": "http://www.nbcolympics.com",
            "title": "NBC Olympics | 2014 NBC Olympics in Sochi Russia"
         }]
     }
     
     - Parameters:
        - message: The chat message to be parsed
     
     - Returns: JSON string containing information about the contents. Special content to look for includes @mentions, Emoticons & URLs.
        In case no special content found, return an empty JSON object.
     
     */
    static func parseMessage(message: String) -> String {
        // TODO
        // 1. Match all
        // 2. Find URL titles
        // 3. Serialize to JSON
        
        return message
    }

    static func matchURLs(message: String) -> [String] {
        return listMatches(Regex.URL.rawValue, inString: message)
    }

    static func listMatches(pattern: String, inString string: String) -> [String] {
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSMakeRange(0, string.characters.count)
        guard let matches = regex?.matchesInString(string, options: [], range: range) else {return []}
        
        return matches.map {
            let range = $0.range
            return (string as NSString).substringWithRange(range)
        }
    }
}













