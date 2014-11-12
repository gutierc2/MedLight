//
//  RegistrationViewController.swift
//  MedLight
//
//  Created by Christopher Gutierrez on 11/11/14.
//  Copyright (c) 2014 TeamOne. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var drtitle: UITextField!
    @IBOutlet weak var specialty: UITextField!
    @IBOutlet weak var hospital: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var pagerNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    //    @IBAction func textFieldShouldReturn(sender: UITextField) {
    //        //fullName.resignFirstResponder();
    //    }
    
    func displayAlert(title:String, error:String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        fullName.resignFirstResponder()
        drtitle.resignFirstResponder()
        specialty.resignFirstResponder()
        hospital.resignFirstResponder()
        email.resignFirstResponder()
        phoneNumber.resignFirstResponder()
        pagerNumber.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signUpPressed(sender: AnyObject) {
        var error = ""
        
        if (fullName.text == "" || drtitle.text == "" || specialty.text == "" || hospital.text == "" || email.text == "" || phoneNumber.text == "" || pagerNumber.text == "" || password.text == "")
        {
            error = "Please complete all of the text fields above."
        }
        
        if error != ""
        {
            displayAlert("Oh, no!", error: error)
        }
        else
        {
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var user = PFUser()
            user.username = email.text
            user.password = password.text
            user["fullName"] = fullName.text
            user["title"] = drtitle.text
            user["specialty"] = specialty.text
            user["hospital"] = hospital.text
            user["email"] = email.text
            user["phoneNumber"] = phoneNumber.text
            user["pagerNumber"] = pagerNumber.text
            user["patients"] = []
            
            user.signUpInBackgroundWithBlock
                {
                    (succeeded: Bool!, signupError: NSError!) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if signupError == nil
                    {
                        // Hooray! Let them use the app now.
                        println("signed up")
                    }
                    else
                    {
                        if let errorString = signupError.userInfo?["error"] as? NSString
                        {
                            
                            error = errorString
                            
                        }
                        else
                        {
                            
                            error = "Please try again later."
                            
                        }
                        self.displayAlert("Could Not Sign Up", error: error)
                    }
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
