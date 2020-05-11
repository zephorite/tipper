//
//  SettingsViewController.swift
//  Tipper
//
//  Created by Baraa Hegazy on 5/9/20.
//  Copyright © 2020 BaraaHegazy. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var darkModeLabel: UILabel!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.set(defaultTipControl.selectedSegmentIndex, forKey: "currTip%")
        darkModeSwitch.setOn(defaults.bool(forKey: "darkmode"), animated: true)
        checktheme()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func defTipChanged(_ sender: Any) {
        defaults.set(defaultTipControl.selectedSegmentIndex, forKey: "currTip%")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        defaults.set(darkModeSwitch.isOn, forKey: "darkmode")
        defaults.synchronize()
        print(darkModeSwitch.isOn)
    }
    @IBAction func darkModeChanged(_ sender: Any) {
        defaults.set(darkModeSwitch.isOn, forKey: "darkmode")
        //print(defaults.bool(forKey: "darkmode"))
        darkModeSwitch.setOn(defaults.bool(forKey: "darkmode"), animated: true)
        checktheme()
    }
    func checktheme()
    {
        let darkmode = defaults.bool(forKey: "darkmode")
        if (darkmode)
        {
            let textColor = UIColor(red: 129/255, green: 134/255, blue: 138/255, alpha: 1.0)
            self.view.backgroundColor = UIColor.black
            defaultTipControl.backgroundColor = UIColor(red: 37/255, green: 36/255, blue: 41/255, alpha: 1.0)
            defaultTipControl.selectedSegmentTintColor = UIColor(red: 141/255, green: 25/255, blue: 42/255, alpha: 1.0)
            darkModeSwitch.onTintColor = UIColor(red: 141/255, green: 25/255, blue: 42/255, alpha: 1.0)
            darkModeSwitch.thumbTintColor = UIColor(red: 37/255, green: 36/255, blue: 41/255, alpha: 1.0)
            darkModeLabel.textColor = textColor
            tipAmountLabel.textColor = textColor
        }
        else
        {
            let textColor = UIColor(red: 37/255, green: 50/255, blue: 55/255, alpha: 1.0)
            self.view.backgroundColor = UIColor(red: 224/255, green: 251/255, blue: 252/255, alpha: 1.0)
            defaultTipControl.backgroundColor = UIColor(red: 157/255, green: 180/255, blue: 192/255, alpha: 1.0)
            defaultTipControl.selectedSegmentTintColor = UIColor(red: 92/255, green: 107/255, blue: 115/255, alpha: 1.0)
            darkModeSwitch.thumbTintColor = UIColor(red: 157/255, green: 180/255, blue: 192/255, alpha: 1.0)
            darkModeSwitch.tintColor = UIColor(red: 92/255, green: 107/255, blue: 115/255, alpha: 1.0)
            darkModeLabel.textColor = textColor
            tipAmountLabel.textColor = textColor
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
