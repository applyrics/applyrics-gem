//
//  ViewController.swift
//  iOS Example
//
//  Created by Frederik Wallner on 29/03/16.
//  Copyright © 2016 Frederik Wallner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(sender: UIButton) {
        
        let messages = [
            NSLocalizedString("message", comment: "Swift source says hi!"),
            OldObjectiveC.talkOldSchool()
        ]
        
        let random = Int(arc4random_uniform(UInt32(messages.count)))
        
        let message = messages[random]
        
        let alertController = UIAlertController(
            title: NSLocalizedString("title", comment: "Hello"),
            message: message,
            preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: "Cancel"), style: .Cancel) { (action) in
            // Do nothing...
        }
        
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true) {
            // Do nothing...
        }
        
    }

}

