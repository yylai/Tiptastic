//
//  SettingsViewController.swift
//  TipTastic
//
//  Created by YINYEE LAI on 9/18/16.
//  Copyright © 2016 Yin Yee Lai. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    var defaults = UserDefaults.standard;
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let intValue = defaults.integer(forKey: "defaultTipIndex");
        defaultTipControl.selectedSegmentIndex = intValue;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDefaultTipChange(_ sender: AnyObject) {
        
        let defaults = UserDefaults.standard;
        
        defaults.setValue(defaultTipControl.selectedSegmentIndex, forKeyPath: "defaultTipIndex");
        defaults.synchronize();
    }

}
