//
//  GuestUserViewController.swift
//  Chnen
//
//  Created by navjot_sharma on 11/29/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire


class GuestUserViewController: UIViewController 
{
    
    // MARK:-  Outlets
    @IBOutlet weak var GuestEmail: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:-  Continue As Guest Button
    
    @IBAction func ContinueAsGuest(_ sender: AnyObject)
    {
        if !(GuestEmail.text?.isEmpty)!
        {
            if (GuestEmail.text?.isValidEmail())!
            {
                defaults.setValue(GuestEmail.text, forKey: demail)
                self.performSegue(withIdentifier: SegueGuestToBilling, sender: self)
            }
            else
            {
                globalStrings.showALert(message: NotValidEmail, target: self)
            }
        }
        else
        {
            globalStrings.showALert(message: TextEmpty, target: self)
        }
    }
    
    // MARK:-  Sign In Button
    
    @IBAction func SignInButton(_ sender: AnyObject)
    {
        if !(txtEmail.text?.isEmpty)! || !(txtPassword.text?.isEmpty)!
        {
            if (txtEmail.text?.isValidEmail())!
            {
                defaults.setValue(txtEmail.text, forKey: demail)
                var deviceId = String()
                if (defaults.value(forKey:ddevice_id)) != nil
                {
                 deviceId = defaults.value(forKey:ddevice_id) as! String
                }
                else
                {
                    deviceId = ""
                }
                let  parameters : Parameters = [ksalt: SALT as AnyObject , QUOTE_ID : globalStrings.Quote_id as AnyObject , EMAIL: (txtEmail.text! as String) as AnyObject, PASSWORD: (txtPassword.text! as String) as AnyObject, DEVICE_ID: deviceId as AnyObject, DEVICE_TYPE: Iphone as AnyObject, SOCIAL_ID: "" as AnyObject, LOGIN_TYPE: "" as AnyObject , kcstore: one as AnyObject ]
                let objUser = User()
                objUser.SignInApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.SignInButtonResponse))
                
            }
            else
            {
                globalStrings.showALert(message: NotValidEmail, target: self)
            }
        }
        else
        {
            globalStrings.showALert(message: TextEmpty, target: self)
        }
    }
    
    func SignInButtonResponse(obj: User)
    {
        if obj.resultText == ksuccess
        {
            self.performSegue(withIdentifier: SegueGuestToBilling, sender: self)
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    // MARK:-  Forgot Password button
    
    @IBAction func ForgotPasswordbutton(_ sender: AnyObject)
    {
        
    }
    // MARK:-  Back Button
    
    @IBAction func BackButton(_ sender: AnyObject)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
