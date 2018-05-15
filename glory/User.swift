//
//  User.swift
//  Chnen
//
//  Created by navjot_sharma on 12/2/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire
class User: NSObject
{
    var delegate :AnyObject!
    var handler :Selector? = nil
    var resultText = String()
    var message = String()
    var email = String()
    var firstname = String()
    var lastname = String()
    var gender = String()
    var telephone = String()
    var addresses = [User]()
    var arrDownloadAbleList = [User]()
    
    var arrDown_prod = [User]()
    var price = String()
    var image = String()
    var remaining = String()
    var dwnldableLink = String()
    var Qty = String()
    var orderID = String()
    var orderDate = String()
    
    var addr_id = String()
    var as_html = String()
    var defaultBilling = String()
    var defaultShipping = String()
    var city = String()
    var country_id = String()
    var street = String()
    var region = String()
    var postcode = String()
    var extraPhone = String()
    var iso2_code = String()
    var name = String()
    var code = String()
    var region_id = String()
    
    //MARK:- Login API
    
    func SignInApi(dict:Parameters, target:AnyObject, selector:Selector)
    {
        print("Request -- > \(dict)")
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+LOGIN, selector: #selector(fillLoginResponse), delegate: self, dict: dict, method: .get)
    }
    
    func fillLoginResponse (_ responseDict: [String: Any]) {
        let objUser = User()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                if let cust_id = response[kcust_id] as? String {
                    globalStrings.Cust_id = cust_id
                    defaults.setValue(cust_id, forKey: dcust_id)
                    defaults.set(true, forKey: dis_login)
                }
                if let quote_id = response[kquote_id] as? String {
                    globalStrings.Quote_id = quote_id
                    defaults.setValue(quote_id, forKey: dquote_id)
                }
                if let quote_count = response[kquote_count] as? Int {
                    globalStrings.Quote_count = quote_count
                    defaults.setValue(quote_count, forKey: dquote_count)
                }
                
                if let str = response[kresponse] as? String {
                    objUser.message =  str
                }
                objUser.resultText = ksuccess
            }
        }else
        {
            objUser.resultText = kisFail
            if let str = responseDict[kresponse] as? [String: Any] {
                objUser.message =  str[kresponse_msg] as! String
            }
        }
        delegate.performSelector(onMainThread: handler!, with:objUser, waitUntilDone: true)
    }
    
    //MARK:- Register API
    func RegisterApi(dict:Parameters, target:AnyObject, selector:Selector)
    {
        print(BASE_URL+REGISTRATION)
        print("Request -- > \(dict)")
        delegate = target
        handler = selector
        
        server.connectToServerWithRequest(url: BASE_URL+REGISTRATION, selector: #selector(fillRegisterResponse), delegate: self, dict: dict, method: .get)
    }
    
    func fillRegisterResponse (_ responseDict: [String: Any]) {
        print(responseDict)
        let objUser = User()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                if let cust_id = response[kcust_id] as? String
                {
                    globalStrings.Cust_id = cust_id
                    defaults.setValue(cust_id, forKey: dcust_id)
                    defaults.set(true, forKey: dis_login)
                }
            }
        }
        else
        {
            objUser.resultText = kisFail
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                objUser.resultText = ksuccess
                if let _ = response[kmessage] as? String
                {
                    objUser.message = response[kmessage] as! String
                }
        }
        delegate.performSelector(onMainThread: handler!, with:objUser, waitUntilDone: true)
    }
    }
    
    //MARK:- ForgotPassword API
    
    func ForgotPassword(dict:Parameters, target:AnyObject, selector:Selector) {
        
        print("Request -- > \(dict)")
        print(dict)
        delegate = target
        handler = selector
        
        server.connectToServerWithRequest(url: BASE_URL+RESET_PASSWORD, selector: #selector(fillForgotPasswordResponse), delegate: self, dict: dict, method: .get)
    }
    
    func fillForgotPasswordResponse (_ responseDict: [String: Any]) {
        let objUser = User()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                
                
                if let cust_id = response[kcust_id] as? String {
                    globalStrings.Cust_id = cust_id
                    defaults.setValue(cust_id, forKey: dcust_id)
                    defaults.set(true, forKey: dis_login)
                    
                }
            }
        }else
        {
            objUser.resultText = kisFail
            objUser.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objUser, waitUntilDone: true)
    }
    //MARK:- UserInfo API
    
    func UserInfo(dict:Parameters, target:AnyObject, selector:Selector)
    {
        
        print("Request -- > \(dict)")
        print(dict)
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+USER_INFO, selector: #selector(fillUserInfoResponse), delegate: self, dict: dict, method: .get)
    }
    
    func fillUserInfoResponse (_ responseDict: [String: Any]) {
        let objUser = User()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                objUser.resultText = ksuccess
                if let _ = response[kemail] as? String {
                    objUser.email = response[kemail] as! String
                }
                if let _ = response[kgender] as? String {
                    objUser.gender = response[kgender] as! String
                }
                if let _ = response[kfirstname] as? String {
                    objUser.firstname = response[kfirstname] as! String
                }
                if let _ = response[klastname] as? String {
                    objUser.lastname = response[klastname] as! String
                }
                if let _ = response[ktelephone] as? String {
                    objUser.telephone = response[ktelephone] as! String
                }
            }
        }else
        {
            objUser.resultText = kisFail
            objUser.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objUser, waitUntilDone: true)
    }
    
    //MARK:- UPDATE UserInfo API
    
    func UpdateUserInfo(dict:Parameters, target:AnyObject, selector:Selector) {
        
        print("Request -- > \(dict)")
        print(dict)
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+UPDATE_USER_INFO, selector: #selector(UpdateUserInfoResponse), delegate: self, dict: dict, method: .get)
    }
    
    func UpdateUserInfoResponse (_ responseDict: [String: Any]) {
        let objUser = User()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            objUser.resultText = ksuccess
        }else
        {
            objUser.resultText = kisFail
            objUser.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objUser, waitUntilDone: true)
    }
    
    //MARK:- SaveAddress API
    
    func SaveAddress(dict:Parameters, target:AnyObject, selector:Selector)
    {
        print("Request -- > \(dict)")
        
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+SET_QUOTE_ADDRESS, selector: #selector(SetQuoteAddressResponse), delegate: self, dict: dict, method: .get)
    }
    
    
    
    func SetQuoteAddressResponse (_ responseDict: [String: Any]) {
        let objUser = User()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            objUser.resultText = ksuccess
        }else
        {
            objUser.resultText = kisFail
            objUser.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objUser, waitUntilDone: true)
    }
    //MARK:- SaveAddress API
    
    func UpdateCustomerAddress(dict:Parameters, target:AnyObject, selector:Selector)
    {
        print("Request -- > \(dict)")
        
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+UPDATE_CUST_ADDR, selector: #selector(SetQuoteAddressResponse), delegate: self, dict: dict, method: .get)
    }
    
    func UpdateAddressResponse (_ responseDict: [String: Any]) {
        let objUser = User()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            objUser.resultText = ksuccess
        }else
        {
            objUser.resultText = kisFail
            objUser.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objUser, waitUntilDone: true)
    }
    
    //MARK:- GetAddress API
    
    func GetAddress(dict:Parameters, target:AnyObject, selector:Selector)
    {
        print("Request -- > \(dict)")
        
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+GET_CUSTOMER_ADDR_BY_ID, selector: #selector(CustomerAddressByIDResponse(_:)), delegate: self, dict: dict, method: .get)
        
    }
    
    func CustomerAddressByIDResponse (_ responseDict: [String: Any]) {
        let objUser = User()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                if let dict = response[kAddress] as? [String: Any] {
                    if let _ = dict[kfirstname] as? String {
                        objUser.firstname = dict[kfirstname] as! String
                    }
                    if let _ = dict[klastname] as? String {
                        objUser.lastname = dict[klastname] as! String
                    }
                    if let _ = dict[kemail] as? String {
                        objUser.email = dict[kemail] as! String
                    }
                    if let _ = dict[kstreet] as? String {
                        objUser.street = dict[kstreet] as! String
                    }
                    if let _ = dict[kcountry_id] as? String {
                        objUser.country_id = dict[kcountry_id] as! String
                    }
                    if let _ = dict[kcity] as? String {
                        objUser.city = dict[kcity] as! String
                    }
                    if let _ = dict[kregion] as? String {
                        objUser.region = dict[kregion] as! String
                    }
                    if let _ = dict[kregion_id] as? String {
                        objUser.region_id = dict[kregion_id] as! String
                    }
                    if let _ = dict[kpostcode] as? String {
                        objUser.postcode = dict[kpostcode] as! String
                    }
                    if let _ = dict[ktelephone] as? String {
                        objUser.telephone = dict[ktelephone] as! String
                    }
                    if let _ = dict[kextra_phone] as? String {
                        objUser.extraPhone = dict[kextra_phone] as! String
                    }
                    objUser.resultText = ksuccess
                }
            }
        }else
        {
            objUser.resultText = kisFail
            objUser.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objUser, waitUntilDone: true)
    }
    
    //MARK:- SavedAddresses API
    
    func SavedAddresses(dict:[String: Any], target:AnyObject, selector:Selector)
    {
        print("Request -- > \(dict)")
        
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+GET_CUSTOMER_ADDRLIST, selector: #selector(CustomerAddressListResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func CustomerAddressListResponse (_ responseDict: [String: Any]) {
        let objUser = User()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                for dict in response[kAddresses] as! [[String: Any]] {
                    let obj = User()
                    if let _ = dict[kaddr_id] as? String {
                        obj.addr_id = dict[kaddr_id] as! String
                    }
                    if let _ = dict[kas_html] as? String {
                        obj.as_html = dict[kas_html] as! String
                    }
                    objUser.addresses.append(obj)
                }
                if let _ = response[kBilling] as? String {
                    objUser.defaultBilling = response[kBilling] as! String
                }
                if let _ = response[kShipping] as? String {
                    objUser.defaultShipping = response[kShipping] as! String
                }
            }
            objUser.resultText = ksuccess
        }
        else
        {
            objUser.resultText = kisFail
            objUser.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objUser, waitUntilDone: true)
    }
    
    //MARK:- SetDefaultAddresses API
    
    func SetDefaultAddresses(dict:Parameters, target:AnyObject, selector:Selector)
    {
        print("Request -- > \(dict)")
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+UPDATE_ADDR_PREF, selector: #selector(UpdateAddressPrefResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func UpdateAddressPrefResponse (_ responseDict: [String: Any]) {
        let objUser = User()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            objUser.resultText = ksuccess
            objUser.message = AddressChanged
        }else
        {
            objUser.resultText = kisFail
            objUser.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objUser, waitUntilDone: true)
    }
    
    //MARK:- GetCountry List API
    
    func GetCountrylist(dict:Parameters, target:AnyObject, selector:Selector)
    {
        print("Request -- > \(dict)")
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+GET_COUNTRY, selector: #selector(CountryListResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func CountryListResponse (_ responseDict: [String: Any]) {
        var objUser = [User]()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [[String: Any]]
            {
                for dict in response {
                    let obj = User()
                    if let _ = dict[kcountry_id] as? String {
                        obj.country_id = dict[kcountry_id] as! String
                    }
                    if let _ = dict[kiso2_code] as? String {
                        obj.iso2_code = dict[kiso2_code] as! String
                    }
                    if let _ = dict[kname] as? String {
                        obj.name = dict[kname] as! String
                    }
                    obj.resultText = ksuccess
                    objUser.append(obj)
                }
                if objUser.count == 0 {
                    let obj = User()
                    obj.resultText = kisFail
                    objUser.append(obj)
                } else {
                    objUser = objUser.sorted(by: {$0.name < $1.name})
                }
            }
        }else
        {
            let obj = User()
            obj.resultText = kisFail
            objUser.append(obj)
        }
        delegate.performSelector(onMainThread: handler!, with:objUser, waitUntilDone: true)
    }
    
    //MARK:- Get Region List API
    
    func GetRegionlist(dict:Parameters, target:AnyObject, selector:Selector)
    {
        print("Request -- > \(dict)")
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL+GET_REGION, selector: #selector(RegionListResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func RegionListResponse (_ responseDict: [String: Any]) {
        var objUser = [User]()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [[String: Any]]
            {
                for dict in response {
                    let obj = User()
                    if let _ = dict[kregion_id] as? String {
                        obj.region_id = dict[kregion_id] as! String
                    }
                    if let _ = dict[kcode] as? String {
                        obj.iso2_code = dict[kcode] as! String
                    }
                    if let _ = dict[kname] as? String {
                        obj.name = dict[kname] as! String
                    }
                    obj.resultText = ksuccess
                    objUser.append(obj)
                }
                if objUser.count == 0 {
                    let obj = User()
                    obj.resultText = kisFail
                    objUser.append(obj)
                }else {
                    objUser = objUser.sorted(by: {$0.name < $1.name})
                }
            }
        }else
        {
            let obj = User()
            obj.resultText = kisFail
            objUser.append(obj)
        }
        delegate.performSelector(onMainThread: handler!, with:objUser, waitUntilDone: true)
    }
    
    //MARK: Downloadable product List Api
    
    func  DownloadListApi(dict:Parameters, target:AnyObject, selector:Selector)
    {
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL + GETMYDOWNLOADABLES, selector: #selector(fillDownloadListResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func fillDownloadListResponse (_ responseDict : [String: Any]) {
        print(responseDict)
        let objDownload = User()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                objDownload.resultText = ksuccess
                
                if let _ = response[kitems] as? [[String: Any]] {
                    for i in response[kitems] as! [[String: Any]] {
                        let objO = User()
                        print(i)
                        if let  remaining = i["remaining"]
                        {
                            objO.remaining = "\(remaining)"
                        }
                        else
                        {
                            objO.remaining = "0"
                        }
                        if let _ = i[klink_hash] as? String{
                            objO.dwnldableLink = i[klink_hash] as! String
                        }
                        if let _ = i[kproduct_title] as? String{
                            objO.name = i[kproduct_title] as! String
                        }
                        if let _ = i[kprice] as? String{
                            objO.price = i[kprice] as! String
                        }
                        else
                        {
                            objO.price = "60.0"
                        }
                        
                        if let _ =  i[kimage] as? String
                        {
                            objO.image = i[kimage] as! String
                        }
                        if let _ = i[QTY] as? String
                        {
                            objO.Qty = i[QTY] as! String
                        }
                        else
                        {
                            objO.Qty = "2"
                        }
                        if let _ = i[korder_id] as? String
                        {
                            objO.orderID = i[korder_id] as! String
                        }
                        else
                        {
                            objO.orderID = "00000000"
                        }
                        if let _ = i[korder_date] as? Int
                        {
                            objO.orderDate = String(i[korder_date] as! Int)
                        }
                        else
                        {
                            objO.orderDate = "00-00-00 00:00:00"
                        }
                        objDownload.arrDownloadAbleList.append(objO)
                    }
                }
            }
        } else
        {
            objDownload.resultText = kisFail
            objDownload.message =  responseDict[kresponse] as! String
        }
        delegate.performSelector(onMainThread: handler!, with:objDownload, waitUntilDone: true)
    }
    
    func  DownloadfileApi(dict:Parameters, target:AnyObject, selector:Selector)
    {
        delegate = target
        handler = selector
        server.connectToServerWithRequest(url: BASE_URL + GETDOWLOAD_LINK, selector: #selector(DownloadfileResponse(_:)), delegate: self, dict: dict, method: .get)
    }
    
    func DownloadfileResponse (_ responseDict : [String: Any])
    {
        print(responseDict)
        let objOrder = Order()
        let result = (responseDict[kreturnCode] as! [String: Any])[kresultText] as! String
        if result == ksuccess
        {
            if  let response = responseDict[kresponse] as? [String: Any]
            {
                print(response)
                objOrder.resultText = ksuccess
            }
        }
        else
        {
            objOrder.resultText = kisFail
            objOrder.message = responseDict[kresponse] as! String
            print(objOrder.message)
        }
        
        delegate.performSelector(onMainThread: handler!, with:objOrder, waitUntilDone: true)
    }   
}
