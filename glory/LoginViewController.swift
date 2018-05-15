//
//  LoginViewController.swift
//  Chnen
//
//  Created by Navjot Sharma on 11/28/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire
import Google
import GoogleSignIn
import DropDown

class LoginViewController: UIViewController {
    
    @IBOutlet var viewLogin: UIScrollView!
    @IBOutlet var btnSignUp: UIButton!
    @IBOutlet var btnSignIn: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var txtEmailLog: UITextField!
    @IBOutlet var txtPassLog: UITextField!
    
    var IsCheck : Bool = false
    var loginType : String = ""
    var emailSocial : String = ""
    var SocialId : String = ""
    var gender : String = ""
    
    @IBOutlet var btnCheck: UIButton!
    @IBOutlet var btnGender: UIButton!
    @IBOutlet var lblGender: UILabel!
    @IBOutlet var txtPassReg: UITextField!
    @IBOutlet var txtEmailReg: UITextField!
    @IBOutlet var txtFirstName: UITextField!
    @IBOutlet var txtLastName: UITextField!
    
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewLogin.isHidden = true
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func setupDefaultDropDown() {
        DropDown.setupDefaultAppearance()
        dropDown.cellNib = UINib(nibName: "DropDownCell", bundle: Bundle(for: DropDownCell.self))
        dropDown.customCellConfiguration = nil
    }
    
