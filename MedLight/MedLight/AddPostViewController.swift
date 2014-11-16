//
//  AddPostViewController.swift
//  MedLight
//
//  Created by Bryce Tham on 11/10/14.
//  Copyright (c) 2014 TeamOne. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController, UITextFieldDelegate {
        
    @IBOutlet var toDoItem : UITextField!
    
    
    @IBAction func addItem(sender : AnyObject) {
        var user = PFUser.currentUser()
        var title = user["title"] as String
        var name = user["fullName"] as String
        var date = NSDate()
        
        let formatter = NSDateFormatter()
        
        formatter.dateStyle = .ShortStyle
        
        formatter.timeStyle = .ShortStyle
        
        var time = formatter.stringFromDate(date)
        
        currentPatient!.addObject([toDoItem.text, "✴️", (title+" "+name), time], forKey: "newsfeed")
        //toDoFeed.append([toDoItem.text, "✴️"])
        /*
        let fixedtoDoFeed = toDoFeed
        NSUserDefaults.standardUserDefaults().setObject(fixedtoDoFeed, forKey: "toDoFeed")
        NSUserDefaults.standardUserDefaults().synchronize()
        */
        
        currentPatient!.save()
        
        self.view.endEditing(true)
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }

    
    
}