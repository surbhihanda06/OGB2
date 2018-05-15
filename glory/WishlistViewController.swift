//
//  WishlistViewController.swift
//  glory
//
//  Created by navjot_sharma on 11/1/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire

class WishlistViewController: UIViewController  {
    
    @IBOutlet weak var noItemWishlist: UIImageView!
    @IBOutlet var TblWishList: UITableView!
    var arrWishList  = [WishList]()
    var strID  = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if defaults.bool(forKey: dis_login)
        {
            self.WishListProduct()
        }
        else
        {
            noItemWishlist.isHidden = false
            TblWishList.isHidden = true
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:-  Wishlist Api
    
    func WishListProduct()
    {
        activityIndicator.startAnimating(activityData)
        let parameters: Parameters = [ksalt: SALT as AnyObject , CUST_ID : globalStrings.Cust_id as AnyObject ,  kcstore: one as AnyObject]
        let objWishList = WishList()
        objWishList.WishListApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.WishListProductResponse))
    }
    
    func WishListProductResponse(obj: [WishList])
    {
        if obj[0].resultText == ksuccess
        {
            arrWishList = obj
            noItemWishlist.isHidden = true
            TblWishList.isHidden = false
            TblWishList .reloadData()
        }
        else
        {
            if obj[0].message == ""
            {
                noItemWishlist.isHidden = false
                TblWishList.isHidden = true
            }
            else
            {
                globalStrings.showALert(message: obj[0].message, target: self)
            }
        }
        activityIndicator.stopAnimating()
    }
    
    // MARK:- Remove Wishlist Product Api
    
    func RemoveWishListProduct(_ sender: UIButton)
    {
        activityIndicator.startAnimating(activityData)
        let parameters = [ksalt: SALT , CUST_ID : globalStrings.Cust_id , WISHLIST_ITEM_ID: arrWishList[sender.tag].wishlistItemId, kcstore: one]
        let objProduct = WishList()
        objProduct.DeleteFromWishListApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.RemoveWishListProductResponse))
    }
    
    func RemoveWishListProductResponse(obj: WishList)
    {
        if obj.resultText == ksuccess
        {
            self.WishListProduct()
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
}

extension WishlistViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrWishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:WishListCell = tableView.dequeueReusableCell(withIdentifier:cWishListCell) as! WishListCell
        cell.imgProduct.sd_setImage(with: URL(string: arrWishList[indexPath.row].product_image), placeholderImage: UIImage(named:""))
        cell.lblName.text = arrWishList[indexPath.row].product_name
        cell.lblBrand.text = arrWishList[indexPath.row].name
        cell.lblPrice.text = globalStrings.currencyIcon + arrWishList[indexPath.row].price
        cell.btnRemove.tag = indexPath.row
        cell.btnRemove.addTarget(self,action:#selector(RemoveWishListProduct(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        tableView.tableFooterView = UIView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}



