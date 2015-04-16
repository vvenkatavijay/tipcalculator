//
//  ViewController.swift
//  tips
//
//  Created by Venkata Vijay on 4/14/15.
//  Copyright (c) 2015 Venkata Vijay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipPlusLabel: UILabel!
    @IBOutlet weak var totalEqualLabel: UILabel!
    @IBOutlet weak var tipAndTotalView: UIView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let currencySymbolArray = ["$", "£", "€"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.brownColor()
       // self.tipAndTotalView.backgroundColor = UIColor.brownColor()
        billField.font = UIFont (name: "HelveticaNeue-UltraLight", size: 48)
        billField.textAlignment = .Right
        
        if defaults.doubleForKey("valueBillField") != 0 {
            billField.text = String(format:"%.2f", defaults.doubleForKey("valueBillField"))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTip")
        println(defaults.doubleForKey("valueBillField"))
        billField.placeholder = currencySymbolArray[defaults.integerForKey("currencyRow")]
        self.updateTotal()
        billField.becomeFirstResponder()
        self.animateTipAndTotal(0)
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        self.updateTotal()
        self.animateTipAndTotal(0.3)
    }
    
    func updateTotal() {
        var tipPossiblePct = [0.15, 0.18, 0.20]
        var tipPct = tipPossiblePct[tipControl.selectedSegmentIndex]
        
        var billAmount = (billField.text as NSString).doubleValue
        var tip = billAmount*tipPct
        var total = billAmount + tip
        let currencySymbol = currencySymbolArray[defaults.integerForKey("currencyRow")]
        
        tipLabel.text = currencySymbol + String(format: "%.2f", tip)
        totalLabel.text = currencySymbol + String(format: "%.2f", total)
    }
    
    func animateTipAndTotal(transformTime: Double) {
        if billField.text.isEmpty {
            if tipAndTotalView.alpha == 1 {
                UIView.animateWithDuration(transformTime, animations: {
                    self.tipAndTotalView.alpha = 0
                    
                    let myTransform:CGAffineTransform  = CGAffineTransformMake(1.0, 0.0, 0.0, 1.0, 0.0, 200.0)
                    self.billField.transform = myTransform
                })
            }
        } else {
            if tipAndTotalView.alpha == 0 {
                UIView.animateWithDuration(transformTime, animations: {
                    self.tipAndTotalView.alpha = 1
                    
                    let myTransform:CGAffineTransform  = CGAffineTransformMake(1.0, 0.0, 0.0, 1.0, 0.0, 0.0)
                    self.billField.transform = myTransform

                })
            }
            
        }
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        let defaults = NSUserDefaults.standardUserDefaults()
    }
    
    override func viewWillDisappear(animated: Bool) {
                defaults.setDouble((self.billField.text as NSString).doubleValue, forKey: "valueBillField")
    }
}

