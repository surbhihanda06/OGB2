//
//  PaymentMethodsViewController.swift
//  Chnen
//
//  Created by navjot_sharma on 12/8/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

import Alamofire

class PaymentMethodsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource
{
    // MARK: - Initialization
    var arrPayments = [Payment]()
    var strSubtotal = String()
    var strDiscount = String()
    var strDeliverycharges = String()
    var strTotal = String()
    var strPayMethod = Int()
    var strPayCode = String()
    var arrSelectPayments = [AnyObject]()
    var arrImagePayment = [AnyObject]()
    // MARK: - Outlets
    
    @IBOutlet weak var valueSubtotal: UILabel!
    @IBOutlet weak var valueDeliveryCharges: UILabel!
    @IBOutlet weak var valueDiscount: UILabel!
    @IBOutlet weak var valueAmountPayable: UILabel!
    @IBOutlet weak var tablePaymentMethods: UITableView!
    @IBOutlet weak var ConstraintTablePaymentHeight: NSLayoutConstraint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //set texts to labels
        
        valueSubtotal.text = strSubtotal
        valueDeliveryCharges.text = strDeliverycharges
        valueDiscount.text = strDiscount
        valueAmountPayable.text = strTotal
        
        print(arrPayments)
        strPayMethod = arrPayments.count
        ConstraintTablePaymentHeight.constant = CGFloat(strPayMethod * 50)
        
        setPaymentMethods()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:-  Payment methods
    
    func setPaymentMethods()
    {
        arrImagePayment = [#imageLiteral(resourceName: "COD"),#imageLiteral(resourceName: "CreditCard")]
    }
    
    // MARK:-  Table methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrPayments.count
    }
    
    // Cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: PaymentMethodCell = tableView.dequeueReusableCell(withIdentifier: cPaymentMethodCell) as! PaymentMethodCell
        if indexPath.row == strPayMethod
        {
            cell.btnRadio.setImage(#imageLiteral(resourceName: "RadioButtonSelected"), for: .normal)
        }
        else
        {
            cell.btnRadio.setImage(#imageLiteral(resourceName: "RadioButton"), for: .normal)
        }
        if indexPath.row < arrImagePayment.count
        {
            cell.imgPymentMethod.image = arrImagePayment[indexPath.row] as? UIImage
        }
        
        cell.lblPaymentMethod.text = arrPayments[indexPath.row].title
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50.0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        strPayMethod = indexPath.row
        strPayCode = arrPayments[indexPath.row].code
        activityIndicator.startAnimating(activityData)
        let parameters = [ksalt: SALT  , QUOTE_ID : globalStrings.Quote_id, PAY_METHOD : strPayCode , CUST_ID : globalStrings.Cust_id , kcstore: one]
        let objPayment = Payment()
        objPayment.AssignPaymentToQuoteApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.AssignPaymentResponse))
        
        tablePaymentMethods.reloadData()
    }
    
    func AssignPaymentResponse(obj: Payment)
    {
        if obj.resultText == ksuccess
        {
            valueSubtotal.text = obj.subtotal
            valueDiscount.text = obj.discount
            valueDeliveryCharges.text = obj.shipCost
            valueAmountPayable.text = obj.grandTotal
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Place Order Button
    @IBAction func PlaceOrder(_ sender: AnyObject)
    {
        activityIndicator.startAnimating(activityData)
        var strEmail = String()
        if defaults.value(forKey: demail) == nil
        {
            strEmail = ""
        }
        else
        {
            strEmail = defaults.value(forKey: demail) as! String
        }
        var deviceId = UserDefaults.standard.object(forKey: ddevice_id) as? String
        if deviceId == nil
        {
            deviceId = ""
        }
        let parameters = [ksalt: SALT , QUOTE_ID : globalStrings.Quote_id , DEVICE_ID : deviceId, DEVICE_TYPE : Iphone, CUST_ID : globalStrings.Cust_id , PAY_METHOD : strPayCode, kcstore: one]
        let objPayment = Payment()
        objPayment.PlaceOrderApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.PlaceOrderResponse))
        
    }
    
    func PlaceOrderResponse(obj: Payment)
    {
        if obj.resultText == ksuccess
        {
            globalStrings.Quote_count = 0
            globalStrings.Quote_id = ""
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sSuccessViewController) as? SuccessViewController
            {
                vc.strOrderId = obj.orderId
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Back Button
    
    @IBAction func BackButton(_ sender: AnyObject)
    {
        self.navigationController?.pop(animated: true)
    }

}
