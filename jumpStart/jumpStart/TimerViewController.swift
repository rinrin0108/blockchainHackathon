//
//  ViewController.swift
//  jumpStart
//
//  Created by Atsushi Hayashida on 2016/07/16.
//  Copyright © 2016年 Atsushi Hayashida. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    let string = "Hello world!"
    let difficulty = 3
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var alermLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var alermSwitch: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        alermSwitch.selectedSegmentIndex = 1
        
        // firsttime
        updateDateLabel()
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(TimerViewController.updateDateLabel), userInfo: nil, repeats: true)
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        alermLabel.text = formatter.stringFromDate(datePicker.date)
        
        miningLoop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func miningLoop() {
        NSOperationQueue().addOperationWithBlock({ () -> Void in
            while(true){
                print("mining!")
            }
        })
    }

    @IBAction func updateAlerm(sender: AnyObject) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        
        alermLabel.text = formatter.stringFromDate(sender.date)
    }
    
    // formatting
    var dateFormatter: NSDateFormatter{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    // update label
    func updateDateLabel(){
        let now = NSDate()
        timerLabel.text = dateFormatter.stringFromDate(now)
        
        if(alermSwitch.selectedSegmentIndex == 0) {
            if(timerLabel.text == alermLabel.text){
                
                let alert: UIAlertController = UIAlertController(title: "Alert", message: "Wake up!", preferredStyle:  UIAlertControllerStyle.Alert)
                
                let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{
                    (action: UIAlertAction!) -> Void in
                    print("OK")
                    self.alermSwitch.selectedSegmentIndex = 1
                })
                
                let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:{
                    (action: UIAlertAction!) -> Void in
                    print("Cancel")
                    
                })
                
                alert.addAction(cancelAction)
                alert.addAction(defaultAction)
                presentViewController(alert, animated: true, completion: nil)
            }
        }
    }


}

