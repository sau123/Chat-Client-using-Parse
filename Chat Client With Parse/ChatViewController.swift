//
//  ChatViewController.swift
//  Chat Client With Parse
//
//  Created by Saumeel Gajera on 7/28/16.
//  Copyright © 2016 walmart. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var objs : [PFObject]?
    var username : String = ""
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.autocorrectionType = UITextAutocorrectionType.No
        
        print("username : \(username)")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.objs != nil {
            return (self.objs?.count)!
        }else{
            return 0
        }
    }
    
    
    func onTimer() {
        print("onTimer")
        
        let query = PFQuery(className:"Message_iOSFeb2016")
        query.whereKey("username", matchesRegex: self.username) // set the username here. coming from mayb segue
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    self.objs = objects
                    for object in objects {
                        if let message = object["text"] {
                            print(message)
                        }
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! MessageCell
        
        
        if self.objs![indexPath.row]["text"] != nil
        {
            cell.messageLabel.text = self.objs![indexPath.row]["text"] as? String
        }else{
            cell.messageLabel.text = ""
        }
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func composeButtonTapped(sender: AnyObject) {
        
        let message = PFObject(className:"Message_iOSFeb2016")
        message["text"] = textField.text
        message["username"] = self.username
        
        // set message by username coming from segue.
        
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("inserted")
            } else {
                print("error!")
            }
        }
        
        textField.text = ""
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
