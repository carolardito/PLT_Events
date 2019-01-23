//
//  ViewController.swift
//  TLPEvents
//
//  Created by user143339 on 8/20/18.
//  Copyright © 2018 user143339. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: Text Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //txtRestName.resignFirstResponder()
        textField.resignFirstResponder() // resign the text that called the function (parameter)
        return true
    }

    @IBAction func submitLogIn(_ sender: Any) {
        let userEmail = emailAddress.text
        let userPassword = password.text
        
        let userEmailStored = UserDefaults.standard.value(forKey: "userEmail") as? String
        let userPasswordStored = UserDefaults.standard.value(forKey: "userPassword") as? String
        
        if (userEmail == "admin" && userPassword == "admin") || (userEmail == userEmailStored && userPassword == userPasswordStored){
            
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            UserDefaults.standard.set(false, forKey: "guest")
            UserDefaults.standard.synchronize()
            
            self.dismiss(animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Alert", message: "Email and/or password not match! Please enter again.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return;
        }
    }
    
    @IBAction func btnGuest(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "guest")
        UserDefaults.standard.synchronize()
    }
    
}

