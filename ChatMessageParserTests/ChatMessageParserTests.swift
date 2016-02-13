//
//  ChatMessageParserTests.swift
//  ChatMessageParserTests
//
//  Created by Ahmed Abdurrahman on 2/12/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

import XCTest

@testable import ChatMessageParser

class ChatMessageParserTests: XCTestCase {
    
    func testValidMentionsAreMatched(){
        var message = "@chris how are you?"
        var mentions = ["@chris"]
        XCTAssertEqual(MessageParser.matchMentions(message), mentions, "Mention at start should match")
        
        message = "hi @chris how are you?"
        mentions = ["@chris"]
        XCTAssertEqual(MessageParser.matchMentions(message), mentions, "Mention at middle should match")
        
        message = "hi how are you @chris"
        mentions = ["@chris"]
        XCTAssertEqual(MessageParser.matchMentions(message), mentions, "Mention at end should match")
        
        message = "hi how are you @chris @joe"
        mentions = ["@chris", "@joe"]
        XCTAssertEqual(MessageParser.matchMentions(message), mentions, "Multiple mentions should match")

        message = "@chris"
        mentions = ["@chris"]
        XCTAssertEqual(MessageParser.matchMentions(message), mentions, "Only mention should match")
        
        message = "@chris_joe how are you?"
        mentions = ["@chris_joe"]
        XCTAssertEqual(MessageParser.matchMentions(message), mentions, "Mention with underscore should match")
        
        message = "Hi @CHRIS how are you?"
        mentions = ["@CHRIS"]
        XCTAssertEqual(MessageParser.matchMentions(message), mentions, "Mention with capital case should match")
    }
    
    func testSepcialCharactersFormMentionBoundary(){
        var message = "How are you @chris?"
        var mentions = ["@chris"]
        XCTAssertEqual(MessageParser.matchMentions(message), mentions, "Mention ending with ? should be matched")
        
        message = "Hi,@chris how are you?"
        mentions = ["@chris"]
        XCTAssertEqual(MessageParser.matchMentions(message), mentions, "Mention starting with special charcter should be matched")
        
        
        message = "Did you see this @chris!"
        mentions = ["@chris"]
        XCTAssertEqual(MessageParser.matchMentions(message), mentions, "Mention ending with ? should be matched")
        
        message = "@chris. how are you?"
        mentions = ["@chris"]
        XCTAssertEqual(MessageParser.matchMentions(message), mentions, "Mention ending with . should be matched")

        message = "@chris, how are you?"
        mentions = ["@chris"]
        XCTAssertEqual(MessageParser.matchMentions(message), mentions, "Mention ending with , should be matched")
        
        message = "@chris-joe how are you?"
        mentions = ["@chris"]
        XCTAssertEqual(MessageParser.matchMentions(message), mentions, "Mention ending with - should be matched befor the -")
    }
    
    func testEmailAreNotMatchedAsMention(){
        let message = "This is my email chris@gmail.com"
        let mentions = []
        
        XCTAssertEqual(MessageParser.matchMentions(message), mentions, "Emails shouldn't be considered as mentions")
    }
    
    func testMatchURLs() {
        var message = "See this:  http://www.nbcolympics.com"
        var URLs = ["http://www.nbcolympics.com"]
        XCTAssertEqual(MessageParser.matchURLs(message), URLs, "URL starting with http not matched correctly")

        message = "See this:  https://www.nbcolympics.com"
        URLs = ["https://www.nbcolympics.com"]
        XCTAssertEqual(MessageParser.matchURLs(message), URLs, "URL starting with https not matched correctly")
        
        message = "See this:  HTTP://www.nbcolympics.com"
        URLs = ["HTTP://www.nbcolympics.com"]
        XCTAssertEqual(MessageParser.matchURLs(message), URLs, "URL starting with HTTP not matched correctly")
        
        message = "See this:  HTTPS://www.nbcolympics.com"
        URLs = ["HTTPS://www.nbcolympics.com"]
        XCTAssertEqual(MessageParser.matchURLs(message), URLs, "URL starting with HTTPS not matched correctly")
        
        message = "See this:  www.nbcolympics.com"
        URLs = ["www.nbcolympics.com"]
        XCTAssertNotEqual(MessageParser.matchURLs(message), URLs, "URL starting with www not matched correctly")
    }
    
    
}
