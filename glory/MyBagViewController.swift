//
//  MyBagViewController.swift
//  glory
//
//  Created by navjot_sharma on 11/1/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

import Alamofire

class MyBagViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource
{
    var arrProducts = [Cart]()
    var isReload = Bool()
    var hasAddr = Bool()
    
    // OUTLETS
    
    @IBOutlet weak var countProduct: UILabel!
    @IBOutlet weak var imgNoItem: UIImageView!
    @IBOutlet weak var tableCart: UITableView!
    @IBOutlet weak var StrSubtotal: UILabel!
    @IBOutlet weak var valueSubtotal: UILabel!
    @IBOutlet weak var CheckoutView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        
        if !(globalStrings.Quote_id.isEmpty)
        {
            self.CartDetailApi()
            imgNoItem.isHidden = true
        }
        else
        {
            CheckoutView.isHidden = true
            imgNoItem.isHidden = false
            tableCart.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(true)
        isReload = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:-  Api methods call
    func CartDetailApi()
    {
        activityIndicator.startAnimating(activityData)
        let parameters: Parameters = [ksalt: SALT as AnyObject , QUOTE_ID : globalStrings.Quote_id as AnyObject, VISITOR_ID : globalStrings.Visitor_id as AnyObject, CUST_ID : globalStrings.Cust_id as AnyObject  , kcstore: one as AnyObject]
        let objCart = Cart()
        objCart.cartDetailApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.CartDetailResponse))
    }
    
    // MARK:-  Api methods response
    
    func CartDetailResponse(obj:Cart)
    {
        activityIndicator.stopAnimating()
        if obj.resultText == ksuccess
        {
            arrProducts = obj.arrProducts
            hasAddr = obj.custaddr
            valueSubtotal.text = obj.grandtotal
            if globalStrings.Quote_count > 1
            {
                countProduct.text = String( globalStrings.Quote_count)  + PRODUCT
            }
            else
            {
                countProduct.text = String( globalStrings.Quote_count)  + PRODUCTS
            }

            if arrProducts.count != 0
            {
                imgNoItem.isHidden = true
                CheckoutView.isHidden = false
                tableCart.isHidden = false
                tableCart.reloadData()
            }
            else
            {
                CheckoutView.isHidden = true
                imgNoItem.isHidden = false
                tableCart.isHidden = true
            }
            
            if isReload
            {
                let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                let tabArray = tabBarController.tabBar.items as NSArray!
                let chatItem = tabArray?.object(at: 2) as! UITabBarItem
                tabBarController.selectedIndex = 2
                if #available(iOS 10.0, *) {
                    chatItem.badgeColor = buttonColor
                }
                
                if Int(globalStrings.Quote_count) > 0
                {
                    chatItem.badgeValue = String(globalStrings.Quote_count)
                }
                else
                {
                    chatItem.badgeValue = nil
                }
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = tabBarController
            }
        }
        else
        {
            CheckoutView.isHidden = true
            imgNoItem.isHidden = false
            tableCart.isHidden = true
            globalStrings.showALert(message: obj.message, target: self)
        }
        
    }
    
    func RemovebuttonClickedResponse(obj:Cart)
    {
        if obj.resultText == ksuccess
        {
            print(obj.message)
            CartDetailApi()
        }
            
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    func SaveForLaterResponse(obj:Cart)
    {
        if obj.resultText == ksuccess
        {
            print(obj.message)
            CartDetailApi()
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    func PlusbuttonResponse(obj:Cart)
    {
        if obj.resultText == ksuccess
        {
            CartDetailApi()
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    func MinusbuttonResponse(obj:Cart)
    {
        if obj.resultText == ksuccess
        {
            print(obj.message)
            CartDetailApi()
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
        return arrProducts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: CartViewCell = tableView.dequeueReusableCell(withIdentifier: cCartViewCell) as! CartViewCell
        cell.imgProduct .sd_setImage(with:  URL(string: arrProducts[indexPath.row].image))
        cell.lblName.text = arrProducts[indexPath.row].name
        cell.lblPrice.text = globalStrings.currencyIcon + arrProducts[indexPath.row].price
        cell.lblQty.text = String(arrProducts[indexPath.row].qty)
        cell.lblQty.tag = indexPath.row + 444
        if arrProducts[indexPath.row].qty <= 1
        {
            cell.btnMinus.isHidden = true
        }
        else
        {
            cell.btnMinus.isHidden = false
        }
        if arrProducts[indexPath.row].qty >= 3
        {
            cell.btnPlus.isHidden = true
        }
        else
        {
            cell.btnPlus.isHidden = false
        }
        cell.btnRemove.tag = indexPath.row + 555
        cell.btnRemove.addTarget(self,action:#selector(RemovebuttonClicked),
                                 for:.touchUpInside)
        cell.btnSaveForLater.tag = indexPath.row + 666
        cell.btnSaveForLater.addTarget(self,action:#selector(SaveForLaterbuttonClicked),
                                       for:.touchUpInside)
        cell.btnPlus.tag = indexPath.row + 777
        cell.btnPlus.addTarget(self,action:#selector(PlusbuttonClicked),
                               for:.touchUpInside)
        cell.btnMinus.tag = indexPath.row + 888
        cell.btnMinus.addTarget(self,action:#selector(MinusbuttonClicked),
                                for:.touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 128.0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
    // MARK: - Cell Button Methods
    
    func RemovebuttonClicked(sender:UIButton)
    {
        if sender.isSelected
        {
            sender.setImage(#imageLiteral(resourceName: "Remove_selected"), for: .selected)
        }
        activityIndicator.startAnimating(activityData)
        isReload = true
        let parameters = [ksalt: SALT , QUOTE_ID : globalStrings.Quote_id, PROD_ID : arrProducts[sender.tag-555].prod_Id, ITEM_ID : arrProducts[sender.tag-555].item_id, kcstore: one as AnyObject] as [String : Any]
        let objCart = Cart()
        objCart.DeleteFromCart(dict: parameters, target: self, selector: #selector(self.RemovebuttonClickedResponse))
    }
    
    func SaveForLaterbuttonClicked(sender:UIButton)
    {
        isReload = true
        let parameters = [ksalt: SALT , QUOTE_ID : globalStrings.Quote_id, PROD_ID : arrProducts[sender.tag-666].prod_Id, ITEM_ID : arrProducts[sender.tag-666].item_id , CUST_ID : globalStrings.Cust_id , kcstore: one]  as [String : Any]
        let objCart = Cart()
        activityIndicator.startAnimating(activityData)
        objCart.MoveToWishlist(dict: parameters, target: self, selector: #selector(self.SaveForLaterResponse))
    }
    
    func PlusbuttonClicked(sender:UIButton)
    {
        isReload = true
        let tag = sender.tag - 777
        let btnPlus = self.view.viewWithTag(sender.tag) as! UIButton
        let btnMinus = self.view.viewWithTag(tag + 888) as! UIButton
        let label = self.view.viewWithTag(tag + 444) as! UILabel
        let strQty = Int(label.text!)! + 1
        label.text =  String(strQty)
        if strQty <= 1
        {
            btnMinus.isHidden = true
        }
        else
        {
            btnMinus.isHidden = false
        }
        if strQty >= 3
        {
            btnPlus.isHidden = true
        }
        else
        {
            btnPlus.isHidden = false
        }
        let parameters = [ksalt: SALT , QUOTE_ID : globalStrings.Quote_id, QTY : strQty , ITEM_ID : arrProducts[sender.tag-777].item_id, kcstore: one] as [String : Any]
        let objCart = Cart()
        objCart.UpdateCart(dict: parameters , target: self, selector: #selector(self.PlusbuttonResponse))
    }
    
    func MinusbuttonClicked(sender:UIButton)
    {
        isReload = true
        let tag = sender.tag - 888
        let label = self.view.viewWithTag(tag + 444) as! UILabel
        let strQty = Int(label.text!)! - 1
        label.text =  String(strQty)
        let btnPlus = self.view.viewWithTag(tag + 777) as! UIButton
        let btnMinus = self.view.viewWithTag(sender.tag) as! UIButton
        if strQty <= 1
        {
            btnMinus.isHidden = true
        }
        else
        {
            btnMinus.isHidden = false
        }
        if strQty >= 3
        {
            btnPlus.isHidden = true
        }
        else
        {
            btnPlus.isHidden = false
        }
        let parameters = [ksalt: SALT , QUOTE_ID : globalStrings.Quote_id , QTY : strQty , PROD_ID : arrProducts[sender.tag-888].prod_Id, ITEM_ID : arrProducts[sender.tag-888].item_id, kcstore: one] as [String : Any]
        let objCart = Cart()
        objCart.UpdateCart(dict: parameters, target: self, selector: #selector(self.MinusbuttonResponse))
    }
    
    // MARK: - Checkout Button Method
    
    @IBAction func CheckoutMethod(_ sender: AnyObject)
    {
        if hasAddr == true
        {
            let story = UIStoryboard.init(name :"Main",bundle:nil)
            let checkoutVC = story.instantiateViewController(withIdentifier: "CheckoutViewController") as? CheckoutViewController
            self.navigationController?.pushViewController(checkoutVC!, animated: true)
        }
        else
        {
            self.performSegue(withIdentifier: defaults.bool(forKey: dis_login) ? SegueGuestToAddress : SegueBagToGuest , sender: self)
      }
    }
}
