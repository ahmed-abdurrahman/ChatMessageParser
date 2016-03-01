//
//  RegexMatcherTests.swift
//  RegexMatcherTests
//
//  Created by Ahmed Abdurrahman on 2/12/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

import XCTest

class RegexMatcherTests: XCTestCase {
    
    func testValidMentionsAreMatched(){
        var message = "@chris how are you?"
        var mentions = ["@chris"]
        XCTAssertEqual(RegexMatcher.matchMentions(message), mentions, "Mention at start should match")
        
        message = "hi @chris how are you?"
        mentions = ["@chris"]
        XCTAssertEqual(RegexMatcher.matchMentions(message), mentions, "Mention at middle should match")
        
        message = "hi how are you @chris"
        mentions = ["@chris"]
        XCTAssertEqual(RegexMatcher.matchMentions(message), mentions, "Mention at end should match")
        
        message = "hi how are you @chris @joe"
        mentions = ["@chris", "@joe"]
        XCTAssertEqual(RegexMatcher.matchMentions(message), mentions, "Multiple mentions should match")

        message = "@chris"
        mentions = ["@chris"]
        XCTAssertEqual(RegexMatcher.matchMentions(message), mentions, "Only mention should match")
        
        message = "@chris_joe how are you?"
        mentions = ["@chris_joe"]
        XCTAssertEqual(RegexMatcher.matchMentions(message), mentions, "Mention with underscore should match")
        
        message = "Hi @CHRIS how are you?"
        mentions = ["@CHRIS"]
        XCTAssertEqual(RegexMatcher.matchMentions(message), mentions, "Mention with capital case should match")
    }
    
    func testSepcialCharactersFormMentionBoundary(){
        var message = "How are you @chris?"
        var mentions = ["@chris"]
        XCTAssertEqual(RegexMatcher.matchMentions(message), mentions, "Mention ending with ? should be matched")
        
        message = "Hi,@chris how are you?"
        mentions = ["@chris"]
        XCTAssertEqual(RegexMatcher.matchMentions(message), mentions, "Mention starting with special charcter should be matched")
        
        
        message = "Did you see this @chris!"
        mentions = ["@chris"]
        XCTAssertEqual(RegexMatcher.matchMentions(message), mentions, "Mention ending with ? should be matched")
        
        message = "@chris. how are you?"
        mentions = ["@chris"]
        XCTAssertEqual(RegexMatcher.matchMentions(message), mentions, "Mention ending with . should be matched")

        message = "@chris, how are you?"
        mentions = ["@chris"]
        XCTAssertEqual(RegexMatcher.matchMentions(message), mentions, "Mention ending with , should be matched")
        
        message = "@chris-joe how are you?"
        mentions = ["@chris"]
        XCTAssertEqual(RegexMatcher.matchMentions(message), mentions, "Mention ending with - should be matched befor the -")
    }
    
    func testEmailAreNotMatchedAsMention(){
        let message = "This is my email chris@gmail.com"
        let mentions = []
        
        XCTAssertEqual(RegexMatcher.matchMentions(message), mentions, "Emails shouldn't be considered as mentions")
    }
    
    func testMatchValidURLs() {
        var message = "See this:  http://www.nbcolympics.com"
        var URLs = ["http://www.nbcolympics.com"]
        XCTAssertEqual(RegexMatcher.matchURLs(message), URLs, "URL starting with http should match")

        message = "See this:  https://www.nbcolympics.com"
        URLs = ["https://www.nbcolympics.com"]
        XCTAssertEqual(RegexMatcher.matchURLs(message), URLs, "URL starting with https should match")
        
        message = "See this:  HTTP://www.nbcolympics.com"
        URLs = ["HTTP://www.nbcolympics.com"]
        XCTAssertEqual(RegexMatcher.matchURLs(message), URLs, "URL starting with HTTP should match")
        
        message = "See this:  HTTPS://www.nbcolympics.com"
        URLs = ["HTTPS://www.nbcolympics.com"]
        XCTAssertEqual(RegexMatcher.matchURLs(message), URLs, "URL starting with HTTPS should match")
        
        message = "See this:  www.nbcolympics.com"
        URLs = ["www.nbcolympics.com"]
        XCTAssertEqual(RegexMatcher.matchURLs(message), URLs, "URL starting with only www shoul match")
        
        message = "See this:  http://subdomain.nbcolympics.com chris?"
        URLs = ["http://subdomain.nbcolympics.com"]
        XCTAssertEqual(RegexMatcher.matchURLs(message), URLs, "URL starting with http and subdomain name should match")
    }
    
