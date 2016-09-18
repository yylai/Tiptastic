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
    
    
    var tipPercentages = [0.18, 0.20, 0.25];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        let defaults = UserDefaults.standard;
        let intValue = defaults.integer(forKey: "defaultTipIndex");
        
        tipControl.selectedSegmentIndex = intValue;
        updateTipAndTotalAmounts();
        billField.becomeFirstResponder();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        updateTipAndTotalAmounts();
        
    }
    
    func updateTipAndTotalAmounts() {
        
        
        let bill = Double(billField.text!) ?? 0;
        let tip = bill *
            tipPercentages[tipControl.selectedSegmentIndex];
        let total = bill + tip;
        
        tipLabel.text = String(format: "$%.2f", tip);
        totalLabel.text = String(format: "$%.2f", total);
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true);
    }

}

