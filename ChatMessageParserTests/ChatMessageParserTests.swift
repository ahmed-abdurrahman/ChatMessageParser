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
    
    func testMatchURLs() {
        var message = "@chris, good morning! (megusta) (coffee). See this:  http://www.nbcolympics.com"
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
