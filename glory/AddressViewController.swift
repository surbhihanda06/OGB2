//
//  AddressViewController.swift
//  Chnen
//
//  Created by navjot_sharma on 12/1/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

import Alamofire


class AddressViewController: UIViewController
{
    @IBOutlet weak var tablesavedAddress: UITableView!
    @IBOutlet weak var btnShipping: UIButton!
    @IBOutlet weak var btnBilling: UIButton!
    
    var arrAddresses = [User]()
    var defaultBilling = String()
    var defaultShipping = String()
    var isBilling = Bool()
    var idEditable = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        isBilling = true
        SavedAddressApi()
        tablesavedAddress.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:-  Api methods call
    
    func SavedAddressApi()
    {
        activityIndicator.startAnimating(activityData)
        let parameters = [ksalt: SALT, CUST_ID : globalStrings.Cust_id , kcstore: one]
        let objUser = User()
        objUser.SavedAddresses(dict: parameters as [String : Any], target: self, selector: #selector(self.SavedAddressResponse))
    }
    
    // MARK:-  Api methods response
    
    func SavedAddressResponse(obj: User)
    {
        if obj.resultText == ksuccess
        {
            arrAddresses = obj.addresses
            if arrAddresses.count != 0
            {
                defaultBilling = obj.defaultBilling
                defaultShipping = obj.defaultShipping
                tablesavedAddress.reloadData()
            }
        }
        else
        {
            globalStrings.showALert(message: SomethingWrong, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    // MARK:-  Billing Button method
    
    @IBAction func BillingButton(_ sender: AnyObject)
    {
        isBilling = true
        btnBilling.setBackgroundImage(#imageLiteral(resourceName: "ButtonBackground"), for: .normal)
        btnBilling.setTitleColor(UIColor.white, for: .normal)
        btnShipping.setTitleColor(buttonColor, for: .normal)
        btnShipping.setBackgroundImage(UIImage(named:""), for: .normal)
        tablesavedAddress.reloadData()
    }
    
    // MARK:-  Shipping Button method
    
    @IBAction func Shippingbutton(_ sender: AnyObject)
    {
        isBilling = false
        btnShipping.setBackgroundImage(#imageLiteral(resourceName: "ButtonBackground"), for: .normal)
        btnShipping.setTitleColor(UIColor.white, for: .normal)
        btnBilling.setTitleColor(buttonColor, for: .normal)
        btnBilling.setBackgroundImage(UIImage(named:""), for: .normal)
        tablesavedAddress.reloadData()
    }
    
    func EditbuttonClicked(sender:UIButton)
    {
        let defaultStr = arrAddresses[sender.tag-555].addr_id
        idEditable = defaultStr
        if isBilling
        {
            self.performSegue(withIdentifier: SegueEditBilling, sender: self)
        }
        else
        {
            self.performSegue(withIdentifier: SegueEditShipping, sender: self)
        }
    }
    
    @IBAction func addNewAddressBtn(_ sender: Any)
    {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sBillingAddressViewController) as? BillingAddressViewController
        {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK:-  DeliverNow Button method
    
    @IBAction func DeliverNow(_ sender: AnyObject)
    {
        let  parameters : Parameters = [ksalt: SALT as AnyObject, CUST_ID: globalStrings.Cust_id as AnyObject, QUOTE_ID: globalStrings.Quote_id as AnyObject , BILL_ID : defaultBilling as AnyObject , SHIP_ID: defaultShipping as AnyObject , kcstore: one as AnyObject ]
        let objUser = User()
        objUser.SetDefaultAddresses(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.DeliverNowResponse))
    }
    
    func DeliverNowResponse(obj: User)
    {
        if obj.resultText == ksuccess
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    // MARK:-  Back Button method
    
    @IBAction func BackButton(_ sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == SegueEditBilling
        {
            if let destinationVC = segue.destination as? BillingAddressViewController
            {
                destinationVC.addrId = idEditable
            }
        }
        else
        {
            if segue.identifier == SegueEditShipping
            {
                if let destinationVC = segue.destination as? ShippingAddressViewController
                {
                    destinationVC.addrId = idEditable
                }
            }
        }
    }
}

extension AddressViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrAddresses.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:SavedAddressCell = tableView.dequeueReusableCell(withIdentifier: cSavedAddressCell) as! SavedAddressCell
        let defaultStr = arrAddresses[indexPath.row].addr_id
        if isBilling
        {
            if defaultBilling == defaultStr
            {
                cell.btnRadio.setImage( #imageLiteral(resourceName: "RadioButtonSelected"), for: .normal)
            }
            else
            {
                cell.btnRadio.setImage(#imageLiteral(resourceName: "RadioButton"), for: .normal)
            }
        }
        else
        {
            if defaultShipping == defaultStr
            {
                cell.btnRadio.setImage(#imageLiteral(resourceName: "RadioButtonSelected"), for: .normal)
            }
            else
            {
                cell.btnRadio.setImage(#imageLiteral(resourceName: "RadioButton"), for: .normal)
            }
        }
        cell.btnEdit.tag = indexPath.row + 555
        cell.btnEdit.addTarget(self,action:#selector(EditbuttonClicked),
                               for:.touchUpInside)
        let addressStr = arrAddresses[indexPath.row].as_html
        cell.lblAddress.text = addressStr.html2String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let defaultStr = arrAddresses[indexPath.row].addr_id
        if isBilling
        {
            defaultBilling = defaultStr
        }
        else
        {
            defaultShipping = defaultStr
        }
        tablesavedAddress.reloadData()
    }
}
