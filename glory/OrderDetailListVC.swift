//
//  OrderDetailListVC.swift
//  Chnen
//
//  Created by Navjot Sharma on 12/7/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

import Alamofire

class OrderDetailListVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    var k = 0
    var ProductId = String()
    var ItemArr = [Order]()
    var dataProduct = [AnyObject]()
    var filtered = [AnyObject]()
    var ArrProductName = [AnyObject]()
    var Customer_info = [String: AnyObject]()
    var shiping_address = [String: AnyObject]()
    var arrDownloadList =  [Order]()
    
    var applicationDictionary = [String: AnyObject]()
    
    @IBOutlet var tblHeightConstraints: NSLayoutConstraint!
    @IBOutlet var lblShipingAddVal: UILabel!
    @IBOutlet var lblBilingAddVal: UILabel!
    @IBOutlet var lblPaymentMethodValue: UILabel!
    @IBOutlet var lblOrderNoValue: UILabel!
    @IBOutlet var lblOrderDateValue: UILabel!
    @IBOutlet var lblOrderTotalValue: UILabel!
    @IBOutlet var lblGrandTotalVal: UILabel!
    @IBOutlet var lblSubTotlValue: UILabel!
    @IBOutlet var lblDeliverChargValue: UILabel!
    @IBOutlet var tblOrderItem: UITableView!
    @IBOutlet var viewContent: UIView!
    @IBOutlet var btnCancelOrder: UIButton!
    @IBOutlet var lblStatus: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tblOrderItem.tableFooterView = UIView()  // it's just 1 line, awesome!
        tblOrderItem.estimatedRowHeight = 128
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.GetOrderDetail()
    }
    
    
    override func viewDidLayoutSubviews()
    {
        tblHeightConstraints.constant = tblOrderItem.contentSize.height
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func updateViewConstraints()
    {
        super.updateViewConstraints()
    }
    
    func GetOrderDetail()
    {
        activityIndicator.startAnimating(activityData)
        let parameters: Parameters = [ksalt: SALT as AnyObject , UID : "22" as AnyObject , korder_id : ProductId as AnyObject ,kcstore: one as AnyObject,kcurrency :""]
        let objProduct = Order()
        objProduct.OrderDetailApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.OrderDetailResponse))
    }
    
    func OrderDelete()
    {
        activityIndicator.startAnimating(activityData)
        let parameters: Parameters = [ksalt: SALT as AnyObject , UID : "22" as AnyObject , korder_id : ProductId as AnyObject ,kcstore: one as AnyObject,kcurrency :""]
        let objProduct = Order()
        objProduct.OrderDeteteApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.OrderDeleteResponse))
    }
    
    func OrderDeleteResponse(obj: Order)
    {
        if obj.resultText == ksuccess
        {
            
            self.navigationController?.pop(animated: true)
            tblOrderItem.reloadData()
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
            print(obj.resultText)
        }
        activityIndicator.stopAnimating()
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
    
    func OrderDetailResponse(obj: Order)
    {
        
        if obj.resultText == ksuccess
        {
            print(obj.resultText)
            lblOrderNoValue.text = "#" + obj.order_id
            lblOrderDateValue.text =  ChangeDateFormat(date:obj.created)
            lblSubTotlValue.text = globalStrings.currencyIcon + obj.subtotal
            lblOrderTotalValue.text = obj.grand_total
            lblGrandTotalVal.text = obj.grand_total
            lblDeliverChargValue.text = obj.shipping_total
            lblPaymentMethodValue.text = obj.method_name
            btnCancelOrder.isHidden = (obj.status == "canceled" || obj.status == "complete" || obj.status == "On Hold" || obj.status == "processing")
            lblStatus.text = obj.status.capitalized
            
            lblBilingAddVal.text = obj.billing_firstname + " " + obj.billing_lastname + "\n" + obj.billing_street + ", " + obj.billing_city + ", " +  obj.billing_state + ", " + obj.billing_zipcode + "," + obj.billing_country_name + "\n" + obj.billing_telephone
            
            lblShipingAddVal.text = obj.shipping_firstname + " " + obj.shipping_lastname + "\n" + obj.shipping_street + ", " + obj.shipping_city + ", " +  obj.shipping_state + ", " + obj.shipping_zipcode + "," + obj.shipping_country_name + "\n" + obj.shipping_telephone
            
            ItemArr = obj.items
            tblOrderItem.reloadData()
        }

        else
        {
            globalStrings.showALert(message: obj.message, target: self)
            print(obj.resultText)
        }
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ItemArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:OrderDetailCell = tableView.dequeueReusableCell(withIdentifier:cOrderDetailCell) as! OrderDetailCell
        
        let urlImgg = URL(string: ItemArr[indexPath.row].img_url)
        cell.imgProduct.sd_setImage(with: urlImgg, placeholderImage: UIImage(named:""))
        cell.lblProductName.text = ItemArr[indexPath.row].name
        
        let QtyStr = ItemArr[indexPath.row].qty
        cell.lblQty.text = Qty + QtyStr
        cell.lblDelivery.text = "Not Available"
        
        let price = ItemArr[indexPath.row].final_price
        cell.lblPrice.text = globalStrings.currencyIcon + price
        return cell
        
    }
    
    @IBAction func cancel_order(_ sender: Any)
    {
        self.OrderDelete()
        
    }
    
    @IBAction func BackAction(_ sender: AnyObject)
    {
        self.navigationController?.pop(animated: true)
    }
}
