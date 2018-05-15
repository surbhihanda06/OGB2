
//
//  ForgetPasswordVC.swift
//  Chnen
//
//  Created by Navjot Sharma on 12/9/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

import Alamofire

class ForgetPasswordVC: UIViewController 
{
    @IBOutlet var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func SaveAction(_ sender: AnyObject)
    {
        self.Reset()
    }
    
    //resetPassword
    
    func Reset()
    {
        if  (txtEmail.text?.isEmpty)!
        {
            globalStrings.showALert(message: TextEmpty, target: self)
        }
        else if !((txtEmail.text?.isValidEmail())!)
        {
            globalStrings.showALert(message: NotValidEmail, target: self)
        }
        else
        {
            activityIndicator.startAnimating(activityData)
            let parameters: Parameters = [ksalt: SALT as AnyObject , EMAIL : txtEmail as AnyObject , kcstore: one as AnyObject]
            let objUser = User()
            objUser.ForgotPassword(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.ForgotPasswordResponse))
        }
    }
    
    func ForgotPasswordResponse(obj: User)
    {
        if obj.resultText == ksuccess
        {
            
        }
        else
        {
            
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    @IBAction func BackButton(_ sender: Any)
    {
        self.navigationController?.pop(animated: true)
    }
    
}
