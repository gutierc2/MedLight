//
//  NewsfeedViewController.swift
//  MedLight
//
//  Created by Bryce Tham on 11/10/14.
//  Copyright (c) 2014 TeamOne. All rights reserved.
//

import UIKit


var toDoFeed:[[String]] = []



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
        
        return toDoFeed.count
        
    }
    
    
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel.text = toDoFeed[indexPath.row][1]+" "+toDoFeed[indexPath.row][0]
        
        println(toDoFeed)
        
        return cell
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        /*
        if var storedtoDoFeed : AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("toDoFeed") {
            
            toDoFeed = []
            
            for var i = storedtoDoFeed.count as Int; i > 0; --i {
                
                toDoFeed.append([storedtoDoFeed[i-1][0] as NSString, storedtoDoFeed[i-1][1] as NSString])
                
            }
            
            
        }
        */
        toDoFeed = reverse(currentPatient!["newsfeed"] as [[String]])
        
        tasksTable.reloadData()
        
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {

        if toDoFeed[indexPath.row][1] == "✴️" {
            toDoFeed[indexPath.row][1] = "✅"
        } else if toDoFeed[indexPath.row][1] == "✅" {
            toDoFeed[indexPath.row][1] = "🅾"
        } else {
            toDoFeed[indexPath.row][1] = "✴️"
        }

        
        //let fixedtoDoFeed = toDoFeed
        //NSUserDefaults.standardUserDefaults().setObject(fixedtoDoFeed, forKey: "toDoFeed")
        //NSUserDefaults.standardUserDefaults().synchronize()
        currentPatient!["newsfeed"] = reverse(toDoFeed)
        currentPatient!.save()
        tasksTable.reloadData()

    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            toDoFeed.removeAtIndex(indexPath.row)
            
            //let fixedtoDoFeed = toDoFeed
            //NSUserDefaults.standardUserDefaults().setObject(fixedtoDoFeed, forKey: "toDoFeed")
            //NSUserDefaults.standardUserDefaults().synchronize()
            currentPatient!["newsfeed"] = reverse(toDoFeed)
            currentPatient!.save()
            tasksTable.reloadData()
            
        }
        
        
    }
    
    

    
}

