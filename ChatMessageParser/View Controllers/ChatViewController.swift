//
//  ChatViewController.swift
//  ChatMessageParser
//
//  Created by Ahmed Abdurrahman on 3/1/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var sendingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var writeMessageView: UIView!
    @IBOutlet weak var writeMessageBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var dismissKeyboardView: UIView!
    
    let MyMessageCellIdentifier = "MyMessageCell"
    let ParserReplyCellIdentifier = "ParserReplyCell"
    var tableModel = ChatTableViewModel()
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.rowHeight = UITableViewAutomaticDimension;
        self.tableview.estimatedRowHeight = 70;
        self.tableview.contentInset = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 60.0, right: 0.0)
        self.dismissKeyboardView.hidden = true

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        addWelcomeMessage()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        writeMessageView.transform = CGAffineTransformMakeTranslation(0, writeMessageView.bounds.height)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        spring(0.1) {
            self.writeMessageView.transform = CGAffineTransformMakeTranslation(0, 0)
        }
    }
    
    
    func addWelcomeMessage(){
        addMessage("Hi there! It's my pleasure to analyse your chat messages. (I can detect @mentions, (emoticons) & links). Type in your first message..", type: .Reply)
    }
    
    // MARK: - Actions
    @IBAction func sendTapped() {
        if messageTextView.text != "" {
            doneEditing()

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
    
    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) {
       doneEditing()
    }
    
    func doneEditing(){
        self.dismissKeyboardView.hidden = true
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()

        self.writeMessageBottomConstraint.constant = keyboardFrame.size.height + 0
        self.dismissKeyboardView.hidden = false
        self.dismissKeyboardView.alpha = 0.1
        print("will show")
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.writeMessageBottomConstraint.constant = 0
        self.dismissKeyboardView.hidden = true
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
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

extension ChatViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(textView: UITextView) {
    }
    
    func textViewDidEndEditing(textView: UITextView){
        textView.resignFirstResponder()
    }
    
    func textViewDidChange(textView: UITextView) {

    }
}