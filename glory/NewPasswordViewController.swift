//
//  NewPasswordViewController.swift
//  Chnen
//
//  Created by navjot_sharma on 12/16/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire


class NewPasswordViewController: UIViewController  {
    
    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SavePassword(_ sender: AnyObject)
    {
        activityIndicator.startAnimating(activityData)
        let parameters = [ksalt: SALT , CUST_ID : globalStrings.Cust_id ,PASSWORD: txtNewPassword.text!, CURRENT_PASS: txtCurrentPassword.text!, kcstore: one]
        let objUser = User()
        objUser.UpdateUserInfo(dict: parameters , target: self, selector: #selector(self.UpdatePasswordResponse))
    }
    
    // MARK:-  Api methods response
    
    func UpdatePasswordResponse(obj:User)
    {
        if obj.resultText == ksuccess
        {
         globalStrings.showALert(message: PasswordChanged, target: self)
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    
    @IBAction func BackButton(_ sender: AnyObject)
    {
        self.navigationController?.pop(animated: true)
    }
    
}
