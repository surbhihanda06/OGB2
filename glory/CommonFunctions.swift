//
//  CommonFunctions.swift
//  Chnen
//
//  Created by navjot_sharma on 11/11/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.



import UIKit

class CommonFunctions: NSObject
{
    
    static var instance: CommonFunctions!
    var Quote_id = String()
    var Quote_count = Int()
    var currencyIcon = String()
    var isFromFilter = Bool()
    var Visitor_id = String()
    var Cust_id = String()
    
    // SHARED INSTANCE
    class func sharedInstance() -> CommonFunctions
    {
        self.instance = (self.instance ?? CommonFunctions())
        return self.instance
    }
    
    func getTextHeight(textView: UITextView) -> CGFloat
    {
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        return newSize.height
    }
    
    
    func showALert(message:String,target:AnyObject) {
        let alert = UIAlertController(title: nil , message: message, preferredStyle: UIAlertControllerStyle.alert )
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {Void in})
        alert.addAction(action)
        target.present(alert, animated: true, completion: nil)
    }
    
    func showALertAction(message:String,target:AnyObject, actions: UIAlertAction ) {
        let alert = UIAlertController(title: nil , message: message, preferredStyle: UIAlertControllerStyle.alert )
        alert.addAction(actions)
        target.present(alert, animated: true, completion: nil)
    }
    
    func animateView(contraint:NSLayoutConstraint,constant:CGFloat,target:AnyObject){
        target.view.layoutSubviews()
        UIView.animate(withDuration: 0.4, animations: {
            contraint.constant = constant
            target.view.layoutSubviews()
        })
    }
    
    func animation(contraint:NSLayoutConstraint,constant:CGFloat,target:AnyObject){
        target.view.layoutSubviews()
        UIView.animate(withDuration: 0.4, animations: {
            contraint.constant = constant
            target.view.layoutSubviews()
        })
    }
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if NSURL(string: urlString) != nil {
                return true
            }
        }
        return false
    }
    
    func createDictionary(id: String, typeId: String, price: String, type: String, qty: String? = nil) -> [String: String] {
        var dict = [String: String]()
        dict["id"] =  id
        dict["typeId"] = typeId
        dict["price"]  = price
        dict["type"]  = type
        if let _ = qty {
            dict["qty"]  = qty
        }
        return dict
    }
    
    func arrSelectionFields(arrMain: [[String: Any]], id: String) -> [[String: Any]] {
        var arr = [[String: Any]]()
        for i  in arrMain
        {
            if i[koption_id] as? String == String(id)
            {
                for j in  i[kselections] as! [AnyObject]
                {
                    arr.append(j as! [String: Any]) } }
        }
        print(arr)
        return arr
    }
    
    
    
    
    func arrAdditionalFields(arrMain: [[String: Any]], id: String) -> [[String: Any]] {
        var arr = [[String: Any]]()
        for i  in arrMain
        {
            if i[koption_id] as? String == String(id)
            {
                if let additionalFields = i[kadditional_fields] as? [AnyObject] {
                    for j in  additionalFields
                    {
                        arr.append(j as! [String: Any])
                    }
                }
            }
        }
        return arr
    }
    
    func dictOptions(arrMain: [[String: Any]], id: String) -> [String: Any] {
        for i  in arrMain
        {
            if i[koption_id] as? String == String(id){
                return i  as [String: Any] }
        }
        return [String: Any]()
    }
    
}

let commonFunctions = CommonFunctions.sharedInstance()


