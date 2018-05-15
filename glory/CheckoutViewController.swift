//
//  CheckoutViewController.swift
//  Chnen
//
//  Created by navjot_sharma on 12/6/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire


class CheckoutViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource
{
    // MARK:-  Initialization
    var arrProducts = [Cart]()
    var arrShippingMethods = [Payment]()
    var arrPaymentMethods = [Payment]()
    var strShipMethod = Int()
    var strShipCode = String()
    var isVirtual = Bool()
    
    // MARK:-  Outlets
    
    @IBOutlet weak var txtShippingAddress: UILabel!
    @IBOutlet weak var txtBillingAddress: UILabel!
    @IBOutlet weak var tableShippingMethods: UITableView!
    @IBOutlet weak var tableCartProducts: UITableView!
    @IBOutlet weak var valueTotal: UILabel!
    @IBOutlet weak var valueDeliveryCharges: UILabel!
    @IBOutlet weak var valueDiscount: UILabel!
    @IBOutlet weak var valueSubtotal: UILabel!
    
    @IBOutlet weak var ConstraintTableCartHeight: NSLayoutConstraint!
    
    @IBOutlet weak var ConstraintTableShipHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        CartDetailApi()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:-  Api methods call
    func CartDetailApi()
    
    {
        activityIndicator.startAnimating(activityData)
        let parameters = [ksalt: SALT , QUOTE_ID : globalStrings.Quote_id , VISITOR_ID : globalStrings.Visitor_id, CUST_ID : globalStrings.Cust_id  , kcstore: one]
        let objCart = Cart()
        objCart.cartDetailApi(dict: parameters, target: self, selector: #selector(self.CartDetailResponse))
    }
    
    func ShippingMethodsApi()
    {
        activityIndicator.startAnimating(activityData)
        let parameters: Parameters = [ksalt: SALT as AnyObject , QUOTE_ID : globalStrings.Quote_id as AnyObject,  CUST_ID : globalStrings.Cust_id as AnyObject  , kcstore: one as AnyObject]
        let objPayment = Payment()
        objPayment.GetMethodsApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.ShippingMethodsResponse))
    }
    
    // MARK:-  Api methods response
    
    func CartDetailResponse(obj: Cart)
    {
        activityIndicator.stopAnimating()
        if obj.resultText == ksuccess
        {
            isVirtual = obj.is_virtual
            txtBillingAddress.text = obj.billingAddress.html2String
            txtShippingAddress.text = obj.shippingAddress.html2String
            
            valueSubtotal.text = obj.subtotal
            valueDiscount.text = obj.discount
            valueDeliveryCharges.text = obj.shipCost
            valueTotal.text = obj.grandtotal
            arrProducts = obj.arrProducts
            
            if arrProducts.count != 0
            {
                ConstraintTableCartHeight.constant = CGFloat(arrProducts.count * 68)
                tableCartProducts.reloadData()
            }
            ShippingMethodsApi()
        }
        else
        {
            globalStrings.showALert(message: SomethingWrong, target: self)
        }
    }
    
    func ShippingMethodsResponse(obj: Payment)
    {
        if obj.resultText == ksuccess
        {
            arrShippingMethods = obj.arrShipMethods
            arrPaymentMethods = obj.arrPayments
            if arrShippingMethods.count != 0
            {
                ConstraintTableShipHeight.constant = CGFloat(arrShippingMethods.count * 38  + 36)
                strShipMethod = arrShippingMethods.count
                tableShippingMethods.reloadData()
            }
            else
            {
                ConstraintTableShipHeight.constant = 34
            }
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
            
        }
        activityIndicator.stopAnimating()
    }
    
    func AssignShipResponse(obj : Payment)
    {
        if obj.resultText == ksuccess
        {
            valueSubtotal.text = obj.subtotal
            valueDiscount.text = obj.discount
            valueDeliveryCharges.text = obj.shipCost
            valueTotal.text = obj.grandTotal
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
        if tableView == tableCartProducts
        {
            return arrProducts.count
        }
        else
        {
            return arrShippingMethods.count
        }
    }
    
    // Cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == tableCartProducts
        {
            let cell: CartCheckoutCell = tableView.dequeueReusableCell(withIdentifier: cCartCheckoutCell) as! CartCheckoutCell
            
            cell.imgProduct .sd_setImage(with: URL(string: arrProducts[indexPath.row].image))
            cell.nameProduct.text = arrProducts[indexPath.row].name
            cell.priceProduct.text = globalStrings.currencyIcon + arrProducts[indexPath.row].price
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            let cell: ShippingMethodCell = tableView.dequeueReusableCell(withIdentifier: cShippingMethodCell) as! ShippingMethodCell
            if indexPath.row == strShipMethod {
                cell.btnRadio.setImage(#imageLiteral(resourceName: "RadioButtonSelected"), for: .normal)
            } else  {
                cell.btnRadio.setImage(#imageLiteral(resourceName: "RadioButton"), for: .normal)
            }
            cell.lblShippingMethod.text = arrShippingMethods[indexPath.row].carrier_title + " " + globalStrings.currencyIcon + " " + arrShippingMethods[indexPath.row].price_excl_tax
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tableCartProducts
        {
            return 68.0
        }
        else
        {
            return 38.0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if tableView == tableShippingMethods
        {
            let vw = UIView()
            vw.backgroundColor = UIColor.white
            let label = UILabel(frame: CGRect(x: 10, y: 5, width: 200, height: 21))
            label.textAlignment = .left
            label.text = SelectAShippingMethod
            label.font.withSize(10.0)
            label.textColor =  UIColor (red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
            vw.addSubview(label)
            return vw
        }
        else
        {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if tableView == tableShippingMethods
        {
            return 30
        }
        else
        {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == tableShippingMethods
        { 
            strShipMethod = indexPath.row
            strShipCode = arrShippingMethods[indexPath.row].method_code + "_" + arrShippingMethods[indexPath.row].carrier_code
            activityIndicator.startAnimating(activityData)
            let parameters = [ksalt: SALT , QUOTE_ID : globalStrings.Quote_id, SHIP_METHOD : strShipCode , CUST_ID : globalStrings.Cust_id , kcstore: one] as [String : Any]
            let objPayment = Payment()
            objPayment.AssignShipToQuoteApi(dict: parameters , target: self, selector: #selector(self.AssignShipResponse))
            tableShippingMethods.reloadData()
        }
    }
    
    // MARK: - ProceedToPay Button
    
    @IBAction func ProceedToPay(_ sender: AnyObject)
    {
        if isVirtual
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sPaymentMethodsViewController) as? PaymentMethodsViewController
            {
                vc.arrPayments = arrPaymentMethods
                vc.strSubtotal = valueSubtotal.text!
                vc.strDiscount = valueDiscount.text!
                vc.strDeliverycharges = valueDeliveryCharges.text!
                vc.strTotal = valueTotal.text!
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else
        {
            if strShipCode != ""
            {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sPaymentMethodsViewController) as? PaymentMethodsViewController
                {
                    vc.arrPayments = arrPaymentMethods
                    vc.strSubtotal = valueSubtotal.text!
                    vc.strDiscount = valueDiscount.text!
                    vc.strDeliverycharges = valueDeliveryCharges.text!
                    vc.strTotal = valueTotal.text!
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else
            {
                globalStrings.showALert(message: SpecifyShipMethod, target: self)
            }
        }
    }
    // MARK:- chnage Default Address button
    
    @IBAction func changeDefaultAddressBtn(_ sender: Any)
    {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sAddressViewController) as? AddressViewController
        {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK:-  Back Button methods
    
    @IBAction func ChangeAddress(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: SegueChangeAddress, sender: self)
    }
    
    // MARK:-  Back Button methods
    @IBAction func BackButton(_ sender: AnyObject)
    {
        self.navigationController?.pop(animated: true)
    }
    
    
}
