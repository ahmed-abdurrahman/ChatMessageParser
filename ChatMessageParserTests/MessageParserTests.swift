//
//  MessageParserTests.swift
//  ChatMessageParser
//
//  Created by Ahmed Abdurrahman on 3/1/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

import XCTest

class MessageParserTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPrepareMentions() {
        let mentions: [String] = ["@chris", "@ahmed","@"]
        let preparedMentions: [String] = ["chris","ahmed",""]
        
        XCTAssertEqual(MessageParser.prepareMentions(mentions), preparedMentions, "@ at the begenning of the mentions shall be dropped")
    }

}
