//
//  ViewController.swift
//  jumpStart
//
//  Created by Atsushi Hayashida on 2016/07/16.
//  Copyright © 2016年 Atsushi Hayashida. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    let string = "Hello, world!"
    let difficulty = 4
    
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
    }
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var alermLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var alermSwitch: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.sharedApplication().idleTimerDisabled = true
        
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
            var problem = ""
            var answer = ""
            while(true){
                problem = self.string + self.randomStringWithLength(40)
                answer = self.sha256(problem) as String
                //print(answer)
                if answer.hasPrefix("0000") {
                    print("string:" + problem + " ,sha256:" + answer)
                    mindCount += 1
                }
            }
        })
    }
    
    func randomStringWithLength(length: Int) -> String {
        let alphabet = "-_1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let upperBound = UInt32(alphabet.characters.count)
        return String((0..<length).map { _ -> Character in
            return alphabet[alphabet.startIndex.advancedBy(Int(arc4random_uniform(upperBound)))]
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
                    
                    self.nextScreen()
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
    
    func nextScreen() {
        print("next")
        self.performSegueWithIdentifier("resultSeg", sender: nil)
    }
    
    func sha256(string: NSString) -> NSString {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding)!
        var hash = [UInt8](count: Int(CC_SHA256_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA256(data.bytes, CC_LONG(data.length), &hash)
        let resstr = NSMutableString()
        for byte in hash {
            resstr.appendFormat("%02hhx", byte)
        }
        return resstr
    }

}
