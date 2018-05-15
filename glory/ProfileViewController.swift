//
//  ProfileViewController.swift
//  glory
//
//  Created by navjot_sharma on 11/1/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate
{
    // MARK:-  outlets
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var NavigationView: UIView!
    @IBOutlet weak var OptionsTable: UITableView!
    @IBOutlet weak var SignInText: UIButton!
    @IBOutlet weak var ConstraintTableOptionHeight: NSLayoutConstraint!
    @IBOutlet weak var ConstraintNavigationViewY: NSLayoutConstraint!
    @IBOutlet weak var ConstraintTableOptionsY: NSLayoutConstraint!
    
    // MARK:-  Initialization
    var arrOptions = [String]()
    var arrOptionImages = [UIImage]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        
        if  defaults.bool(forKey: dis_login)
        {
            arrOptions = [account, language, aboutUs,appInfo, signout]
            arrOptionImages = [#imageLiteral(resourceName: "Language") ,#imageLiteral(resourceName: "Language") , #imageLiteral(resourceName: "Info"), #imageLiteral(resourceName: "Info"), #imageLiteral(resourceName: "Info")]
            ConstraintTableOptionHeight.constant = CGFloat(arrOptions.count * 50)
            ConstraintNavigationViewY.constant = -92
            ConstraintTableOptionsY.constant = 0
            NavigationView.isHidden = false
            SignInText.isHidden = true
            btnSignIn.isHidden = true
            OptionsTable.reloadData()
        }
        else
        {
            arrOptions = [language, aboutUs, appInfo]
            arrOptionImages = [#imageLiteral(resourceName: "Language") , #imageLiteral(resourceName: "Info"), #imageLiteral(resourceName: "Info")]
            ConstraintTableOptionHeight.constant = CGFloat(arrOptions.count * 50)
            ConstraintNavigationViewY.constant = 0
            ConstraintTableOptionsY.constant = -122
            NavigationView.isHidden = false
            SignInText.isHidden = false
            btnSignIn.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:-  Table methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrOptions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: CategoryTableCell = tableView.dequeueReusableCell(withIdentifier: cCategoryTableCell) as! CategoryTableCell
        cell.imgCategory.image = arrOptionImages[indexPath.row]
        cell.lblcategoryName.text = arrOptions[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50.0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        if arrOptions[indexPath.row] == appInfo
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sAppInfoViewController) as? AppInfoViewController
            {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else  if arrOptions[indexPath.row] == language
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sLanguageViewController) as? LanguageViewController
            {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else  if arrOptions[indexPath.row] == aboutUs
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sAboutUsViewController) as? AboutUsViewController
            {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else  if arrOptions[indexPath.row] == account
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sAccountViewController) as? AccountViewController
            {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else  if arrOptions[indexPath.row] == signout
        {
            defaults.removeObject(forKey: demail)
            defaults.removeObject(forKey: dis_login)
            defaults.removeObject(forKey: dcust_id)
            defaults.removeObject(forKey: dquote_id)
            defaults.removeObject(forKey: dquote_count)
            
            let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
            let tabArray = tabBarController.tabBar.items as NSArray!
            let chatItem = tabArray?.object(at: 2) as! UITabBarItem
            if #available(iOS 10.0, *) {
                chatItem.badgeColor = buttonColor
            } else {}
            chatItem.badgeValue = nil
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = tabBarController
        }
    }
    
    @IBAction func SignInUpButton(_ sender: AnyObject)
    {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sLoginViewController) as? LoginViewController
        {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func buttonNavigation(_ sender: UIButton)
    {
        if sender.tag == 41
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sOrderListVC) as? OrderListVC
            {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else  if sender.tag == 42
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sDownloadblesLIstVC) as? DownloadblesLIstVC
            {
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        else
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sAddressViewController) as? AddressViewController
            {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
}
