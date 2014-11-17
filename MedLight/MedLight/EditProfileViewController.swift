//
//  EditProfileViewController.swift
//  MedLight
//
//  Created by Kay Lab on 11/15/14.
//  Copyright (c) 2014 TeamOne. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title:String, error:String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBOutlet var fullName: UITextField!
    
    @IBOutlet var specialty: UITextField!
    
    @IBOutlet var doctorTitle: UITextField!
    
    @IBOutlet var hospital: UITextField!
    
    @IBOutlet var pager: UITextField!
    
    @IBOutlet var phone: UITextField!
    
    @IBOutlet var profilePic: UIImageView!
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("Image selected")
        self.dismissViewControllerAnimated(true, completion:nil)
        
        profilePic.image = image
        
    }
    
    
    @IBAction func chooseImage(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    @IBAction func submit(sender: AnyObject) {
        var error = ""
        
        if (fullName.text == "") {
            
            error = "Please enter a name."
            
        } else if (doctorTitle.text == "") {
            
            error = "Please enter a title."
            
        } else if (specialty.text == "") {
            
            error = "Please enter a specialty."
            
        } else if (hospital.text == "") {
            
            error = "Please enter a hospital."
            
        } else if (pager.text == "") {
            
            error = "Please enter a pager number."
            
        } else if (phone.text == "") {
            
            error = "Please enter a phone number."
            
        }
        if (error != "") {
            
            displayAlert("Cannot Submit Changes", error: error)
            
        } else {
        
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var currentDoctor = PFUser.currentUser()
        
            currentDoctor["fullName"] = fullName.text
            currentDoctor["title"] = doctorTitle.text
            currentDoctor["specialty"] = specialty.text
            currentDoctor["hospital"] = hospital.text
            currentDoctor["pagerNumber"] = pager.text
            currentDoctor["phoneNumber"] = phone.text
            
            let imageData = UIImagePNGRepresentation(self.profilePic.image)
            
            let imageFile = PFFile(name: "image.png", data: imageData)
            
            currentDoctor["imageFile"] = imageFile
            
            currentDoctor.save()
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
            displayAlert("Success!", error: "Changes have been saved.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var currentDoctor = PFUser.currentUser()
        
        fullName.text = currentDoctor["fullName"] as String
        doctorTitle.text = currentDoctor["title"] as String
        specialty.text = currentDoctor["specialty"] as String
        hospital.text = currentDoctor["hospital"] as String
        pager.text = currentDoctor["pagerNumber"] as String
        phone.text = currentDoctor["phoneNumber"] as String
        
        let userImageFile = currentDoctor["imageFile"] as PFFile
        let image = UIImage(data: userImageFile.getData())
        profilePic.image = image
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
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
