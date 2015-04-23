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
    @IBOutlet weak var tipFineCtrl: UISlider!
    @IBOutlet weak var tipPctText: UILabel!
    @IBOutlet weak var totalByTwo: UILabel!
    @IBOutlet weak var totalByThree: UILabel!
    @IBOutlet weak var totalByFour: UILabel!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let currencySymbolArray = ["$", "£", "€"]
    let tipPossiblePct = [0.15, 0.18, 0.20]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor(red: CGFloat(255/255), green: CGFloat(250/255), blue: (250/255), alpha: 1)
        //self.tipAndTotalView.backgroundColor = UIColor.brownColor()
        billField.font = UIFont (name: "HelveticaNeue-UltraLight", size: 48)
        billField.textAlignment = .Right
        
        if defaults.doubleForKey("valueBillField") != 0 {
            billField.text = String(format: "%.2f", defaults.doubleForKey("valueBillField"))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTip")
        tipFineCtrl.value = Float(tipPossiblePct[tipControl.selectedSegmentIndex])
        billField.placeholder = currencySymbolArray[defaults.integerForKey("currencyRow")]
        self.updateTotal()
        billField.becomeFirstResponder()
        self.animateTipAndTotal(0)
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        self.updateTotal()
        self.animateTipAndTotal(0.3)
    }
    
    @IBAction func onEditingFineCtrl(sender: AnyObject) {
        if tipFineCtrl.value < 0.165 {
            tipControl.selectedSegmentIndex = 0
        } else if tipFineCtrl.value < 0.19 {
            tipControl.selectedSegmentIndex = 1
        } else {
            tipControl.selectedSegmentIndex = 2
        }
        
        self.updateTotal()
        self.animateTipAndTotal(0.3)
    }
    
    @IBAction func onEditingTipPct(sender: AnyObject) {
        tipFineCtrl.value = Float(tipPossiblePct[tipControl.selectedSegmentIndex])
        self.updateTotal()
        self.animateTipAndTotal(0.3)

    }
    
    func updateTotal() {

        var tipPct = tipFineCtrl.value
        
        var billAmount = (billField.text as NSString).doubleValue
        println(billAmount)
        var tip = billAmount * Double(tipPct)
        var total = billAmount + tip
        let currencySymbol = currencySymbolArray[defaults.integerForKey("currencyRow")]
        
        var comaFormatter = NSNumberFormatter()
        comaFormatter.numberStyle = .CurrencyStyle

        tipLabel.text = currencySymbol + dropFirst(comaFormatter.stringFromNumber(tip)!)
        totalLabel.text = currencySymbol + dropFirst(comaFormatter.stringFromNumber(total)!)
        tipPctText.text = String(format:"%.2f", tipPct*100) + "%"
        totalByTwo.text = currencySymbol + dropFirst(comaFormatter.stringFromNumber(total/2)!)
        totalByThree.text = currencySymbol + dropFirst(comaFormatter.stringFromNumber(total/3)!)
        totalByFour.text = currencySymbol + dropFirst(comaFormatter.stringFromNumber(total/4)!)
        
    }

    /*static func convertToDouble(textToConvert:String) -> Double {
        return (join("",textToConvert.componentsSeparatedByString(",")) as NSString).doubleValue
    }
    
    static func convertToFormattedString(value:Double) -> String {
        var comaFormatter = NSNumberFormatter()
        comaFormatter.numberStyle = .DecimalStyle
        
        if value == 0 {
            return ""
        } else {
            return dropFirst(comaFormatter.stringFromNumber(value)!)
        }
    } */
    
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
    }
    
    override func viewWillDisappear(animated: Bool) {
                defaults.setDouble( (billField.text as NSString).doubleValue, forKey: "valueBillField")
    }
}

