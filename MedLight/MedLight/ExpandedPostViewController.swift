//
//  ExpandedPostViewController.swift
//  MedLight
//
//  Created by Christopher Gutierrez on 11/16/14.
//  Copyright (c) 2014 TeamOne. All rights reserved.
//

import UIKit

class ExpandedPostViewController: UIViewController {

    @IBOutlet weak var post: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        post.text = celltext
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
