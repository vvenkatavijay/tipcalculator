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
    let defaults = NSUserDefaults.standardUserDefaults()
    let currencySymbolArray = ["$", "£", "€"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTip")
        self.updateTotal()
        billField.becomeFirstResponder()
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        self.updateTotal()
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

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        let defaults = NSUserDefaults.standardUserDefaults()
    }
}

