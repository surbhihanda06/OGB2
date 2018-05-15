//
//  NewPhoneViewController.swift
//  Chnen
//
//  Created by navjot_sharma on 12/16/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

import Alamofire

class NewPhoneViewController: UIViewController  {
    
    @IBOutlet weak var txtPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SavePhone(_ sender: AnyObject)
    {
        activityIndicator.startAnimating(activityData)
        let parameters: Parameters = [ksalt: SALT as AnyObject , CUST_ID : globalStrings.Cust_id as AnyObject ,PHONE: txtPhone.text as AnyObject  , kcstore: one as AnyObject]
        let objUser = User()
        objUser.UpdateUserInfo(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.UpdatePhoneResponse))
    }
    
    // MARK:-  Api methods response
    
    func UpdatePhoneResponse(obj: User)
    {
        if obj.resultText == ksuccess
        {
             globalStrings.showALert(message: PhoneChanged, target: self)
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
