//
//  LanguageViewController.swift
//  Chnen
//
//  Created by navjot_sharma on 12/19/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire

class LanguageViewController: UIViewController , UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var tableCurrency: UITableView!
    @IBOutlet weak var tableLanguage: UITableView!
    @IBOutlet weak var ConstraintTableLanguageHeight: NSLayoutConstraint!
    @IBOutlet weak var ConstraintTableCurrencyHeight: NSLayoutConstraint!
    
    var arrStore = [AnyObject]()
    var arrCurrency = [AnyObject]()
    var strStore = Int()
    var strCurrency = Int()
    var arrLanguage =  [Home]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        StoreListApi()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:-  Api methods call
    
    func StoreListApi()
    {
        activityIndicator.startAnimating(activityData)
        let parameters: Parameters = [ksalt: SALT as AnyObject]
        let objHome = Home()
        objHome.GetStoreListApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.GetStoreListResponse))
    }
    
    // MARK:-  Api methods response
    
    func GetStoreListResponse(obj: Home)
    {
        if obj.resultText == ksuccess
        {
            
            arrStore = obj.arrStores
            print(obj.arrStores)
            if arrStore.count != 0
            {
                strStore = Int(obj.default_store_id)!
                ConstraintTableLanguageHeight.constant = CGFloat( arrStore.count * 44)
                tableLanguage.reloadData()
            }
            else
            {
                ConstraintTableLanguageHeight.constant = 0
            }
            arrCurrency = obj.arrcurrency
            
            if arrCurrency.count != 0
            {
                ConstraintTableCurrencyHeight.constant = CGFloat( arrCurrency.count * 44)
                tableCurrency.reloadData()
            }
            else
            {
                ConstraintTableCurrencyHeight.constant = 0
            }
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    // MARK:-  Table methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tableLanguage
        {
            return arrStore.count
        }
        else
        {
            return arrCurrency.count
        }
    }
    
    // Cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == tableLanguage
        {
            let cell: ShippingMethodCell = tableView.dequeueReusableCell(withIdentifier: cShippingMethodCell) as! ShippingMethodCell
            if indexPath.row == strStore
            {
                cell.btnRadio.setImage(#imageLiteral(resourceName: "RadioButtonSelected"), for: .normal)
            }
            else
            {
                cell.btnRadio.setImage(#imageLiteral(resourceName: "RadioButton"), for: .normal)
            }
            cell.lblShippingMethod.text = arrStore[indexPath.row].name
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            let cell: ShippingMethodCell = tableView.dequeueReusableCell(withIdentifier: cShippingMethodCell) as! ShippingMethodCell
            if indexPath.row == strCurrency
            {
                cell.btnRadio.setImage(#imageLiteral(resourceName: "RadioButtonSelected"), for: .normal)
            }
            else
            {
                cell.btnRadio.setImage(#imageLiteral(resourceName: "RadioButton"), for: .normal)
            }
            cell.lblShippingMethod.text = arrCurrency[indexPath.row].name
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 44.0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == tableLanguage
        {
            strStore = indexPath.row
            tableLanguage.reloadData()
        }
        else
        {
            strCurrency = indexPath.row
            tableCurrency.reloadData()
        }
    }
    
    @IBAction func backButton(_ sender: AnyObject)
    {
        self.navigationController?.pop(animated: true)
    }
}