    func dropDownMethod(sender: UIButton) {
        setupDefaultDropDown()
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.dataSource = ["Male","Female"]
        dropDown.show()
        dropDown.selectionAction = {(index: Int, item: String) in
            self.lblGender.text = item
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Default UI Behaviour
    func setDefaultUIBehaviour() {
        
        btnCheck.setImage(#imageLiteral(resourceName: "Uncheck"), for: UIControlState.normal)
        viewLogin.isHidden = true
    }
    
    // MARK:- SignIn/SignUp
    @IBAction func SignInAction(_ sender: AnyObject) {
        
        btnSignUp.setTitleColor(UIColor.black, for: .normal)
        btnSignUp.backgroundColor = UIColor.white
        btnSignIn.setTitleColor(UIColor.white, for: .normal)
        btnSignIn.backgroundColor = UIColor.black
        viewLogin.isHidden = false
        scrollView.setContentOffset(CGPoint(x: 0, y:0), animated: true)
    }
    
    @IBAction func SignUpAction(_ sender: AnyObject) {
        
        btnSignUp.setTitleColor(UIColor.white, for: .normal)
        btnSignUp.backgroundColor = UIColor.black
        btnSignIn.setTitleColor(UIColor.black , for: .normal)
        btnSignIn.backgroundColor = UIColor.white
        viewLogin.isHidden = true
    }
    
    // MARK:- String Conversion TO md5 format
    @IBAction func googleSignIn(_ sender: Any) {
        activityIndicator.startAnimating(activityData)
    }
    
    // MARK:-  Action Methods
    @IBAction func GenderAction(_ sender: UIButton) {
        self.dropDownMethod(sender: sender)
    }
    
    @IBAction func ForgotPassword(_ sender: Any) {
        self.performSegue(withIdentifier: SegueToForgotPassword, sender: self)
    }
    
    @IBAction func CheckAction(_ sender: AnyObject) {
        IsCheck = !IsCheck
        btnCheck.setImage(IsCheck ? #imageLiteral(resourceName: "Check") : #imageLiteral(resourceName: "Uncheck"), for: UIControlState.normal)
    }
    
    @IBAction func BackButton(_ sender: AnyObject) {
        self.navigationController?.pop(animated: true)
    }
    
    // MARK:- Facebook Login/Register
    @IBAction func facebookLogin(_ sender: Any) {
        
        self.view.endEditing(true)
        
        FacebookManager.login(target: self) { (fbData) in
            
            DispatchQueue.main.async {
                
                self.gender = fbData.gender
                self.emailSocial = fbData.email
                
                let firstName = fbData.firstName
                let lastName = fbData.lastName
                let fbId = "fb_"+"\(self.emailSocial)".md5().md5()
                let gmailId = "gmail_"+"\(self.emailSocial)".md5().md5()
                let twitterId = "twitter"+"\(self.emailSocial)".md5().md5()
                
                self.SocialId = fbId
                self.loginType = "fb"
                
                let parameters: Parameters = [ksalt: SALT, EMAIL : self.emailSocial, PASSWORD: "",FIRST_NAME: firstName, LAST_NAME:lastName, "fb_social_id": fbId,"gmail_social_id": gmailId,"twitter_social_id": twitterId,"login_type":self.loginType,GENDER: self.gender, DEVICE_TYPE: Iphone,DEVICE_ID: Defaults.deviceId!, kcstore: one]
                self.registerAPI(parameters: parameters, isSocialRegister: true)
                
            }
        }
    }
    
    // MARK:-  Login Action
    @IBAction func LoginAction(_ sender: AnyObject)
    {
        if  (txtEmailLog.text?.isEmpty)! || (txtPassLog.text?.isEmpty)! {
            AlertManager.showAlert(type: .custom(TextEmpty))
        }
        else if !(txtEmailLog.text?.isValidEmail())! {
            AlertManager.showAlert(type: .custom(NotValidEmail))
        }
        else {
            defaults.setValue(txtEmailLog.text!, forKey: demail)
            let parameters = [ksalt: SALT , LOGIN_TYPE: "", SOCIAL_ID: "" ,EMAIL:txtEmailLog.text!, PASSWORD: txtPassLog.text!,QUOTE_ID:"",DEVICE_TYPE: Iphone,DEVICE_ID: Defaults.deviceId!,kcstore:"",kcurrency:""] as [String: Any]
            self.loginAPI(with: parameters)
        }
    }
    
    //MARK: Login API
    func loginAPI(with parameters: [String:Any]) {
        
        NetworkManager.login(parameters) { (success) in
            if success {
                self.navigationController?.pop(animated: true)
            }
        }
    }
    
    // MARK:- Register Action
    @IBAction func RegisterAction(_ sender: AnyObject) {
        
        if (txtFirstName.text?.isEmpty)! || (txtLastName.text?.isEmpty)! || (txtEmailReg.text!.isEmpty) || (txtPassReg.text?.isEmpty)!
        {
            AlertManager.showAlert(type: .custom(TextEmpty))
        }
        else if !(txtEmailReg.text?.isValidEmail())!
        {
            AlertManager.showAlert(type: .custom(NotValidEmail))
        }
        else if (txtFirstName.text?.count)! < 3
        {
            AlertManager.showAlert(type: .custom(Lessfirstname))
        }
        else if (txtLastName.text?.count)! < 3
        {
            AlertManager.showAlert(type: .custom(Lesslastname))
        }
        else if (txtPassReg.text?.count)! < 6
        {
            AlertManager.showAlert(type: .custom(LessCharacteredPassword))
        }
        else
        {
            defaults.setValue(txtEmailReg.text!, forKey: demail)
            let genderId : String = lblGender.text == Male ? "1" : "2"
            let parameters = [ksalt: SALT , EMAIL : txtEmailReg.text!, PASSWORD: txtPassReg.text!,FIRST_NAME: txtFirstName.text!,LAST_NAME: txtLastName.text!,DEVICE_TYPE: Iphone ,DEVICE_ID: Defaults.deviceId! ,GENDER : genderId , kcstore: one]
            self.registerAPI(parameters: parameters, isSocialRegister: false)
        }
    }
    
    //MARK: Register API
    func registerAPI(parameters:[String:Any], isSocialRegister: Bool) {
        
        NetworkManager.registerApi(dict: parameters, completion: { (success) in
            if success {
                if isSocialRegister {
                    self.socialRegisterLogin()
                }
                else {
                    self.registerLogin()
                }
            }
        })
    }
    
    // MARK:- Register Login
    // social register login
    func socialRegisterLogin() {
        
        let parameters = [ksalt: SALT, EMAIL : emailSocial, PASSWORD: "", DEVICE_TYPE: Iphone, DEVICE_ID: Defaults.deviceId!, kcstore: one, "login_type": LOGIN_TYPE, "social_id": SocialId]
        self.loginAPI(with: parameters)
    }
    
    // register login
    func registerLogin() {
        
        let parameters = [ksalt: SALT , LOGIN_TYPE: "email" ,SOCIAL_ID: "", EMAIL:txtEmailReg.text!, PASSWORD: txtPassReg.text!, QUOTE_ID:"",DEVICE_TYPE: Iphone, DEVICE_ID: Defaults.deviceId!, kcstore:"",kcurrency:""] as [String: Any]
        self.loginAPI(with: parameters)
    }
}

// MARK:- UITextField Delegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}

// MARK:- GoogleSignIn Delegate
extension LoginViewController: GIDSignInUIDelegate,GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        DispatchQueue.main.async {
            
            if (error == nil) {
                
                let fullName = user.profile.name.components(separatedBy: " ")
                
                var firstName = ""
                var lastName  = ""
                if fullName.count > 0 {
                    firstName = fullName[0]
                    if fullName.count > 1 {
                        lastName = fullName[1]
                    }
                }
                
                self.emailSocial = user.profile.email!
                
                let fbId = "fb_\(self.emailSocial)".md5().md5()
                let gmailId = "gmail_\(self.emailSocial)".md5().md5()
                let twitterId = "twitter_\(self.emailSocial)".md5().md5()
                
                self.SocialId = gmailId
                self.loginType = "gmail"
                
                let parameters: Parameters = [ksalt: SALT, EMAIL : self.emailSocial, PASSWORD: "", FIRST_NAME: firstName, LAST_NAME:lastName, "fb_social_id": fbId, "gmail_social_id": gmailId,"twitter_social_id": twitterId, LOGIN_TYPE: self.loginType,GENDER: self.gender, DEVICE_TYPE: Iphone, DEVICE_ID: (Defaults.deviceId)!, kcstore: one]
                self.registerAPI(parameters: parameters, isSocialRegister: true)
                
            }
            else {
                activityIndicator.stopAnimating()
            }
        }
    }
}
