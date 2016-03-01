//
//  ChatViewController.swift
//  ChatMessageParser
//
//  Created by Ahmed Abdurrahman on 3/1/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    /// IBOutlets
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var sendingActivityIndicator: UIActivityIndicatorView!
    
    let MyMessageCellIdentifier = "MyMessageCell"
    let ParserReplyCellIdentifier = "ParserReplyCell"
    var tableModel = ChatTableViewModel()
    
    /// View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.rowHeight = UITableViewAutomaticDimension;
        self.tableview.estimatedRowHeight = 70;
        self.tableview.contentInset = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 60.0, right: 0.0)
//        tableModel.addDummyMessages()
    }
    
    /// Actions
    @IBAction func sendTapped() {
        if messageTextView.text != "" {
            let message = messageTextView.text
            addMessage(message, type: .Mine)

            messageTextView.text = ""
            sendButton.hidden = true
            sendingActivityIndicator.startAnimating()
            messageTextView.userInteractionEnabled = false

            MessageParser.parseMessage(message, completion: { (parsedMessageJSON) -> Void in
                print(parsedMessageJSON)
                self.sendButton.hidden = false
                self.sendingActivityIndicator.stopAnimating()
                self.messageTextView.userInteractionEnabled = true
                self.addMessage(parsedMessageJSON, type: .Reply)
            })
        }
    }
    
    func addMessage(message: String, type: MessageType){
        self.tableModel.addMessage(message, type: type)
        self.tableview.reloadData()
        self.scrollToBottom()
    }
    
    func scrollToBottom() {
        // Handle Scrolling
        self.delay(0.001) { () -> Void in
                let numberOfRows = self.tableModel.messages.count
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (0))
                self.tableview.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Middle, animated: false)
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

}

extension ChatViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let message = tableModel.messages[indexPath.row]
        
        var identifier: String
        if message.type == .Mine {
            identifier = MyMessageCellIdentifier
        } else {
            identifier = ParserReplyCellIdentifier
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! ChatMessageCell
        cell.messageLabel.text = message.message
        
        return cell
    }
}