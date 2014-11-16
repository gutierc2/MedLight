//
//  PatientNotepadViewController.swift
//  MedLight
//
//  Created by Bryce Tham on 11/15/14.
//  Copyright (c) 2014 TeamOne. All rights reserved.
//

import UIKit

class PatientNotepadViewController: UIViewController {

    @IBOutlet var notes: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (NSUserDefaults.standardUserDefaults().objectForKey("patientNotes") != nil) {
            // Do any additional setup after loading the view.
            notes.text = NSUserDefaults.standardUserDefaults().objectForKey("patientNotes")! as String
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        
        NSUserDefaults.standardUserDefaults().setObject(notes.text, forKey: "patientNotes")
        NSUserDefaults.standardUserDefaults().synchronize()
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
