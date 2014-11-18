//
//  PatientListTableViewController.swift
//  MedLight
//
//  Created by Kay Lab on 11/13/14.
//  Copyright (c) 2014 TeamOne. All rights reserved.
//

import UIKit

var currentPatient : PFObject? = nil

class PatientListTableViewController: UITableViewController, UITableViewDelegate {

    @IBOutlet var patientTable: UITableView!
    
    var patients: [String] = []

    var user = PFUser.currentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        
        var query = PFQuery(className: "Patient")
        query.whereKey("hospital", equalTo: user["hospital"] as String)
        query.whereKey("mrn", equalTo: patients[indexPath.row])
        var p = query.findObjects()[0] as PFObject
        
        cell.textLabel.text = p["fullName"] as? String
        cell.detailTextLabel!.text = (p["notes"] as String) + " (MRN:" + (p["mrn"] as String) + ")"
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        var storedPatientList : [String] = user["patients"] as [String]
        patients = []
        for i in storedPatientList
        {
            patients.append(i)
        }
        patients = patients.sorted { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedDescending }
        
        patientTable.reloadData()
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        return "D/C"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return patients.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var query = PFQuery(className: "Patient")
        query.whereKey("hospital", equalTo: user["hospital"] as String)
        query.whereKey("mrn", equalTo: patients[indexPath.row])
        currentPatient = query.findObjects()[0] as? PFObject

        self.performSegueWithIdentifier("viewPatientFeed", sender: nil)
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            
            var query = PFQuery(className: "Patient")
            query.whereKey("hospital", equalTo: user["hospital"] as String)
            query.whereKey("mrn", equalTo: patients[indexPath.row])
            currentPatient = query.findObjects()[0] as? PFObject
            currentPatient!.removeObject(user["email"] as String, forKey: "doctors")
            currentPatient!.save()
            
            patients.removeAtIndex(indexPath.row)
            
            user!["patients"] = patients
            user!.save()
            
            patientTable.reloadData()

            //SEGUE TO VIEW WITH TEXTVIEW FOR DISCHARGE
            self.performSegueWithIdentifier("discharge", sender: nil)
        }
    }


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
