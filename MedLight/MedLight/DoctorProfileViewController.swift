//
//  DoctorProfileViewController.swift
//  MedLight
//
//  Created by Kay Lab on 11/15/14.
//  Copyright (c) 2014 TeamOne. All rights reserved.
//

import UIKit

class DoctorProfileViewController: UIViewController {

    @IBOutlet var fullName: UILabel!
    
    @IBOutlet var specialty: UILabel!
    
    @IBOutlet var hospital: UILabel!
    
    @IBOutlet var phone: UILabel!
    
    @IBOutlet var pager: UILabel!

    @IBOutlet var email: UILabel!
    
    
    @IBOutlet var profilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var currentDoctor = PFUser.currentUser()
        
        fullName.text = currentDoctor["fullName"] as String
        specialty.text = currentDoctor["specialty"] as String
        hospital.text = currentDoctor["hospital"] as String
        phone.text = currentDoctor["phone"] as String
        pager.text = currentDoctor["pager"] as String
        email.text = currentDoctor["email"] as String
        
        let userImageFile = currentDoctor["imageFile"] as PFFile
        let image = UIImage(data: userImageFile.getData())
        
        profilePic.image = image
        
        // Do any additional setup after loading the view.
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
