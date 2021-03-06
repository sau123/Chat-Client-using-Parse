//
//  LoginViewController.swift
//  Chat Client With Parse
//
//  Created by Saumeel Gajera on 7/28/16.
//  Copyright © 2016 walmart. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    var userNameSegue : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginButtonTapped(sender: AnyObject) {
        print("login button tapped ")
        let emailText = emailLabel.text
        let passwordText = passwordLabel.text
        
        
        PFUser.logInWithUsernameInBackground(emailText!, password: passwordText!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil{
                print("logged in")
                self.userNameSegue = emailText!

                self.performSegueWithIdentifier("loginSegue", sender: self)
            }else{
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                let alertController = UIAlertController(title: "Log in Error", message: "Log in failed", preferredStyle: .Alert)
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion:  nil)
                
            }
         
            //hide the passwordlabel text
            self.passwordLabel.text = ""
            
        }
        
        
    }
    
    @IBAction func signUpButtonTapped(sender: AnyObject) {
        let emailText = emailLabel.text
        let passwordText = passwordLabel.text
        print("email id : ", emailLabel.text)
        print("Password : ", passwordLabel.text)
        
        let user = PFUser()
        
        user.username = emailText
        user.password = passwordText
        
        user.signUpInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
            if let error = error{
                
                let errorString = error.userInfo["error"] as? NSString
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                let alertController = UIAlertController(title: "Signup Error", message: errorString?.description, preferredStyle: .Alert)
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion:  nil)
            }else{
                print("Sign Upp-ed!!")
                self.userNameSegue = emailText!
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
        })
        
        emailLabel.text = ""
        passwordLabel.text = ""
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let navigationController = segue.destinationViewController as! UINavigationController
        let destinationController = navigationController.topViewController as! ChatViewController
        destinationController.username = userNameSegue
    }
    
    
}