    func testComplexFormedURLsMatch(){
        var message = "See this:  http://subdomain.nbcolympics.com?param=hi&param2=there chris?"
        var URLs = ["http://subdomain.nbcolympics.com?param=hi&param2=there"]
        XCTAssertEqual(RegexMatcher.matchURLs(message), URLs, "URL with parameters should match")
        
        message = "See this:  http://subdomain.nbcolympics.com?param=hi&param2=there chris?"
        URLs = ["http://subdomain.nbcolympics.com?param=hi&param2=there"]
        XCTAssertEqual(RegexMatcher.matchURLs(message), URLs, "URL with parameters should match")
       
        message = "Did you visit https://www.atlassian.com?param=@h-i*u^r/l chris?"
        URLs = ["https://www.atlassian.com?param=@h-i*u^r/l"]
        XCTAssertEqual(RegexMatcher.matchURLs(message), URLs, "special characters inside URL shoud be matched")
    }
    
    func testInvalidURLsShouldNotMatch(){
        var message = "See this: subdomain.nbcolympics.com"
        let URLs = []
        XCTAssertEqual(RegexMatcher.matchURLs(message), URLs, "URL not starting with http or www should not match")
        
        message = "See this: http:// subdomain.nbcolympics.com"
        XCTAssertEqual(RegexMatcher.matchURLs(message), URLs, "URL with white space should not match")
    }
    
    func testMatchValidEmoticons(){
        var message = "(happy) Hi there"
        var emoticons = ["(happy)"]
        XCTAssertEqual(RegexMatcher.matchEmoticons(message), emoticons, "Starting with emoticon should match")
        
        message = "Hi (happy) there"
        emoticons = ["(happy)"]
        XCTAssertEqual(RegexMatcher.matchEmoticons(message), emoticons, "Emoticon at the middle should match")
        
        message = "Hi there (happy)"
        emoticons = ["(happy)"]
        XCTAssertEqual(RegexMatcher.matchEmoticons(message), emoticons, "Emoticon at the end should match")
        
        message = "Hi there are you (happy)(chears)(awesome)"
        emoticons = ["(happy)", "(chears)", "(awesome)"]
        XCTAssertEqual(RegexMatcher.matchEmoticons(message), emoticons, "Multiple emoticons should match")
        
        message = "(happy1) Hi there"
        emoticons = ["(happy1)"]
        XCTAssertEqual(RegexMatcher.matchEmoticons(message), emoticons, "Alph-numeric emoticons should match")
        
        message = "Hi there(happy)"
        emoticons = ["(happy)"]
        XCTAssertEqual(RegexMatcher.matchEmoticons(message), emoticons, "Emoticon inside string should match")
        
        message = "Hi there are you (happy)?"
        emoticons = ["(happy)"]
        XCTAssertEqual(RegexMatcher.matchEmoticons(message), emoticons, "Emoticons with special characters boundary should match")
    }
    
    func testInvalidEmoticonsShouldNotMatch(){
        var message = "Hi (ha ppy)"
        let emoticons = []
        XCTAssertEqual(RegexMatcher.matchEmoticons(message), emoticons, "Emoticons whith white space should not match")
        
        message = "Hi there (123456789abcdefg)"
        XCTAssertEqual(RegexMatcher.matchEmoticons(message), emoticons, "Emoticons whith more than 15 characters should not match")
        
        message = "Hi there ()"
        XCTAssertEqual(RegexMatcher.matchEmoticons(message), emoticons, "Empty parenthesis should no match")
    }
    
    func testEmoticonsDelimitedWithSpecialCharactersShouldMatch(){
        var message = "Hi there are you (happy)?"
        let emoticons = ["(happy)"]
        XCTAssertEqual(RegexMatcher.matchEmoticons(message), emoticons, "Emoticons whith white space should not match")
        
        message = "I'm (happy)."
        XCTAssertEqual(RegexMatcher.matchEmoticons(message), emoticons, "Emoticons whith white space should not match")
        
        message = "Hi there are you (happy)there"
        XCTAssertEqual(RegexMatcher.matchEmoticons(message), emoticons, "Emoticons whith white space should not match")
    }
}
