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
        
        toDoItems.append(toDoItem.text)
        
        let fixedtoDoItems = toDoItems
        NSUserDefaults.standardUserDefaults().setObject(fixedtoDoItems, forKey: "toDoItems")
        NSUserDefaults.standardUserDefaults().synchronize()
        
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
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        
        self.view.endEditing(true)
        
    }

    
    
}