//
//  SuccessViewController.swift
//  Chnen
//
//  Created by navjot_sharma on 12/9/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var imgSuccess: UIImageView!
    @IBOutlet weak var lblSuccessOrder: UILabel!
    
    // MARK: - INITIALIZATION
    var strOrderId = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let str = "Your order #" + strOrderId + " has been successfully placed and will be delivered to you soon."
        lblSuccessOrder.text = str
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func ShopMore(_ sender: AnyObject) {
        let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        tabBarController.selectedIndex = 0
        
        let tabArray = tabBarController.tabBar.items as NSArray!
        let chatItem = tabArray?.object(at: 2) as! UITabBarItem
        chatItem.badgeValue = nil
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController
    }
    
    
}
