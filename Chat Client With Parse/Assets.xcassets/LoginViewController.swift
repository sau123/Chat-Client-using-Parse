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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginButtonTapped(sender: AnyObject) {
        print("login button tapped ")
        let emailText = emailLabel.text
        let passwordText = passwordLabel.text
        
        var user = PFUser()
        
        PFUser.logInWithUsernameInBackground(emailText!, password: passwordText!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil{
                print("logged in")
                
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }else{

                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                let alertController = UIAlertController(title: "Log in Error", message: "Log in failed", preferredStyle: .Alert)
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion:  nil)
            
            }
            
        }
        
        
    }
    
    @IBAction func signUpButtonTapped(sender: AnyObject) {
        let emailText = emailLabel.text
        let passwordText = passwordLabel.text
        print("email id : ", emailLabel.text)
        print("Password : ", passwordLabel.text)
        
        let user = PFUser()
        
        if emailText != nil || passwordText != nil {
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
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                }
            })
            
            
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
