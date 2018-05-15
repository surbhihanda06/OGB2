//
//  OrderListVC.swift
//  Chnen
//
//  Created by Navjot Sharma  on 12/2/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

import Alamofire

class OrderListVC: UIViewController ,UITableViewDelegate,UITableViewDataSource
{
    var clickedOrder = String()
    var OrderListArr = [Order]()
    var ProductListArr = [Order]()
    
    @IBOutlet var tblOrderLIst: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tblOrderLIst.tableFooterView = UIView()
        self.GetOrderList()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func GetOrderList()
    {
        activityIndicator.startAnimating(activityData)
        let parameters: Parameters = [ksalt: SALT as AnyObject , UID : globalStrings.Cust_id , PAGE_ID: Nzero, kcstore: one]
        let objProduct = Order()
        objProduct.OrderListApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.OrderListResponse))
    }
    
    func OrderListResponse(obj:Order)
    {
        if obj.resultText == ksuccess
        {
            if obj.arrOrder.count != 0
            {
                OrderListArr = obj.arrOrder
                tblOrderLIst.reloadData()
            }
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    
    // MARK: - Table Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return OrderListArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 96.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        ProductListArr = OrderListArr[section].arrProducts
        return ProductListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:OrderListCustomCell = tableView.dequeueReusableCell(withIdentifier:cOrderListCustomCell) as! OrderListCustomCell
        
        ProductListArr = OrderListArr[indexPath.section].arrProducts
        
        let imgUrlStr = ProductListArr[indexPath.row].image
        if imgUrlStr == ""
        {
            cell.imgProduct.image =  UIImage(named:"")
        }
        else
        {
            let urlImgg = URL(string: imgUrlStr)!
            cell.imgProduct.sd_setImage(with: urlImgg, placeholderImage: UIImage(named:""))
        }
        cell.lblBrandName.text = ProductListArr[indexPath.row].name
        cell.lblQty.text = ProductListArr[indexPath.row].price
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        clickedOrder = OrderListArr[indexPath.section].order_id
        self.performSegue(withIdentifier: SegueToOrderDetail, sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: cOrderListCustomHeader) as! OrderListCustomHeader
        ProductListArr = OrderListArr[section].arrProducts
        let strOrder = OrderListArr[section].order_id
        headerCell.lblOrderNo.text = OrderNo + "\(strOrder)"
        let items : Int = ProductListArr.count
        headerCell.lblItems.text = Items + "\(items)"
        var TotalAmount : Float = 0.0
        for i in 0 ..< ProductListArr.count
        {
            let str = ProductListArr[i].price.replacingOccurrences(of: ",", with: "")
            let productPrice = Float(str)
            TotalAmount = TotalAmount + productPrice!
        }
        headerCell.lblTotal.text =  total + String(TotalAmount)
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 54.0
    }
    
    
    @IBAction func BackButton(_ sender: AnyObject)
    {
        self.navigationController?.pop(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == SegueToOrderDetail
        {
            if let destinationVC = segue.destination as? OrderDetailListVC
            {
                destinationVC.ProductId = clickedOrder
            }
        }
    }
}
