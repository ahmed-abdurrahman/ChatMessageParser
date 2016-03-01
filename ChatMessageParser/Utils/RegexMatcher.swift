//
//  RegexMatcher.swift
//  ChatMessageParser
//
//  Created by Ahmed Abdurrahman on 3/1/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

import Foundation

enum Regex:String {
    case URL = "(?i)https?://(?:www\\.)?\\S+(?:/|\\b)"
    case Mention = "\\B@\\w+"
    case Emoticon = "\\(\\w{1,15}\\)"
}

class RegexMatcher {
    
    static func listMatches(pattern: String, inString string: String) -> [String] {
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSMakeRange(0, string.characters.count)
        guard let matches = regex?.matchesInString(string, options: [], range: range) else {return []}
        
        return matches.map {
            let range = $0.range
            return (string as NSString).substringWithRange(range)
        }
    }
    
    static func matchURLs(message: String) -> [String] {
        return listMatches(Regex.URL.rawValue, inString: message)
    }
    
    
    static func matchMentions(message: String) -> [String] {
        return listMatches(Regex.Mention.rawValue, inString: message)
    }
    
    static func matchEmoticons(message: String) -> [String] {
        return listMatches(Regex.Emoticon.rawValue, inString: message)
    }
}