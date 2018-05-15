//
//  AccountViewController.swift
//  Chnen
//
//  Created by navjot_sharma on 12/15/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire

class AccountViewController: UIViewController
{
    
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var btnEditPhone: UIButton!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblPhoneLine: UILabel!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnMale: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        UserInfoApi()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:-  Api methods call
    
    func UserInfoApi()
    {
        activityIndicator.startAnimating(activityData)
        let parameters = [ksalt: SALT , CUST_ID : globalStrings.Cust_id , kcstore: one]
        let objUser = User()
        objUser.UserInfo(dict: parameters as [String : Any], target: self, selector: #selector(self.UserInfoResponse))
    }
    
    // MARK:-  Api methods response
    
    func UserInfoResponse(obj: User)
    {
        if obj.resultText == ksuccess
        {
            txtFirstName.text = obj.firstname
            txtLastName.text = obj.lastname
            lblPhone.isHidden = obj.telephone == "" ? true : false
            btnEditPhone.isHidden = obj.telephone == "" ? true : false
            lblPhoneLine.isHidden = obj.telephone == "" ? true : false
            if obj.gender == "1"
            {
                btnMale.setImage(#imageLiteral(resourceName: "maleSelected"), for: .normal)
            }
            else
            {
                btnFemale.setImage(#imageLiteral(resourceName: "femaleSelected"), for: .normal)
            }
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
     
    @IBAction func MaleFemaleButtons(_ sender: UIButton)
    {
        if (btnMale.imageView?.image?.isEqualToImage(image: #imageLiteral(resourceName: "maleSelected")))!
        {
            btnMale.setImage(#imageLiteral(resourceName: "male"), for: .normal)
            btnFemale.setImage( #imageLiteral(resourceName: "femaleSelected"), for: .normal)
        }
        else
        {
            btnMale.setImage(#imageLiteral(resourceName: "maleSelected"), for: .normal)
            btnFemale.setImage( #imageLiteral(resourceName: "female"), for: .normal)
        }
    }
    
    //MARK:- Save Profile Method
    
    @IBAction func SaveProfile(_ sender: UIButton)
    {
        let genderId = (btnMale.imageView?.image?.isEqualToImage(image: #imageLiteral(resourceName: "maleSelected")))! ? 1 : 2
        activityIndicator.startAnimating(activityData)
        let parameters = [ksalt: SALT , CUST_ID : globalStrings.Cust_id ,FIRST_NAME: txtFirstName.text! ,LAST_NAME: txtLastName.text! ,GENDER: genderId, kcstore: one] as [String : Any]
        let objUser = User()
        objUser.UpdateUserInfo(dict: parameters, target: self, selector: #selector(self.UpdatePasswordResponse))
    }
    
    // MARK:-  Api methods response
    
    func UpdatePasswordResponse(obj: User)
    {
        if obj.resultText == ksuccess
        {
            globalStrings.showALert(message: ProfileChanged, target: self)
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    @IBAction func EditPassword(_ sender: AnyObject)
    {}
    
    @IBAction func EditPhone(_ sender: AnyObject)
    {
    }
    // MARK: - Back button
    
    @IBAction func BackButton(_ sender: AnyObject)
    {
        self.navigationController?.pop(animated: true)
    }
    
}
