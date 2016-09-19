//
//  ViewController.swift
//  TipTastic
//
//  Created by YINYEE LAI on 9/17/16.
//  Copyright © 2016 Yin Yee Lai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var defaults = UserDefaults.standard
    var tipPercentages = [0.18, 0.20, 0.25]
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let intValue = defaults.integer(forKey: "defaultTipIndex")
        print("tipindex on willappear: \(intValue)")
        
        tipControl.selectedSegmentIndex = intValue
        updateTipAndTotalAmounts()
        
        billField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        updateTipAndTotalAmounts()
        
    }
    
    func saveAmounts(bill: Double, tipPercentageIndex: Int) {
        defaults.setValue(Date.init(), forKeyPath: "dateSaved")
        defaults.setValue(bill, forKeyPath: "bill")
        defaults.setValue(tipPercentageIndex, forKeyPath: "tipPercentageIndex")
        defaults.synchronize();
    }
    
    func loadAmounts() {
         let bill = defaults.double(forKey: "bill")
         let tipPercentage = defaults.integer(forKey: "tipPercentageIndex")
        
        billField.text = String(bill)
        tipControl.selectedSegmentIndex = tipPercentage

        updateTipAndTotalAmounts()

    }
    
    func formatAmount(amt: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.usesGroupingSeparator = true
        
        
        return numberFormatter.string(from: NSNumber.init(value: amt))!
    }
    
    func updateTipAndTotalAmounts() {
        
        
        let bill = Double(billField.text!) ?? 0
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = formatAmount(amt: tip)
        totalLabel.text = formatAmount(amt: total)
    }
    
    func isResetAmount(lastSavedDate: Date) -> Bool {
        let dateNow = Date.init()
        let calendar = Calendar.current
        
        
        let minBetween = calendar.dateComponents([.minute], from: lastSavedDate, to: dateNow)
        print("min since: \(minBetween)")
        
        return minBetween.minute! > 10
    }
    

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

}

