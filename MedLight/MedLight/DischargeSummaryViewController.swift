//
//  DischargeSummaryViewController.swift
//  MedLight
//
//  Created by Bryce Tham on 11/16/14.
//  Copyright (c) 2014 TeamOne. All rights reserved.
//

import UIKit

class DischargeSummaryViewController: UIViewController {

    @IBOutlet weak var form: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var name = currentPatient!["fullName"] as String
        var mrn = currentPatient!["mrn"] as String
        var hospital = currentPatient!["hospital"] as String
        var user = PFUser.currentUser()
        var drName = user["fullName"] as String
        var title = user["title"] as String
        var postName = "\(title) \(drName)"
        var newsfeed = reverse(currentPatient!["newsfeed"] as [[String]])
        var formfeed : [[String]] = []
        
        for i in 0..<newsfeed.count
        {
            if (newsfeed[i][2] == postName)
            {
                formfeed.append(newsfeed[i])
            }
        }
        
        var todaysDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .ShortStyle
        var time = formatter.stringFromDate(todaysDate)
        formfeed.append(["Discharged","","",time])
        
        var summary = "Name: \(name)\nMRN: \(mrn)\nHospital: \(hospital)\n\n"
        var date = ""
        for post in formfeed {

            if date == getDate(post[3])
            {
                summary += "    \(post[0])\n"
            }
            else
            {
                date = getDate(post[3])
                summary += "\(date)\n    \(post[0])\n"
            }
        }
        form.text = summary
    }
        
    func getDate(date: String) -> String {
        var result: String = ""
        for c in date {
            if c == "," {
                return result
            }
            result = result+[c]
        }
        return result
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
