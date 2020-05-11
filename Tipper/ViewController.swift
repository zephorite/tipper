//
//  ViewController.swift
//  Tipper
//
//  Created by Baraa Hegazy on 5/9/20.
//  Copyright © 2020 BaraaHegazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipTextLabel: UILabel!
    @IBOutlet weak var totalTextLabel: UILabel!
    @IBOutlet weak var billFieldConstraint: NSLayoutConstraint!
    @IBOutlet weak var calculationsView: UIView!
    @IBOutlet weak var calculationsViewConstraint: NSLayoutConstraint!
    
    let defaults = UserDefaults.standard
    let currentTime = NSDate()
    let currencySymbol = Locale.current.currencySymbol
    var keyboardHeight = CGFloat(0)
    var darkmode = false
    @objc
    private func handle(keyboardShowNotification notification: Notification) {
        if let userInfo = notification.userInfo,
            let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            keyboardHeight = keyboardRectangle.height
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "currTip%")
        billField.placeholder = currencySymbol
        if (currentTime.timeIntervalSince(defaults.object(forKey: "time") as! Date) > 600 )
        {
            print(currentTime, "is the current time")
            print(defaults.object(forKey: "time") as! Date, "is the saved date")
            print(currentTime.timeIntervalSince(defaults.object(forKey: "time") as! Date), "is the time in seconds between them")
            UserDefaults.resetStandardUserDefaults()
            print("reset the user defaults")
        }
        else
        {
            self.billField.text = defaults.string(forKey: "bill")
            self.tipLabel.text = defaults.string(forKey: "tip")!
            self.totalLabel.text = defaults.string(forKey: "total")!
            self.darkmode = defaults.bool(forKey: "darkmode")
        }
        NotificationCenter.default.addObserver(self,
        selector: #selector(handle(keyboardShowNotification:)),
        name: UIResponder.keyboardDidShowNotification,
        object: nil)
        billField.becomeFirstResponder()
        self.billFieldConstraint.constant = -50//(-self.view.frame.size.height + self.keyboardHeight)/4
        checktheme()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (currentTime.timeIntervalSince(defaults.object(forKey: "time") as! Date) > 600 )
        {
            print(currentTime, "is the current time")
            print(defaults.object(forKey: "time") as! Date, "is the saved date")
            print(currentTime.timeIntervalSince(defaults.object(forKey: "time") as! Date), "is the time in seconds between them")
            UserDefaults.resetStandardUserDefaults()
            print("reset the user defaults")
        }
        else
        {
            self.billField.text = defaults.string(forKey: "bill")
            self.tipLabel.text = defaults.string(forKey: "tip")!
            self.totalLabel.text = defaults.string(forKey: "total")!
        }
        checktheme()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "currTip%")
        calculateTip(self)
        darkmode = defaults.bool(forKey: "darkmode")
        print(darkmode)
        checktheme()
    }
    
    var animatedOnce = false
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billField.text!) ?? 0
        if (animatedOnce && (bill == 0 || billField.text == nil))
        {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                self.billFieldConstraint.constant = -50 //(-self.view.frame.size.height + self.keyboardHeight)/4 - 54
                print(self.billFieldConstraint.constant, "constraint at change")
                self.view.layoutIfNeeded()
            }, completion: nil)
            animatedOnce = false
        }
        if (!animatedOnce && !(bill == 0 || billField.text == nil))
        {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                self.billFieldConstraint.constant = -self.view.frame.size.height/2 + 110
                self.view.layoutIfNeeded()
            }, completion: nil)
            animatedOnce = true
        }
        if (bill == 0 || billField.text == nil)
        {
            tipControl.isHidden = true
            
            self.calculationsViewConstraint.constant = 50
            calculationsView.isHidden = true
        }
        else
        {
            tipControl.isHidden = false
            calculationsView.isHidden = false
            
        }
        let tipPercentages = [0.15,0.18,0.20]
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = currencySymbol! + String(format: "%.2f",tip)
        totalLabel.text = currencySymbol! + String(format: "%.2f",total)
        saveCurrValues()
    }
    override func viewDidDisappear(_ animated: Bool) {
        saveCurrValues()
        defaults.set(currentTime, forKey: "time")
        print("view disappeared")
        super.viewDidAppear(animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveCurrValues()
    }
    func saveCurrValues()
    {
        defaults.set(tipLabel.text, forKey: "tip")
        defaults.set(totalLabel.text, forKey: "total")
        defaults.set(tipControl.selectedSegmentIndex, forKey: "currTip%")
        defaults.set(billField.text, forKey: "bill")
        defaults.synchronize()
    }
    func checktheme()
    {
        darkmode = defaults.bool(forKey: "darkmode")
        if (darkmode)
        {
            let textColor = UIColor(red: 129/255, green: 134/255, blue: 138/255, alpha: 1.0)
            self.view.backgroundColor = UIColor.black
            billField.textColor = UIColor(red: 141/255, green: 25/255, blue: 42/255, alpha: 1.0)
            tipControl.backgroundColor = UIColor(red: 37/255, green: 36/255, blue: 41/255, alpha: 1.0)
            tipControl.selectedSegmentTintColor = UIColor(red: 141/255, green: 25/255, blue: 42/255, alpha: 1.0)
            tipTextLabel.textColor = textColor
            tipLabel.textColor = textColor
            totalLabel.textColor = textColor
            totalTextLabel.textColor = textColor
            calculationsView.backgroundColor = UIColor(red: 37/255, green: 36/255, blue: 41/255, alpha: 1.0)
        }
        else
        {
            let textColor = UIColor(red: 37/255, green: 50/255, blue: 55/255, alpha: 1.0)
            self.view.backgroundColor = UIColor(red: 224/255, green: 251/255, blue: 252/255, alpha: 1.0)
            billField.textColor = UIColor(red: 92/255, green: 107/255, blue: 115/255, alpha: 1.0)
            tipControl.backgroundColor = UIColor(red: 157/255, green: 180/255, blue: 192/255, alpha: 1.0)
            tipControl.selectedSegmentTintColor = UIColor(red: 92/255, green: 107/255, blue: 115/255, alpha: 1.0)
            tipTextLabel.textColor = textColor
            tipLabel.textColor = textColor
            totalLabel.textColor = textColor
            totalTextLabel.textColor = textColor
            calculationsView.backgroundColor = UIColor(red: 157/255, green: 180/255, blue: 192/255, alpha: 1.0)
        }
    }
    
}

