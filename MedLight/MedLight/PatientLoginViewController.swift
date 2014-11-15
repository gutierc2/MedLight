//
//  PatientLoginViewController.swift
//  MedLight
//
//  Created by Christopher Gutierrez on 11/15/14.
//  Copyright (c) 2014 TeamOne. All rights reserved.
//

import UIKit

class PatientLoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var hospital: UITextField!
    @IBOutlet weak var mrn: UITextField!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title:String, error:String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func signInPressed(sender: UIButton)
    {
        var error = ""
        
        if (fullName.text == "" || hospital.text == "" || mrn.text == "")
        {
            error = "Please complete all of the text fields."
        }
        
        if (error != "")
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
            
            var query = PFQuery(className: "Patient")
            query.whereKey("hospital", equalTo: hospital.text)
            query.whereKey("mrn", equalTo: mrn.text)
            
            var guy = query.findObjects()
            
            if (guy.count == 0)
            {
                var p = PFObject(className: "Patient")
                p["fullName"] = fullName.text
                p["hospital"] = hospital.text
                p["mrn"] = mrn.text
                p["doctors"] = []
                p["newsfeed"] = []
                p.save()
                currentPatient = p
            }
            else
            {
                currentPatient = guy[0] as? PFObject
            }
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            // PERFORM SEGUE TO NEWSFEED HERE
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        fullName.resignFirstResponder()
        hospital.resignFirstResponder()
        mrn.resignFirstResponder()
        return true;
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
