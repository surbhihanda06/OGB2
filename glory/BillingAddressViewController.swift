//
//  BillingAddressViewController.swift
//  Chnen
//
//  Created by navjot_sharma on 12/1/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import DropDown
import Alamofire

class BillingAddressViewController: UIViewController 
{
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
    @IBOutlet weak var btnSameAddress: UIButton!
    @IBOutlet weak var btnRegion: UIButton!
    
    var addrId = String()
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

    // MARK:-  Continue Button methods
    
    @IBAction func ContinueButton(_ sender: UIButton)
    {
        if self.regionId == ""
        {
            self.setRegion_id = "0"
        }
        else
        {
            self.setRegion_id = regionId
        }


        var useForShipping = String()
        if (btnSameAddress.imageView?.image?.isEqualToImage(image:#imageLiteral(resourceName: "SameBilling_Selected")))!
        {
            useForShipping = one
        }
        else
        {
            useForShipping = zero
        }
        
        
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
            var parameters = [ksalt: SALT , CUST_ID : globalStrings.Cust_id , QUOTE_ID: globalStrings.Quote_id , USE_FOR_SHIPPING: useForShipping , FIRST_NAME: txtFirstname.text!, LAST_NAME: txtLastname.text!, STREET: txtAddress.text!, CITY: txtCity.text! , REGION:  txtState.text!,REGION_ID :self.regionId , ZIP: txtZipCode.text! , COUNTRY_ID: self.countryId == "" ? txtCountry.text! : self.countryId, PHONE: txtMobile.text! , EXTRA_PHONE: txtExtraMobile.text! , EMAIL: txtEmailAddress.text! , FAX: "" , kcstore: one ,"save_addr":"1"]
            print(parameters)

            let objUser = User()
            if addrId != "" {
                parameters[ADDR_ID] = addrId
               objUser.UpdateCustomerAddress(dict: parameters, target: self, selector: #selector(self.SetBillingAddress_Response))
            } else {
             objUser.SaveAddress(dict: parameters, target: self, selector: #selector(self.SetBillingAddress_Response))
            }
        }
    }
    
    func SetBillingAddress_Response(obj:User)
    {
        if obj.resultText == ksuccess
        {
            if (btnSameAddress.imageView?.image?.isEqualToImage(image: #imageLiteral(resourceName: "SameBilling_Selected")))!
            {
                self.performSegue(withIdentifier: SegueCheckout, sender: self)
            }
            else
            {
                self.performSegue(withIdentifier: SegueToShipping, sender: self)
            }
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
        guard let text = textField.text else {
            return true
        }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 10
    }
    
    // MARK:-  SameShippingAddress Button methods
    
    @IBAction func SameShippingAddress(_ sender: AnyObject)
    {
        if (btnSameAddress.imageView?.image?.isEqualToImage(image: #imageLiteral(resourceName: "SameBilling_Selected")))!
        {
            btnSameAddress.setImage(#imageLiteral(resourceName: "SameBilling_unselected"), for: .normal)
        }
        else
        {
            btnSameAddress.setImage(#imageLiteral(resourceName: "SameBilling_Selected"), for: .normal)
        }
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
        self.navigationController?.popViewController(animated: true)
    }
}
