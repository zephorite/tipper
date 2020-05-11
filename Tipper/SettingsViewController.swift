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
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.set(defaultTipControl.selectedSegmentIndex, forKey: "currTip%")
        darkModeSwitch.isOn = defaults.bool(forKey: "darkmode")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func defTipChanged(_ sender: Any) {
        defaults.set(defaultTipControl.selectedSegmentIndex, forKey: "currTip%")
    }
    
    @IBAction func darkModeChanged(_ sender: Any) {
        defaults.set(darkModeSwitch.isOn, forKey: "darkmode")
        defaults.synchronize()
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
