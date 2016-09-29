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
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipPlusLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billTipView: UIView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var NavItem: UIBarButtonItem!
    
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
        
        let isDarkTheme = defaults.bool(forKey: "darkThemeOn")
        setTheme(isDark: isDarkTheme)
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
    
    func setTheme(isDark: Bool) {
        
        if (isDark) {
            let BGColor = UIColor.darkGray
            let TotalBG = UIColor(red:0.25, green:0.25, blue:0.25, alpha:1.0)
            let TealTint = UIColor(red:0.13, green:0.86, blue:1.00, alpha:1.0)
            let TextColor = UIColor.white
            
            self.view.backgroundColor = BGColor
            
            billField.tintColor = TealTint
            
            billTipView.backgroundColor = BGColor
            billField.textColor = TextColor
            tipLabel.textColor = TextColor
            tipPlusLabel.textColor = TextColor
            tipControl.tintColor = TealTint
            
            totalView.backgroundColor = TotalBG
            totalLabel.textColor = TextColor
            totalTitleLabel.textColor = TextColor
            
            
        } else {
            
            let OrangeTint = UIColor(red:1.00, green:0.60, blue:0.00, alpha:1.0)
            
            let BGColor = UIColor.white
            let TotalBG = UIColor(red:1.00, green:0.85, blue:0.65, alpha:1.0)
            let TextColor = UIColor.black
            
            self.view.backgroundColor = BGColor
            
            billField.tintColor = UIColor.black
            
            billTipView.backgroundColor = BGColor
            billField.textColor = TextColor
            tipLabel.textColor = TextColor
            tipPlusLabel.textColor = TextColor
            tipControl.tintColor = OrangeTint
            
            totalView.backgroundColor = TotalBG
            totalLabel.textColor = TextColor
            totalTitleLabel.textColor = TextColor        }
        
    }

}

