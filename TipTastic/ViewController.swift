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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onApplicationDidBecomeActive), name: .UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onApplicationWillResignActive), name: .UIApplicationWillResignActive, object: nil)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let intValue = defaults.integer(forKey: "defaultTipIndex")
        
        tipControl.selectedSegmentIndex = intValue
        updateTipAndTotalAmounts()
        
        billField.becomeFirstResponder()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIApplicationWillResignActive, object: nil)
    }

    
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        updateTipAndTotalAmounts()
        
    }
    
    func saveState(bill: String, tipPercentageIndex: Int) {
        defaults.setValue(Date.init(), forKeyPath: "dateSaved")
        defaults.setValue(bill, forKeyPath: "bill")
        defaults.setValue(tipPercentageIndex, forKeyPath: "tipPercentageIndex")
        defaults.synchronize();
    }
    
    func loadState() {
         let bill = defaults.string(forKey: "bill")
         let tipPercentage = defaults.integer(forKey: "tipPercentageIndex")
        
        billField.text = bill
        tipControl.selectedSegmentIndex = tipPercentage

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
        
        return minBetween.minute! > 10
    }
    
    func resetAmount() {
        billField.text = ""
        updateTipAndTotalAmounts()
    }
    
    func onApplicationDidBecomeActive(){
        
        let savedDate = defaults.object(forKey: "saveDate") as? Date ?? Date.init()
        
        if isResetAmount(lastSavedDate: savedDate) {
            resetAmount()
        } else {
            loadState()
            updateTipAndTotalAmounts()
        }
        
    }
    
    func onApplicationWillResignActive() {
        
        saveState(bill: billField.text!, tipPercentageIndex: tipControl.selectedSegmentIndex)
        
    }
    
   
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

}

