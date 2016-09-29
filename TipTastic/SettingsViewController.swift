//
//  SettingsViewController.swift
//  TipTastic
//
//  Created by YINYEE LAI on 9/18/16.
//  Copyright © 2016 Yin Yee Lai. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var darkThemeSwitch: UISwitch!
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var darkThemeView: UIView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var navBar: UINavigationItem!
    
    var defaults = UserDefaults.standard;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let intValue = defaults.integer(forKey: "defaultTipIndex");
        defaultTipControl.selectedSegmentIndex = intValue;
        
        let darkOn = defaults.bool(forKey: "darkThemeOn")
        darkThemeSwitch.isOn = darkOn
        
        setSettingsTheme(isDark: darkOn)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDarkThemeChange(_ sender: AnyObject) {
        defaults.setValue(darkThemeSwitch.isOn, forKeyPath: "darkThemeOn")
        defaults.synchronize()
        
        setSettingsTheme(isDark: darkThemeSwitch.isOn)
    }
        
    @IBAction func onDefaultTipChange(_ sender: AnyObject) {
       
        defaults.setValue(defaultTipControl.selectedSegmentIndex, forKeyPath: "defaultTipIndex")
        defaults.synchronize()
    }
    
    func setSettingsTheme(isDark: Bool) {
        
        if (isDark) {
            let DarkGrayBGColor = UIColor(red:0.65, green:0.65, blue:0.65, alpha:1.0)
            
            self.view.backgroundColor = DarkGrayBGColor
            
            tipView.backgroundColor = UIColor.darkGray
            tipLabel.textColor = UIColor.white
            
            darkThemeView.backgroundColor = UIColor.darkGray
            themeLabel.textColor = UIColor.white
            
            let TealTint = UIColor(red:0.13, green:0.86, blue:1.00, alpha:1.0)
            defaultTipControl.tintColor = TealTint
            
        } else {
            
            let LightGrayBGColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
            let OrangeTint = UIColor(red:1.00, green:0.60, blue:0.00, alpha:1.0)
            
            self.view.backgroundColor = LightGrayBGColor
            
            tipView.backgroundColor = UIColor.white
            tipLabel.textColor = UIColor.black
            
            darkThemeView.backgroundColor = UIColor.white
            themeLabel.textColor = UIColor.black
            
            defaultTipControl.tintColor = OrangeTint
            
        }
        
    }

}
