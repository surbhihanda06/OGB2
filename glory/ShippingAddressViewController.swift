//
//  ShippingAddressViewController.swift
//  Chnen
//
//  Created by navjot_sharma on 11/30/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire
import DropDown

class ShippingAddressViewController: UIViewController 
{
    
    var addrId = String()
    
    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtExtraMobile: UITextField!
    @IBOutlet weak var txtZipCode: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var btnRegion: UIButton!
    
    var arrCountry = [String: Any]()
    let dropDown = DropDown()
    var arrCountries = [User]()
    var arrRegions = [User]()
    var regionId = String()
    var countryId = String()
    var setRegion_id = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if addrId  != ""
        {
            GetBillingAddressApi()
        }
        else {
            GetCountryApi()
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:-  Api methods call
    
    func GetCountryApi()
    {
        activityIndicator.startAnimating(activityData)
        let parameters = [ksalt: SALT , kcstore: one] as [String : Any]
        let objUser = User()
        objUser.GetCountrylist(dict: parameters , target: self, selector: #selector(self.GetCountryListResponse))
    }
    
    func GetRegionApi(isoCode : String)
    {
        activityIndicator.startAnimating(activityData)
        let parameters = [ksalt: SALT , kcstore: one,kiso2_code: isoCode] as [String : Any]
        let objUser = User()
        objUser.GetRegionlist(dict: parameters , target: self, selector: #selector(self.GetRegionListResponse))
    }
    
    func GetBillingAddressApi()
    {
        activityIndicator.startAnimating(activityData)
        let parameters = [ksalt: SALT , QUOTE_ID : globalStrings.Quote_id, CUST_ID : globalStrings.Cust_id, ADDR_ID : addrId , kcstore: one] as [String : Any]
        let objUser = User()
        objUser.GetAddress(dict: parameters , target: self, selector: #selector(self.GetBillingAddressResponse))
    }
    
    // MARK:-  Api methods response
    func GetBillingAddressResponse(obj: User)
    {
        if obj.resultText == ksuccess
        {
            txtFirstname.text = obj.firstname
            txtLastname.text = obj.lastname
            txtEmailAddress.text = obj.email
            txtAddress.text = obj.street
            txtCountry.text = obj.country_id
            txtCity.text = obj.city
            txtState.text = obj.region
            txtZipCode.text = obj.postcode
            txtMobile.text = obj.telephone
            txtExtraMobile.text = obj.extraPhone
            regionId = obj.region_id
            countryId = obj.country_id
        }
        else
        {
            globalStrings.showALert(message: SomethingWrong, target: self)
        }
        activityIndicator.stopAnimating()
        GetCountryApi()
    }

    func GetCountryListResponse(obj: [User])
    {
        if obj[0].resultText == ksuccess
        {
            arrCountries = obj
        }
        activityIndicator.stopAnimating()
    }
    
    func GetRegionListResponse(obj: [User])
    {
        arrRegions.removeAll()
        if obj[0].resultText == ksuccess
        {
            arrRegions = obj
        }
        btnRegion.isHidden = arrRegions.count == 0 ? true : false
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Save And Continue Button Methods
    
    @IBAction func SaveAndContinueButton(_ sender: AnyObject)
    {
        
        if self.regionId == ""
        {
            self.setRegion_id = "0"
        }
        else
        {
            self.setRegion_id = regionId
        }

        if (txtFirstname.text?.isEmpty)! || (txtLastname.text?.isEmpty)! || (txtEmailAddress.text?.isEmpty)! || (txtCity.text?.isEmpty)! || (txtState.text?.isEmpty)! || (txtCountry.text?.isEmpty)! || (txtAddress.text?.isEmpty)! || (txtZipCode.text?.isEmpty)! || (txtMobile.text?.isEmpty)!
        {
            globalStrings.showALert(message: TextEmpty, target: self)
        }
        else if !(txtEmailAddress.text?.isValidEmail())!
        {
            globalStrings.showALert(message: NotValidEmail, target: self)
        }
            
        else
        {
            activityIndicator.startAnimating(activityData)
            var parameters = [ksalt: SALT   , CUST_ID : globalStrings.Cust_id   , QUOTE_ID: globalStrings.Quote_id  , SFIRST_NAME: txtFirstname.text!  , SLAST_NAME: txtLastname.text!  , SSTREET: txtAddress.text!  , SCITY: txtCity.text! , SREGION: txtState.text!,SREGION_ID : self.regionId, SZIP: txtZipCode.text!, SCOUNTRY_ID: self.countryId == "" ? txtCountry.text! : self.countryId , SPHONE: txtMobile.text!, SEXTRA_PHONE: txtExtraMobile.text!, SEMAIL: txtEmailAddress.text! , SFAX: ""  , ONLY_SHIP : one   , kcstore: one ]
            print(parameters)
            let objUser = User()
            if addrId == ""
            {
            objUser.SaveAddress(dict: parameters, target: self, selector: #selector(self.SetShippingAddress_Response))
            }else
            {
                parameters[ADDR_ID] = addrId
                objUser.UpdateCustomerAddress(dict: parameters, target: self, selector: #selector(self.SetShippingAddress_Response))
            }
        }
    }
    
    func SetShippingAddress_Response(obj:User)
    {
        if obj.resultText == ksuccess
        {
            self.performSegue(withIdentifier: SegueCheckout, sender: self)
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
        
    // MARK: - Textfield Delegate Methods
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        guard let text = textField.text else
        {
            return true
        }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 10 // Bool
    }
    
    @IBAction func CountryButton(_ sender: UIButton) {
        setupDefaultDropDown()
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        var arr = [String]()
        for i in arrCountries {
            arr.append(i.name)
        }
        dropDown.dataSource = arr
        dropDown.show()
        dropDown.selectionAction = {(index: Int, item: String) in
            print (index, item)
            self.txtCountry.text = item
            self.countryId = self.arrCountries[index].country_id
            self.txtState.text = ""
            self.regionId = ""
            self.GetRegionApi(isoCode: self.arrCountries[index].iso2_code)
        }
    }
    
    @IBAction func RegionButton(_ sender: UIButton) {
        setupDefaultDropDown()
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        var arr = [String]()
        for i in arrRegions {
            arr.append(i.name)
        }
        dropDown.dataSource = arr
        dropDown.show()
        dropDown.selectionAction = {(index: Int, item: String) in
            self.txtState.text = item
            self.regionId = self.arrRegions[index].region_id
        }
    }
    
    func setupDefaultDropDown()
    {
        DropDown.setupDefaultAppearance()
        dropDown.cellNib = UINib(nibName: "DropDownCell", bundle: Bundle(for: DropDownCell.self))
        dropDown.customCellConfiguration = nil
    }
    
    // MARK:-  Back Button methods
    
    @IBAction func BackButton(_ sender: AnyObject)
    {
        self.navigationController?.pop(animated: true)
    }
}
