//
//  PatientLoginViewController.swift
//  MedLight
//
//  Created by Christopher Gutierrez on 11/15/14.
//  Copyright (c) 2014 TeamOne. All rights reserved.
//

import UIKit

class PatientLoginViewController: UIViewController, UITextFieldDelegate {

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
        
        var guy : [AnyObject]? = nil
        
        if (hospital.text == "" || mrn.text == "")
        {
            error = "Please complete all of the text fields."
        }
        else
        {
            var query = PFQuery(className: "Patient")
            query.whereKey("hospital", equalTo: hospital.text)
            
            if (query.findObjects().count == 0)
            {
                error = "We do not yet have any patients at Hospital: \(hospital.text)"
            }
            else
            {
                query.whereKey("mrn", equalTo: mrn.text)
                
                guy = query.findObjects()
                
                if (guy!.count == 0)
                {
                    error = "No information for patient with MRN: \(mrn.text). Please try again later."
                }
            }
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
            
            currentPatient = guy![0] as? PFObject
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            self.performSegueWithIdentifier("patientLogIn", sender: UIButton())
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
