//
//  DownloadblesLIstVC.swift
//  Chnen
//
//  Created by Rakesh on 8/8/17.
//  Copyright © 2017 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire


class DownloadblesLIstVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var arrDownloadList =  [User]()
    
    @IBOutlet var tblDownloadList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetDownloadableList()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func GetDownloadableList()
    {
        activityIndicator.startAnimating(activityData)
        
        let parameters: Parameters = [ksalt: SALT as AnyObject , kcust_id : globalStrings.Cust_id , PAGE_ID: Nzero, kcstore: one]
        let obj = User()
        obj.DownloadListApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.DownloadableListResponse))
    }
    
    func DownloadableListResponse(obj:User)
    {
        print(obj)
        if obj.resultText == ksuccess
        {
            if obj.arrDownloadAbleList.count != 0
            {
                arrDownloadList = obj.arrDownloadAbleList
                tblDownloadList.reloadData()
            }
            else
            {
                // tblOrderLIst.isHidden = true
                // print(obj.message)
                //   globalStrings.showALert(message: obj.message, target: self)
            }
        }
        else
        {
            // tblOrderLIst.isHidden = true
            //  print(obj.message)
            //   globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    func GetDownloadablelink(_ sender: UIButton)
    {
        activityIndicator.startAnimating(activityData)
        let parameters: Parameters = [ksalt: SALT as AnyObject,kcust_id : globalStrings.Cust_id ,kcstore: one,kHash:arrDownloadList[sender.tag].dwnldableLink]
        let obj = User()
        obj.DownloadfileApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.DownloadableLinkResponse))
    }
    
    func DownloadableLinkResponse(obj:User)
    {
        activityIndicator.stopAnimating()
        print(obj)
        if obj.resultText == ksuccess
        {
            print(obj.resultText == ksuccess)
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
    }
    
    func ChangeDateFormat(date:String) -> String
    {
        if let timeStamp = TimeInterval.init(date)
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd hh:mm:ss"
            let date = NSDate(timeIntervalSince1970:timeStamp)
            formatter.dateFormat = "MMM dd, YYYY"
            let FinaldateStr = formatter.string(from: date as Date)
            return FinaldateStr
        }
        return ""
    }
    
    //MARK: - UITableView Delegates
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 180.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //ProductListArr = OrderListArr[section].arrProducts
        return arrDownloadList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:DownloadableCell = tableView.dequeueReusableCell(withIdentifier:cDownloadableCell) as! DownloadableCell
        
        let imgUrlStr = arrDownloadList[indexPath.row].image
        if imgUrlStr == ""
        {
            cell.imgProduct.image =  UIImage(named:"")
        }
        else
        {
            let urlImgg = URL(string: imgUrlStr)!
            cell.imgProduct.sd_setImage(with: urlImgg, placeholderImage: UIImage(named:""))
        }
        
        cell.lblProductName.text = arrDownloadList[indexPath.row].name
        print(globalStrings.currencyIcon)
        cell.lblSize.text = globalStrings.currencyIcon + arrDownloadList[indexPath.row].price
        cell.lblRemainCount.text = arrDownloadList[indexPath.row].remaining
        cell.lblProductOrderNo.text = arrDownloadList[indexPath.row].orderID
        cell.lblPlace.text = "Placed on" + ChangeDateFormat(date:arrDownloadList[indexPath.row].orderDate)
        
        cell.downloadlinkBtn.tag = indexPath.row
        cell.downloadlinkBtn.addTarget(self,action:#selector(GetDownloadablelink(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //        clickedOrder = OrderListArr[indexPath.section].order_id
        //        self.performSegue(withIdentifier: SegueToOrderDetail, sender: self)
        
    }
    
    //MARK: - BackAction
    @IBAction func BackButton(_ sender: AnyObject)
    {
        self.navigationController?.pop(animated: true)
    }
}

extension String
{
    func BlackString() -> NSMutableAttributedString
    {
        let attString =  NSMutableAttributedString.init(string: self, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 13), NSForegroundColorAttributeName:UIColor.black])
        return attString
    }
    func DarkGray() -> NSMutableAttributedString
    {
        let attString =  NSMutableAttributedString.init(string: self, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 13), NSForegroundColorAttributeName:UIColor.darkGray])
        return attString
    }
}
