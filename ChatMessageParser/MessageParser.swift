//
//  MessageParser.swift
//  ChatMessageParser
//
//  Created by Ahmed Abdurrahman on 2/12/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

import Foundation

enum ContentTypes: String {
    case URL = "links"
    case Mention = "mentions"
    case Emoticon = "emoticons"
}

class MessageParser {
    
    /**
     Converts chat message string into a JSON string containing information about its contents.
     
     Special content to look for includes:
     
     1. @mentions - A way to mention a user. Always starts with an '@' and ends when hitting a non-word character. (http://help.hipchat.com/knowledgebase/articles/64429-how-do-mentions-work-)
     2. Emoticons - For this exercise, you only need to consider 'custom' emoticons which are alphanumeric strings, no longer than 15 characters, contained in parenthesis. You can assume that anything matching this format is an emoticon. (https://www.hipchat.com/emoticons)
     3. Links - Any URLs contained in the message, along with the page's title.
     Note, URLs must start with http or www

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
    static func parseMessage(message: String, completion: (parsedMessageJSON: String)->Void) {

        var result = [String: [AnyObject]]()
        
        // 1. Match all
        let mentions = RegexMatcher.matchMentions(message)
        let emoticons = RegexMatcher.matchEmoticons(message)
        let urls = RegexMatcher.matchURLs(message)
        print(urls)
        if mentions.count > 0 {
            result[ContentTypes.Mention.rawValue] = prepareMentions(mentions)
        }
        
        if emoticons.count > 0 {
            result[ContentTypes.Emoticon.rawValue] = prepareEmoticons(emoticons)
        }
        
        if urls.count > 0 {
            URLTitleGrabber.getURLsTitles(urls, completion: { (urlsWithTitles) -> Void in
                
                result[ContentTypes.URL.rawValue] = urlsWithTitles
                let jsonString = JSONSerializer.JSONSerialize(result)
                completion(parsedMessageJSON: jsonString)
            })
        } else {
            let jsonString = JSONSerializer.JSONSerialize(result)
            completion(parsedMessageJSON: jsonString)
        }
    }
    
    /**
        Prepares matched mentions by removing the @ character at the begenning.
     */
    static func prepareMentions(mentions: [String]) -> [String] {
        var preparedMentions = [String]()
        for mention in mentions {
            let preparedMention = String(mention.characters.dropFirst())
            preparedMentions.append(preparedMention)
        }
        
        return preparedMentions
    }
   
    
    /**
        Prepares matched emoticons by removing the first ( & last ) characters.
     */
    static func prepareEmoticons(emoticons: [String]) -> [String] {
        var preparedEmoticons = [String]()
        for emoticon in emoticons {
            if emoticon.characters.count < 2 {continue}
            
            let range:Range<String.Index> = Range<String.Index>(start: emoticon.startIndex.advancedBy(1), end: emoticon.endIndex.advancedBy(-1))
            let preparedEmoticon = emoticon.substringWithRange(range)

            preparedEmoticons.append(preparedEmoticon)
        }
        
        return preparedEmoticons
    }
}













