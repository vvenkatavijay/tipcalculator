//
//  SettingsViewController.swift
//  tips
//
//  Created by Venkata Vijay on 4/14/15.
//  Copyright (c) 2015 Venkata Vijay. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var defaultTipLabel: UISegmentedControl!
    @IBOutlet weak var currencyPicker: UIPickerView!
    let currencyArray = ["US Dollars $", "Pound £", "Euro €"]
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        defaultTipLabel.selectedSegmentIndex = defaults.integerForKey("defaultTip")
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        currencyPicker.selectRow(defaults.integerForKey("currencyRow"), inComponent: 0, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingDefaultTip(sender: AnyObject) {
        var tipArray = [0.15, 0.18, 0.20]
        var defaultTip = tipArray[defaultTipLabel.selectedSegmentIndex]
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipLabel.selectedSegmentIndex, forKey: "defaultTip")
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return currencyArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        defaults.setInteger(row, forKey: "currencyRow")

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
