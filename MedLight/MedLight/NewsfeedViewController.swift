//
//  NewsfeedViewController.swift
//  MedLight
//
//  Created by Bryce Tham on 11/10/14.
//  Copyright (c) 2014 TeamOne. All rights reserved.
//

import UIKit


var toDoItems:[String] = []



class NewsfeedViewController: UIViewController, UITableViewDelegate {
    
    
    
    
    @IBOutlet var tasksTable:UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        return toDoItems.count
        
    }
    
    
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel.text = toDoItems[indexPath.row]
        
        return cell
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if var storedtoDoItems : AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("toDoItems") {
            
            toDoItems = []
            
            for var i = storedtoDoItems.count as Int; i > 0; --i {
                
                toDoItems.append(storedtoDoItems[i-1] as NSString)
                
            }
            
            
        }
        
        
        tasksTable.reloadData()
        
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            toDoItems.removeAtIndex(indexPath.row)
            
            let fixedtoDoItems = toDoItems
            NSUserDefaults.standardUserDefaults().setObject(fixedtoDoItems, forKey: "toDoItems")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            tasksTable.reloadData()
            
        }
        
        
    }
    
    

    
}

