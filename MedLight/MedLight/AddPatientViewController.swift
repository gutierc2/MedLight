//
//  postViewController.swift
//  MedLight
//
//  Created by Kay Lab on 11/13/14.
//  Copyright (c) 2014 TeamOne. All rights reserved.
//

import UIKit

class AddPatientViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title:String, error:String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    @IBOutlet var imageToPost: UIImageView!
    
    @IBOutlet var fullName: UITextField!
    
    @IBOutlet var mrn: UITextField!
    
    @IBOutlet var notes: UITextField!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        fullName.resignFirstResponder()
        mrn.resignFirstResponder()
        notes.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("Image selected")
        self.dismissViewControllerAnimated(true, completion:nil)
        
        imageToPost.image = image
        
        
    }
    
    @IBAction func chooseImage(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.Camera
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    @IBAction func postImage(sender: AnyObject) {
        
        var error = ""
        
        if (fullName.text == "") {
            
            error = "Please enter a name for the patient."
        
        } else if (mrn.text == "") {
            
            error = "Please enter in a MRN for the patient."
            
        } else if (notes.text == "") {
            
            error = "Please enter a chief complaint."
            
        }
        if (error != "") {
            
            displayAlert("Cannot Add Patient", error: error)
        
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var patient = PFObject(className: "Patient")
            
            var user = PFUser.currentUser()
            
            if patient["doctors"] == nil
            {
                patient["doctors"] = []
            }
            
            patient.addObject(user["email"] as String, forKey: "doctors")
    
            patient["fullName"] = fullName.text
            patient["mrn"] = mrn.text
            patient["notes"] = notes.text
            patient["hospital"] = user["hospital"] as String
            
            if patient["newsfeed"] == nil
            {
                patient["newsfeed"] = []
            }
            
            user.addObject(mrn.text, forKey: "patients")
            
            patient.saveInBackgroundWithBlock{(success: Bool!, error: NSError!) -> Void in
                
                user.save()
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if success == false {
                    
                    self.displayAlert("Could Not Add Patient", error: "Please try again later")
                    
                } else {
                    
                    let imageData = UIImagePNGRepresentation(self.imageToPost.image)
                    
                    let imageFile = PFFile(name: "image.png", data: imageData)
                    
                    patient["imageFie"] = imageFile
                    
                    patient.saveInBackgroundWithBlock{(success: Bool!, error: NSError!) -> Void in
                        
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        if success == false {
                            
                            self.displayAlert("Could Not Add Patient", error: "Please try again later")
                        } else {
                            
                            self.displayAlert("Patient Added!", error : "The patient has been added successfully.")
                            
                            self.imageToPost.image = UIImage(named: "315px-Blank_woman_placeholder.png")
                            
                            self.fullName.text = ""
                            self.mrn.text = ""
                            self.notes.text = ""
                            
                        }
                    }
                    
                }
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imageToPost.image = UIImage(named: "315px-Blank_woman_placeholder.png")
        
        fullName.text = ""
        mrn.text = ""
        notes.text = ""
        
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
