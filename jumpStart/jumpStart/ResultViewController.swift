//
//  ViewController.swift
//  jumpStart
//
//  Created by Atsushi Hayashida on 2016/07/16.
//  Copyright © 2016年 Atsushi Hayashida. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var minedLabel: UILabel!
    
    var pickOption = ["UNICEF", "Red Cross", "Local Non-Profit organization"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerView.tintColor = UIColor.whiteColor()
        minedLabel.text = "$" + String(Double(mindCount) * 0.000650)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int{
        return pickOption.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String!{
        return pickOption[row]
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickOption[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        return myTitle
    }

    @IBAction func pushDonate(sender: AnyObject) {
        let alert: UIAlertController = UIAlertController(title: "Donated", message: "Thank you!", preferredStyle:  UIAlertControllerStyle.Alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
            mindCount = 0
            self.performSegueWithIdentifier("unwindSeg", sender: self)
        })
        
        alert.addAction(defaultAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
}
