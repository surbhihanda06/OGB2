//
//  CustomOptionUI.swift
//  Chnen
//
//  Created by Navjot_sharma on 1/3/17.
//  Copyright © 2017 navjot_sharma. All rights reserved.
//

import UIKit
import DropDown

typealias TextFieldSelector = (_ quantity: String) -> Void

class CustomOptionUI: NSObject
{
    static var instance: CustomOptionUI!
    var delegate1 :AnyObject!
    var handler1 :Selector? = nil
    
    // SHARED INSTANCE
    
    class func sharedInstance() -> CustomOptionUI
    {
        self.instance = (self.instance ?? CustomOptionUI())
        return self.instance
    }
    
    
    @objc func returntextfield(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    func dropdowns(dict: [String: Any], view: UIView,target:AnyObject , selector:Selector) -> UIView
    {
        delegate1 = target
        handler1 = selector
        let lblButton = UIButton.init(frame: CGRect(x: 0,y: view.frame.size.height ,width:view.frame.size.width , height: 30 ))
        lblButton.setTitle(dict[ktitle] as? String, for: .normal)
        lblButton.backgroundColor = UIColor.white
        lblButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        lblButton.setTitleColor(buttonColor, for: .normal)
        lblButton.setImage(#imageLiteral(resourceName: "DownArrowGrey"), for: .normal)
        lblButton.addTarget(target, action:handler1!, for: .touchUpInside)
        lblButton.centerTextAndImage(spacing: view.frame.size.width/2)
        lblButton.tag = Int(dict[koption_id] as! String)!
        view.addSubview(lblButton)
        view.frame = CGRect(x: view.frame.origin.x ,y: view.frame.origin.y ,width:view.frame.size.width , height: lblButton.frame.size.height + lblButton.frame.origin.y + 10)
        return view
    }
    
    func dates(dict: [String: Any], view: UIView,target:AnyObject , selector:Selector) -> UIView
    {
        delegate1 = target
        handler1 = selector
        
        let lblHeader = UILabel.init(frame: CGRect(x: 0,y: view.frame.size.height  ,width:view.frame.size.width , height: 21 ))
        lblHeader.text = (dict[ktitle] as? String)! + " + " + (dict[kprice] as? String)!
        lblHeader.textColor = buttonColor
        lblHeader.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(lblHeader)
        
        let textfield = UITextField.init(frame: CGRect(x: 0,y: lblHeader.frame.size.height + lblHeader.frame.origin.y + 5 ,width:view.frame.size.width , height: 30 ))
        textfield.backgroundColor = UIColor.white
        textfield.tag = Int(dict[koption_id] as! String)! + 400
        textfield.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(textfield)
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.tag = Int(dict[koption_id] as! String)! + 400
        textfield.inputView = datePickerView
        datePickerView.addTarget(target, action: handler1!, for: UIControlEvents.valueChanged)
        view.frame = CGRect(x: view.frame.origin.x ,y: view.frame.origin.y ,width:view.frame.size.width , height: textfield.frame.size.height + textfield.frame.origin.y + 10)
        
        return view
    }
    
    func time(dict: [String: Any], view: UIView,target:AnyObject , selector:Selector) -> UIView
    {
        delegate1 = target
        handler1 = selector
        
        let lblHeader = UILabel.init(frame: CGRect(x: 0,y: view.frame.size.height  ,width:view.frame.size.width , height: 21 ))
        lblHeader.text = (dict[ktitle] as? String)! + " + " + (dict[kprice] as? String)!
        lblHeader.textColor = buttonColor
        lblHeader.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(lblHeader)
        
        let textfield = UITextField.init(frame: CGRect(x: 0,y: lblHeader.frame.size.height + lblHeader.frame.origin.y + 5 ,width:view.frame.size.width , height: 30 ))
        textfield.backgroundColor = UIColor.white
        textfield.tag = Int(dict[koption_id] as! String)! + 500
        textfield.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(textfield)
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.time
        datePickerView.tag = Int(dict[koption_id] as! String)! + 500
        textfield.inputView = datePickerView
        datePickerView.addTarget(target, action: handler1!, for: UIControlEvents.valueChanged)
        view.frame = CGRect(x: view.frame.origin.x ,y: view.frame.origin.y ,width:view.frame.size.width , height: textfield.frame.size.height + textfield.frame.origin.y + 10)
        
        return view
    }

    func dateTime(dict: [String: Any], view: UIView,target:AnyObject , selector:Selector) -> UIView
    {
        delegate1 = target
        handler1 = selector
        
        let lblHeader = UILabel.init(frame: CGRect(x: 0,y: view.frame.size.height  ,width:view.frame.size.width , height: 21 ))
        lblHeader.text = (dict[ktitle] as? String)! + " + " + (dict[kprice] as? String)!
        lblHeader.textColor = buttonColor
        lblHeader.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(lblHeader) 
        
        let textfield = UITextField.init(frame: CGRect(x: 0,y: lblHeader.frame.size.height + lblHeader.frame.origin.y + 5 ,width:view.frame.size.width , height: 30 ))
        textfield.backgroundColor = UIColor.white
        textfield.tag = Int(dict[koption_id] as! String)! + 600
        textfield.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(textfield)

        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        datePickerView.tag = Int(dict[koption_id] as! String)! + 600
        textfield.inputView = datePickerView
        datePickerView.addTarget(target, action: handler1!, for: UIControlEvents.valueChanged)
        view.frame = CGRect(x: view.frame.origin.x ,y: view.frame.origin.y ,width:view.frame.size.width , height: textfield.frame.size.height + textfield.frame.origin.y + 10)
        
        return view
    }

    
    func checkbox(dict: [String: Any], view: UIView,target:AnyObject , selector:Selector) -> UIView
    {
        delegate1 = target
        handler1 = selector
        
        print(dict)
        
        let lblHeader = UILabel.init(frame: CGRect(x: 0,y: view.frame.size.height  ,width:view.frame.size.width , height: 21 ))
        lblHeader.text = (dict[ktitle] as? String)! + " + " + (dict[kprice] as? String)!
        lblHeader.textColor = buttonColor
        lblHeader.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(lblHeader)
        
        let baseView = UIView.init(frame: CGRect(x: 0,y:  lblHeader.frame.size.height + lblHeader.frame.origin.y + 5  ,width:view.frame.size.width , height: CGFloat((dict[kadditional_fields] as! [AnyObject]).count)*34 ))
        baseView.backgroundColor = UIColor.white
        view.addSubview(baseView)
        
        var  y = 4
        for dictAdditionalFields in dict[kadditional_fields] as! [AnyObject]
        {
            let checkButton = UIButton.init(frame: CGRect(x: 5,y: y ,width:30 , height: 30 ))
            checkButton.setImage(#imageLiteral(resourceName: "Uncheck"), for: .normal)
            checkButton.tag = Int((dictAdditionalFields[koption_type_id] as? String)!)!
            checkButton.accessibilityLabel = (dictAdditionalFields[koption_id] as? String)!
            checkButton.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)
            checkButton.addTarget(target, action:handler1!, for: .touchUpInside)
            baseView.addSubview(checkButton)
            
            let checkLabel = UILabel.init(frame: CGRect(x: 40,y: y ,width:Int(baseView.frame.size.width-55) , height: 30 ))
            checkLabel.text = (dictAdditionalFields[kdefault_title] as? String)! + " + " + globalStrings.currencyIcon + " " + (dictAdditionalFields[kdefault_price] as? String)!
            checkLabel.font = UIFont.systemFont(ofSize: 12.0)
            checkLabel.textColor =  textColor
            baseView.addSubview(checkLabel)
            y = y + 34
        }
        view.frame = CGRect(x: view.frame.origin.x ,y: view.frame.origin.y ,width:view.frame.size.width , height: baseView.frame.size.height + baseView.frame.origin.y + 10)
        return view
    }
    
    func radio(dict: [String: Any], view: UIView,target:AnyObject , selector:Selector) -> UIView
    {
        delegate1 = target
        handler1 = selector
        
        let lblHeader = UILabel.init(frame: CGRect(x: 0,y: view.frame.size.height  ,width:view.frame.size.width , height: 21 ))
        lblHeader.text = (dict[ktitle] as? String)! + " + " + (dict[kprice] as? String)!
        lblHeader.textColor = buttonColor
        lblHeader.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(lblHeader)
        
        let baseView = UIView.init(frame: CGRect(x: 0,y:  lblHeader.frame.size.height + lblHeader.frame.origin.y + 5  ,width:view.frame.size.width , height: CGFloat((dict[kadditional_fields] as! [AnyObject]).count)*34 ))
        baseView.backgroundColor = UIColor.white
        view.addSubview(baseView)
        
        var  y = 4
        for dictAdditionalFields in dict[kadditional_fields] as! [AnyObject]
        {
            let radioButton = UIButton.init(frame: CGRect(x: 5,y: y ,width:30 , height: 30 ))
            radioButton.setImage(#imageLiteral(resourceName: "RadioButton"), for: .normal)
            radioButton.tag = Int((dictAdditionalFields[koption_type_id] as? String)!)!
            radioButton.accessibilityLabel = (dictAdditionalFields[koption_id] as? String)!
            radioButton.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)
            radioButton.addTarget(target, action:handler1!, for: .touchUpInside)
            baseView.addSubview(radioButton)
            
            let radioLabel = UILabel.init(frame: CGRect(x: 40,y: y ,width:Int(baseView.frame.size.width-55) , height: 30 ))
            radioLabel.text = (dictAdditionalFields[kdefault_title] as? String)! + " + " + globalStrings.currencyIcon + " " + (dictAdditionalFields[kdefault_price] as? String)!
            radioLabel.font = UIFont.systemFont(ofSize: 12.0)
            radioLabel.textColor =  textColor
            baseView.addSubview(radioLabel)
            y = y + 34
        }
        view.frame = CGRect(x: view.frame.origin.x ,y: view.frame.origin.y ,width:view.frame.size.width , height: baseView.frame.size.height + baseView.frame.origin.y + 10)
        return view
    }
    
    func textfields(dict: [String: Any], view: UIView,target:AnyObject) -> UIView
    {
        delegate1 = target
        
        let lblHeader = UILabel.init(frame: CGRect(x: 0,y: view.frame.size.height  ,width:view.frame.size.width , height: 21 ))
        lblHeader.text = (dict[ktitle] as? String)! + " + " + (dict[kprice] as? String)!
        lblHeader.textColor = buttonColor
        lblHeader.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(lblHeader)
        
        let textfield = UITextField.init(frame: CGRect(x: 0,y: lblHeader.frame.size.height + lblHeader.frame.origin.y + 5 ,width:view.frame.size.width , height: 30 ))
        textfield.backgroundColor = UIColor.white
        textfield.tag = Int((dict[koption_id] as? String)!)!
        textfield.font = UIFont.systemFont(ofSize: 12.0)
        textfield.delegate = delegate1 as! UITextFieldDelegate?
        view.addSubview(textfield)
        
        view.frame = CGRect(x: view.frame.origin.x ,y: view.frame.origin.y ,width:view.frame.size.width , height: textfield.frame.size.height + textfield.frame.origin.y + 10)
        
        return view
    }
    
    func textviews(dict: [String: Any], view: UIView,target:AnyObject) -> UIView
    {
        delegate1 = target
        let lblHeader = UILabel.init(frame: CGRect(x: 0,y: view.frame.size.height  ,width:view.frame.size.width , height: 21 ))
        lblHeader.text = (dict[ktitle] as? String)! + " + " + (dict[kprice] as? String)!
        lblHeader.textColor = buttonColor
        lblHeader.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(lblHeader)
        
        let textview = UITextView.init(frame: CGRect(x: 0,y: lblHeader.frame.size.height + lblHeader.frame.origin.y + 5 ,width:view.frame.size.width , height: 50 ))
        textview.backgroundColor = UIColor.white
        textview.tag = Int((dict[koption_id] as? String)!)!
        textview.delegate = delegate1 as! UITextViewDelegate?
        textview.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(textview)
        
        view.frame = CGRect(x: view.frame.origin.x ,y: view.frame.origin.y ,width:view.frame.size.width , height: textview.frame.size.height + textview.frame.origin.y + 10)
        
        return view
    }
    
    //Downloadle products ui
    func checkboxDownloadable(dict: [String: Any], view: UIView,target:AnyObject , selector:Selector) -> UIView
    {
        
        delegate1 = target
        handler1 = selector
        
        let lblHeader = UILabel.init(frame: CGRect(x: 0,y: view.frame.size.height  ,width:view.frame.size.width , height: 21 ))
        lblHeader.text = dict[ktitle] as? String
        lblHeader.textColor = buttonColor
        lblHeader.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(lblHeader)
        
        let baseView = UIView.init(frame: CGRect(x: 0,y:  lblHeader.frame.size.height + lblHeader.frame.origin.y + 0  ,width:view.frame.size.width , height: CGFloat((dict[krows] as! [AnyObject]).count)*34 ))
        baseView.backgroundColor = UIColor.white
        view.addSubview(baseView)
        
        var  y = 20
        for dictrows in dict[krows] as! [AnyObject]
        {
            let checkButton = UIButton.init(frame: CGRect(x: 5,y: y ,width:30 , height: 30 ))
            checkButton.setImage(#imageLiteral(resourceName: "Uncheck"), for: .normal)
            checkButton.tag = Int((dictrows[kid] as? String)!)!
            checkButton.accessibilityLabel = (dictrows[klink_price] as? String)!
            checkButton.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)
            checkButton.addTarget(target, action:handler1!, for: .touchUpInside)
            view.addSubview(checkButton)
            
            let checkLabel = UILabel.init(frame: CGRect(x: 40,y: y ,width:Int(baseView.frame.size.width-55) , height: 30 ))
            checkLabel.text = (dictrows[ktitle] as? String)! + " + " + globalStrings.currencyIcon + " " + (dictrows[klink_price] as? String)!
            checkLabel.font = UIFont.systemFont(ofSize: 12.0)
            checkLabel.textColor =  textColor
            view.addSubview(checkLabel)
            y = y + 44
        }
        view.frame = CGRect(x: view.frame.origin.x ,y: view.frame.origin.y ,width:view.frame.size.width , height: baseView.frame.size.height + baseView.frame.origin.y + 21)
        return view
    }
    
    
}

//MARK:- Bundle (dynamic views setup)
extension CustomOptionUI {
    
    //MARK: bundle select(drop down) button view
    func bundle_select_view(dict: [String: Any], view: UIView,target:AnyObject , selector:Selector, isFirstView: Bool, isLastView: Bool) -> UIView {
        
        delegate1 = target
        handler1 = selector
        
        let intial_Y = isFirstView ? 2 : view.frame.size.height + 5
        let lblTitle = UILabel.init(frame:CGRect(x: 0, y: intial_Y, width: view.frame.size.width, height: 15))
        lblTitle.text = (dict[ktitle] as? String)?.capitalized
        lblTitle.textColor = buttonColor
        lblTitle.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(lblTitle)
        
        let lblButton = UIButton.init(frame: CGRect(x: 0,y: lblTitle.frame.origin.y + 25 ,width:view.frame.size.width , height: 30 ))
        lblButton.setTitle("Choose a selection...", for: .normal)
        lblButton.backgroundColor = UIColor.white
        lblButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        lblButton.setTitleColor(buttonColor, for: .normal)
        lblButton.setImage(#imageLiteral(resourceName: "DownArrowGrey"), for: .normal)
        lblButton.addTarget(target, action:handler1!, for: .touchUpInside)
        lblButton.centerTextAndImage(spacing: view.frame.size.width/2)
        lblButton.tag = Int(dict[koption_id] as! String)!
        view.addSubview(lblButton)
        
        let lblTitleQuant = UILabel.init(frame:CGRect(x: 0, y: lblButton.frame.origin.y + lblButton.frame.size.height + 10, width: view.frame.size.width, height: 21))
        lblTitleQuant.text = "Quantity"
        lblTitleQuant.textColor = buttonColor
        lblTitleQuant.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(lblTitleQuant)
        
        let textfield = UITextField.init(frame: CGRect(x: 0,y: lblTitleQuant.frame.size.height + lblTitleQuant.frame.origin.y ,width: 50 , height: 30 ))
        textfield.backgroundColor = UIColor.white
        textfield.tag = Int(dict[koption_id] as! String)!
        textfield.font = UIFont.systemFont(ofSize: 12.0)
        textfield.textAlignment = NSTextAlignment.center
        textfield.delegate = delegate1 as? UITextFieldDelegate
        textfield.accessibilityLabel = "bundle"
        textfield.isUserInteractionEnabled = false
        textfield.keyboardType = .numberPad
        textfield.addDoneToolbar()
        view.addSubview(textfield)
        
        view.frame = CGRect(x: view.frame.origin.x ,y: view.frame.origin.y ,width:view.frame.size.width , height: textfield.frame.size.height + textfield.frame.origin.y + (isLastView ? 10 : 5))
        return view
    }
    
    //MARK: bundle checkbox buttons view
    func bundleCheckbox(dict: [String: Any], view: UIView,target:AnyObject , selector:Selector, isFirstView: Bool, isLastView: Bool) -> UIView {
        
        delegate1 = target
        handler1 = selector
        
        let intial_Y = isFirstView ? 2 : view.frame.size.height + 5
        let lblHeader = UILabel(frame: CGRect(x: 0,y: intial_Y  ,width:view.frame.size.width , height: 15 ))
        lblHeader.text = (dict[ktitle] as? String)!.capitalized
        lblHeader.textColor = buttonColor
        lblHeader.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(lblHeader)
        
        let baseView = UIView.init(frame: CGRect(x: 0,y:  lblHeader.frame.size.height + lblHeader.frame.origin.y + 5  ,width:view.frame.size.width , height: CGFloat((dict[kselections] as! [AnyObject]).count)*34 ))
        baseView.backgroundColor = UIColor.white
        view.addSubview(baseView)
        
        var  y = 4
        for dictAdditionalFields in dict[kselections] as! [AnyObject] {
            
            let checkButton = UIButton.init(frame: CGRect(x: 5,y: y ,width:30 , height: 30 ))
            checkButton.setImage(#imageLiteral(resourceName: "Uncheck"), for: .normal)
            checkButton.tag = Int((dictAdditionalFields[Kselection_id] as? String)!)!
            checkButton.accessibilityLabel = (dictAdditionalFields[koption_id] as? String)!
            checkButton.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)
            checkButton.addTarget(target, action:handler1!, for: .touchUpInside)
            baseView.addSubview(checkButton)
            
            let checkLabel = UILabel.init(frame: CGRect(x: 40,y: y ,width:Int(baseView.frame.size.width-55) , height: 30 ))
            
            let quantity = (dictAdditionalFields[Kselection_qty] as? String) ?? ""
            let name = (dictAdditionalFields[kname] as? String) ?? ""
            let currencyIcon = globalStrings.currencyIcon
            let price = (dictAdditionalFields["price"] as? String) ?? ""
            
            checkLabel.text = quantity + " x " + name + " + " + currencyIcon + " " + price
            checkLabel.font = UIFont.systemFont(ofSize: 12.0)
            
            checkLabel.textColor =  textColor
            baseView.addSubview(checkLabel)
            y = y + 34
        }
        
        view.frame = CGRect(x: view.frame.origin.x ,y: view.frame.origin.y ,width:view.frame.size.width , height: baseView.frame.size.height + baseView.frame.origin.y + (isLastView ? 10 : 5))
        return view
    }
    
    //MARK: bundle radio buttons view
    func bundle_radio(dict: [String: Any], view: UIView,target:AnyObject , selector:Selector, isFirstView: Bool, isLastView: Bool) -> UIView {
        
        delegate1 = target
        handler1 = selector
        
        let intial_Y = isFirstView ? 2 : view.frame.size.height + 5
        let lblHeader = UILabel.init(frame: CGRect(x: 0,y: intial_Y, width:view.frame.size.width , height: 15 ))
        lblHeader.text = (dict[ktitle] as? String)!.capitalized
        lblHeader.textColor = buttonColor
        lblHeader.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(lblHeader)
        
        let baseView = UIView.init(frame: CGRect(x: 0,y:  lblHeader.frame.size.height + lblHeader.frame.origin.y + 5  ,width:view.frame.size.width , height: CGFloat((dict[kselections] as! [AnyObject]).count)*34 ))
        baseView.backgroundColor = UIColor.white
        view.addSubview(baseView)
        
        var  y = 4
        for dictAdditionalFields in dict[kselections] as! [AnyObject] {
            
            let radioButton = UIButton.init(frame: CGRect(x: 5,y: y ,width:30 , height: 30 ))
            radioButton.setImage(#imageLiteral(resourceName: "RadioButton"), for: .normal)
            radioButton.tag = Int((dictAdditionalFields["product_id"] as? String)!)!
            radioButton.accessibilityLabel = (dictAdditionalFields[koption_id] as? String)!
            radioButton.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)
            radioButton.addTarget(target, action:handler1!, for: .touchUpInside)
            baseView.addSubview(radioButton)
            
            let radioLabel = UILabel.init(frame: CGRect(x: 40,y: y ,width:Int(baseView.frame.size.width-55) , height: 30 ))
            radioLabel.text = (dictAdditionalFields["name"] as? String)! + " + " + globalStrings.currencyIcon + " " + (dictAdditionalFields[kprice] as? String)!
            radioLabel.font = UIFont.systemFont(ofSize: 12.0)
            radioLabel.textColor =  textColor
            baseView.addSubview(radioLabel)
            y = y + 34
        }
        
        let lblTitleQuant = UILabel.init(frame:CGRect(x: 0, y: baseView.frame.size.height + baseView.frame.origin.y + 10 , width: view.frame.size.width, height: 21))
        lblTitleQuant.text = "Quantity"
        lblTitleQuant.textColor = buttonColor
        lblTitleQuant.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(lblTitleQuant)
        
        let textfield = UITextField.init(frame: CGRect(x: 0,y: lblTitleQuant.frame.size.height + lblTitleQuant.frame.origin.y ,width: 50 , height: 30 ))
        textfield.backgroundColor = UIColor.white
        textfield.tag = Int(dict[koption_id] as! String)!
        textfield.font = UIFont.systemFont(ofSize: 12.0)
        textfield.textAlignment = NSTextAlignment.center
        textfield.delegate = delegate1 as? UITextFieldDelegate
        textfield.accessibilityLabel = "bundle"
        textfield.isUserInteractionEnabled = false
        textfield.keyboardType = .numberPad
        textfield.addDoneToolbar()
        view.addSubview(textfield)
        
        view.frame = CGRect(x: view.frame.origin.x ,y: view.frame.origin.y ,width:view.frame.size.width , height: textfield.frame.origin.y + textfield.frame.size.height + (isLastView ? 10 : 5))
        return view
    }
}

//MARK:-
extension CustomOptionUI : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UITextField {
    
    func addDoneToolbar(onDone: (target: Any, action: Selector)? = nil, action: Selector? = nil) {
    
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    // Default actions:
    func doneButtonTapped() { self.resignFirstResponder() }
}
