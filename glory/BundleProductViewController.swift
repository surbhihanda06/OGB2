//
//  BundleProductViewController.swift
//  Chnen
//
//  Created by Surbhi Handa on 12/14/17.
//  Copyright © 2017 navjot_sharma. All rights reserved.
//

import UIKit
import DropDown
import Alamofire

extension String {
    func double() -> String {
        guard let price = Float(self) else { return ""}
        return String(format: "%.2f", price)
    }
}

class BundleProductViewController: UIViewController,UIScrollViewDelegate,UIWebViewDelegate,UITextViewDelegate,UITextFieldDelegate
    
{
    @IBOutlet var BundleOptionView: UIView!
    
    @IBOutlet var BundleView: UIView!
    @IBOutlet weak var imageToZoom: UIImageView!
    @IBOutlet weak var PageControl: UIPageControl!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var ImageScrollView: UIScrollView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnWishlist: UIButton!
    @IBOutlet weak var DetailView: UIView!
    @IBOutlet weak var InfoAndCareView: UIView!
    @IBOutlet weak var InfoCareView: UIView!
    @IBOutlet weak var detailWebView: UIWebView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ConstraintWebViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ConstraintInfoCareWebViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ContraintViewHeight: NSLayoutConstraint!
    @IBOutlet var viewCustomOptions: UIView!
    @IBOutlet weak var ConstraintDetailViewY: NSLayoutConstraint!
    @IBOutlet weak var OptionsView: UIView!
    @IBOutlet weak var ConstraintOptionsViewHeight: NSLayoutConstraint!
    @IBOutlet var ConstraintInfoViewTop: NSLayoutConstraint!
    
    @IBOutlet var ConstraintBundleOptionViewHeight: NSLayoutConstraint!
    @IBOutlet var cartCountLbl: UILabel!
    @IBOutlet var inStokeLbl: UILabel!
    // Variables
    
    var strProd_id  = String()
    var strImgUrl  = String()
    var strProd_name  = String()
    var strProd_price  = String()
    var  wishlist_item_id = String()
    var arrImages = [[String: Any]]()
    var visualization_type = String()
    var mediaUrl = String()
    var arrAttributes = [[String: Any]]()
    let dropDown = DropDown()
    var arrCustomOptions = [[String: Any]]()
    var arrBundleOptions = [[String: Any]]()
    var arrOptions = [String: Any]()
    var arrBundle = [String: Any]()
    var arrCheckbox : [[String: String]] = [[:]]
    var strPrice = String()
    var objResponse = Product()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        PageControl.currentPageIndicatorTintColor = buttonColor
        imageToZoom .sd_setImage(with: URL(string:  strImgUrl ), placeholderImage: UIImage(named: ""))
        lblProductName.text = strProd_name
        lblPrice.text = (globalStrings.currencyIcon +  strProd_price).double()
        lblProductType.text = strProd_name
        
         // quote count lbl
        if Int(globalStrings.Quote_count) > 0
        {
            cartCountLbl.text   = String(globalStrings.Quote_count)
        }
        else
        {
            cartCountLbl.isHidden = true
        }
        
        
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async
            {
                // Background thread
                self.ProductdetailApi()
                
                DispatchQueue.main.async(execute: {
                    self.PageControl.currentPage = 0
                    self.scrollView.isScrollEnabled = false
                    self.activity.startAnimating()
                    self.DetailView.isHidden = true
                })
        }
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector:  #selector(deviceDidRotate(notification:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        // Do any additional setup after loading the view.
    }
    
    func deviceDidRotate(notification: NSNotification) {
        print(viewCustomOptions)
        if self.viewCustomOptions != nil {
            for bview in viewCustomOptions.subviews   {
                bview.frame.size.width = viewCustomOptions.frame.size.width
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- Product detail Api methods
    func ProductdetailApi()
    {
        let parameters = [ksalt: SALT , PROD_ID : strProd_id, VISITOR_ID : globalStrings.Visitor_id , CUST_ID : globalStrings.Cust_id , kcstore: one]
        let objProduct = Product()
        objProduct.ProductDetailApi(dict: parameters , target: self, selector: #selector(self.ProductdetailResponse))
    }
    
    func ProductdetailResponse(obj: Product)
    {
        if obj.resultText == ksuccess
        {
            objResponse = obj
            arrImages = obj.images
            PageControl.numberOfPages = arrImages.count
            
            
            if obj.inStock == 1
            {
                inStokeLbl.isHidden = false
                inStokeLbl.text = "In Stock"
            }
            else
            {
                inStokeLbl.isHidden = true
            }
            
            if obj.inWishlist == ""
            {
                btnWishlist.setImage(#imageLiteral(resourceName: "wishDetail"), for: .normal)
            }
            else
            {
                btnWishlist.setImage( #imageLiteral(resourceName: "wishDetailSelected"), for: .normal)
            }
            
            
            if arrImages.count != 0
            {
                imageToZoom.sd_setShowActivityIndicatorView(true)
                imageToZoom.sd_setIndicatorStyle(.gray)
                imageToZoom.sd_setImage(with: URL(string: arrImages[0][kurl] as! String))
            }
            lblProductName.text = obj.name
            print(obj.name)
            strPrice = obj.finalPrice
            lblPrice.text = globalStrings.currencyIcon +  obj.finalPrice
            print(lblPrice.text ?? "")
            
            lblProductType.text = obj.name
            let desc_html = obj.isDescHtml
            let strdetail = obj.strDescription.base64Decoded()
            if desc_html
            {
                detailWebView.loadHTMLString(strdetail!, baseURL: nil)
                detailWebView.isHidden = false
                detailTextView.isHidden = true
            }
            else
            {
                detailWebView.isHidden = true
                detailTextView.isHidden = false
                detailTextView.text = strdetail?.html2String
                let sizeHeight =  globalStrings.getTextHeight(textView: detailTextView)
                ConstraintWebViewHeight.constant = sizeHeight + 30
                ContraintViewHeight.constant = ContraintViewHeight.constant +  ConstraintWebViewHeight.constant  - 60
            }
            DetailView.isHidden = false
            scrollView.isScrollEnabled = true
            
            // MARK:- Bundle options View
            if obj.bundle_Values.count != 0
            {
                arrBundleOptions = obj.bundle_Values
                //print(arrBundleOptions)
                OptionsView.isHidden = false
                //print(arrBundleOptions)
                var firstCount = 1
                for i  in arrBundleOptions
                {
                    //print(i[ktype])
                    //print(BundleView.frame)
                    switch i[ktype] as! String
                    {
                    case bundle_select:
                        BundleView = CustomOptionUI.sharedInstance().bundle_select_view(dict: i , view: BundleView ,target: self ,selector : #selector(self.BundleDropDownMethod), isFirstView: firstCount == 1, isLastView: firstCount == arrBundleOptions.count)
                        break
                    case radio:
                        BundleView = CustomOptionUI.sharedInstance().bundle_radio(dict: i , view: BundleView ,target: self ,selector : #selector(self.BundleRadioMethod), isFirstView: firstCount == 1, isLastView: firstCount == arrBundleOptions.count)
                        break
                    case checkbox:
                        BundleView = CustomOptionUI.sharedInstance().bundleCheckbox(dict: i , view: BundleView ,target: self ,selector : #selector(self.BundleCheckboxMethod), isFirstView: firstCount == 1, isLastView: firstCount == arrBundleOptions.count)
                        break
                    default:
                        print( i[ktype] as! String)
                    }
                    
                    firstCount += 1
                }
                
                ConstraintBundleOptionViewHeight.constant = BundleView.frame.size.height+BundleView.frame.origin.y
            }
            else
            {
                BundleOptionView.isHidden = true
                ConstraintBundleOptionViewHeight.constant = 0
                ConstraintInfoViewTop.constant = 0
            }
            
            // MARK:- custom options view
            if obj.options.count != 0
            {
                arrCustomOptions = obj.options
                OptionsView.isHidden = false
                
            
                for i  in arrCustomOptions
                {
                    switch i[ktype] as! String
                    {
                        
                    case drop_down:
                        viewCustomOptions = CustomOptionUI.sharedInstance().dropdowns(dict: i , view: viewCustomOptions ,target: self ,selector : #selector(self.DropDownMethod))
                        break
                    case checkbox:
                        viewCustomOptions = CustomOptionUI.sharedInstance().checkbox(dict: i , view: viewCustomOptions ,target: self ,selector : #selector(self.MultipleMethod))
                        break
                    case date:
                        viewCustomOptions = CustomOptionUI.sharedInstance().dates(dict: i , view: viewCustomOptions ,target: self ,selector : #selector(self.DateMethod))
                        break
                    case date_time:
                        viewCustomOptions = CustomOptionUI.sharedInstance().dateTime(dict: i , view: viewCustomOptions ,target: self ,selector : #selector(self.DateTimeMethod))
                        break
                    case multiple:
                        viewCustomOptions = CustomOptionUI.sharedInstance().checkbox(dict: i , view: viewCustomOptions ,target: self ,selector : #selector(self.MultipleMethod))
                        break
                    case radio:
                        viewCustomOptions = CustomOptionUI.sharedInstance().radio(dict: i , view: viewCustomOptions ,target: self ,selector : #selector(self.RadioMethod))
                        break
                    case area:
                        viewCustomOptions = CustomOptionUI.sharedInstance().textviews(dict: i , view: viewCustomOptions ,target: self )
                        break
                    case field:
                        viewCustomOptions = CustomOptionUI.sharedInstance().textfields(dict: i , view: viewCustomOptions ,target: self)
                        break
                    case time:
                        viewCustomOptions = CustomOptionUI.sharedInstance().time(dict: i , view: viewCustomOptions ,target: self ,selector : #selector(self.TimeMethod))
                        break

                    default:
                        print( i[ktype] as! String)
                    }
                }
                ConstraintOptionsViewHeight.constant = viewCustomOptions.frame.size.height+viewCustomOptions.frame.origin.y
                ContraintViewHeight.constant = viewCustomOptions.frame.size.height+ContraintViewHeight.constant
            }
            else
            {
                OptionsView.isHidden = true
                ConstraintOptionsViewHeight.constant = 0
                ConstraintInfoViewTop.constant = 0
            }
            
            let strSpecification = obj.specification
            var yChange = 3.0
            for i  in strSpecification
            {
                let lblCode = UILabel(frame: CGRect(x: 8 , y: yChange ,width : 264 , height: 18))
                lblCode.text = (i[kcode] as? String)?.uppercased()
                lblCode.textAlignment = .left
                lblCode.font = lblCode.font.withSize(12.0)
                lblCode.textColor =  textColor
                InfoCareView.addSubview(lblCode)
                yChange += 21
                
                let lblValue = UILabel(frame: CGRect(x: 8 , y: yChange ,width : 264 , height: 18))
                lblValue.text = i[kvalue] as? String
                lblValue.textAlignment = .left
                lblValue.textColor =  textColor
                lblValue.font = UIFont.boldSystemFont(ofSize: 12.0)
                InfoCareView.addSubview(lblValue)
                
                yChange += 21
            }
            ConstraintInfoCareWebViewHeight.constant =  CGFloat( yChange + 37.0)
            ContraintViewHeight.constant = ContraintViewHeight.constant +  ConstraintInfoCareWebViewHeight.constant - 60
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activity.stopAnimating()
        activity.isHidden = true
    }
    
    // MARK:-  AddProductToWishlist  Api methods
    
    func AddProductToWishlist(productId : String)
    {
        let  parameters : Parameters = [ksalt: SALT as AnyObject , PROD_ID : productId as AnyObject , CUST_ID: globalStrings.Cust_id as AnyObject, QTY: "1" as AnyObject , kcstore: one as AnyObject ]
        let objProduct = Product()
        objProduct.AddWishlistApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.AddProductToWishlistResponse))
    }
    
    func AddProductToWishlistResponse(obj : Product)
    {
        if obj.resultText == ksuccess
        {
            btnWishlist.setImage( #imageLiteral(resourceName: "wishDetailSelected"), for: .normal)
            wishlist_item_id = obj.wishlist_item_id
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    // MARK:-  AddProductToWishlist  Api methods
    
    func RemoveProductWishlist(wishlistId : String)
    {
        let  parameters : Parameters = [ksalt: SALT as AnyObject , WISHLIST_ITEM_ID : wishlistId as AnyObject , CUST_ID: globalStrings.Cust_id as AnyObject,  kcstore: one as AnyObject ]
        let objProduct = Product()
        objProduct.RemoveWishlistApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.RemoveProductWishlistResponse))
    }
    
    func RemoveProductWishlistResponse(obj : Product)
    {
        if obj.resultText == ksuccess
        {
            btnWishlist.setImage(#imageLiteral(resourceName: "wishDetail"), for: .normal)
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    // MARK:-  Zoom Image Methods
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return imageToZoom
    }
    
    // MARK:-  Touch Gesture Methods
    
    @IBAction func onDoubleTap(_ sender: UITapGestureRecognizer)
    {
        let scale = min(ImageScrollView.zoomScale * 2 , ImageScrollView.maximumZoomScale)
        
        if scale != ImageScrollView.zoomScale
        {
            ImageScrollView.setZoomScale(ImageScrollView.maximumZoomScale, animated: true)
        }
        else
        {
            ImageScrollView.setZoomScale(ImageScrollView.minimumZoomScale, animated: true)
        }
    }
    
    @IBAction func SwipeRight(_ sender: UISwipeGestureRecognizer)
    {
        print("SwipeRight")
        let p = PageControl.currentPage
        if (p>0)
        {
            if (arrImages[p-1][kurl] as! String) != ""
            {
                imageToZoom .sd_setImage(with: URL(string:  arrImages[p-1][kurl] as! String ), placeholderImage: UIImage(named: ""))
            }
            PageControl.currentPage = p-1
        }
        
    }
    
    @IBAction func SwipeLeft(_ sender: UISwipeGestureRecognizer)
    {
        print("SwipeLeft")
        let p = PageControl.currentPage
        if p < arrImages.count-1
        {
            if (arrImages[p+1][kurl] as! String) != ""
            {
                imageToZoom .sd_setImage(with: URL(string:  arrImages[p+1][kurl] as! String ), placeholderImage: UIImage(named: ""))
            }
            PageControl.currentPage = p+1
        }
    }
    
    
    @IBAction func cartBtn(_ sender: Any)
    {
        let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        tabBarController.selectedIndex = 2
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController
    }
    
    
    // MARK:-  Wishlist Button Methods
    
    @IBAction func WishlistButton(_ sender: UIButton)
    {
        if defaults.bool(forKey: dis_login)
        {
            let image1 = sender.imageView?.image
            let image2 = #imageLiteral(resourceName: "wishDetail")
            if (image1?.isEqualToImage(image: image2))!
            {
                //image change pending
                activityIndicator.startAnimating(activityData)
                AddProductToWishlist(productId: objResponse.id )
            }
            else
            {
                activityIndicator.stopAnimating()
                RemoveProductWishlist(wishlistId: wishlist_item_id )
            }
        }
        else
        {
            let cancelAction = UIAlertAction(title: Ok,
                                             style: .default, handler: toLogin)
            globalStrings.showALertAction(message: NotLoggedInWishlist, target: self, actions: cancelAction)
        }
    }
    
    func toLogin(action: UIAlertAction){
        let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        tabBarController.selectedIndex = 4
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController
    }
    
    // MARK:-  Share Button Methods
    
    @IBAction func ShareButton(_ sender: AnyObject)
    {
        let message = "Message goes here."
        if let link = NSURL(string: objResponse.product_url)
        {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    // MARK:-  Close Button Methods
    
    @IBAction func CloseButton(_ sender: AnyObject)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK:-  WebView Delegate Methods
    
    func webViewDidStartLoad(_ webView: UIWebView)
    {
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
    {
        
    }
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        webView.frame.size.height = 1
        webView.frame.size = webView.sizeThatFits(CGSize.zero)
        ConstraintWebViewHeight.constant = webView.frame.size.height + 37
        ContraintViewHeight.constant = ContraintViewHeight.constant +  ConstraintWebViewHeight.constant  - 60
    }
    // MARK:-  AddToBag Button Methods
    @IBAction func AddToBagButton(_ sender: AnyObject)
    {
        if defaults.bool(forKey: dis_login)
        {
          //  print(arrBundleOptions)
         //   print(arrBundle)
            
            let calendar = NSCalendar.current
            let dateFormatter = DateFormatter()
            var parameters = [ksalt: SALT , PROD_ID : strProd_id , VISITOR_ID : globalStrings.Visitor_id, CUST_ID : globalStrings.Cust_id , QUOTE_ID: globalStrings.Quote_id , SKU: objResponse.sku, kcstore: one] as [String : Any]
            
            for i in arrOptions
            {
                if let d : [String: Any] = i.value as? [String: Any] {
                    if d["type"] as! String == date_time
                    {
                        let arr = (d["typeId"] as! String).components(separatedBy: " ")
                        dateFormatter.dateFormat = "d-MM-yyyy hh:mm aa"
                        let date = dateFormatter.date(from: d["typeId"] as! String)
                        parameters["options[" + (i.key) + "][year]"] = calendar.component(.year, from: date!)
                        parameters["options[" + (i.key) + "][month]"] = calendar.component(.month, from: date!)
                        parameters["options[" + (i.key) + "][day]"] = calendar.component(.day, from: date!)
                        parameters["options[" + (i.key) + "][hour]"] = calendar.component(.hour, from: date!)
                        parameters["options[" + (i.key) + "][minute]"] = calendar.component(.minute, from: date!)
                        parameters["options[" + (i.key) + "][day_part]"] = arr[2]
                    }
                    else  if d["type"] as! String == date
                    {
                        dateFormatter.dateFormat = "d-MM-yyyy"
                        let date = dateFormatter.date(from: d["typeId"] as! String)
                        parameters["options[" + (i.key) + "][year]"] = calendar.component(.year, from: date!)
                        parameters["options[" + (i.key) + "][month]"] = calendar.component(.month, from: date!)
                        parameters["options[" + (i.key) + "][day]"] = calendar.component(.day, from: date!)
                    }
                    else if d["type"] as! String == time
                    {
                        let arr = (d["typeId"] as! String).components(separatedBy: " ")
                        dateFormatter.dateFormat = "hh:mm aa"
                        let date = dateFormatter.date(from: d["typeId"] as! String)
                        parameters["options[" + (i.key) + "][hour]"] = calendar.component(.hour, from: date!)
                        parameters["options[" + (i.key) + "][minute]"] = calendar.component(.minute, from: date!)
                        parameters["options[" + (i.key) + "][day_part]"] = arr[1]
                    }
                    else
                    {
                        parameters["options[" + (i.key) + "]"] = d["typeId"]
                    }
                }
                else
                {
                    var count = 0
                    for j in i.value as! [[String: Any]]
                    {
                        parameters["options[" + (i.key) + "][" + String(count) + "]"] = j["typeId"]
                        count += 1
                    }
                }
            }
            
            print(arrBundleOptions)
            let _ = arrBundle.map { key, value in
                print(value)
                if let dict = value as? [String:Any] {
                    guard let type = dict["type"] as? String else { return }
                    print(type)
                    switch type {
                    case bundle_select,radio,drop_down:
                        parameters["bundle_option[\(key)]"] = dict["typeId"]
                        parameters["bundle_option_qty[\(key)]"] = dict["qty"]
                        break
                    case checkbox,multiple:
                        parameters["bundle_option[\(key)][]"] = dict["typeId"]
                        break
                    default:
                        break
                    }
                }
                if let arr = value as? [[String:Any]] {
                    let _ = arr.map {
                        guard let type = $0["type"] as? String else { return }
                        print(type)
                        switch type {
                        case bundle_select,radio,drop_down:
                            parameters["bundle_option[\(key)]"] = $0["typeId"]
                            parameters["bundle_option_qty[\(key)]"] = $0["qty"]
                            break
                        case checkbox,multiple:
                            parameters["bundle_option[\(key)][\($0[kproduct_id]!)]"] = $0["typeId"]
                            break
                        default:
                            break
                        }
                    }
                }
            }
            print(parameters)
            activityIndicator.startAnimating(activityData)
            let objProduct = Product()
            objProduct.AddtoCartApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.AddtoCartResponse))
        }
        else
        {
            let alertController = UIAlertController(title: "", message: NotLoggedInBag, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            {
                UIAlertAction in
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sGuestUserViewController) as? GuestUserViewController
                {
                    self.present(vc, animated: true, completion: nil)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
            {
                UIAlertAction in
                NSLog("Cancel Pressed")
                
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    func AddtoCartResponse(obj: Product)
    {
        activityIndicator.stopAnimating()
        
        if globalStrings.Quote_count > 0 {
            let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
            let tabArray = tabBarController.tabBar.items as NSArray!
            let chatItem = tabArray?.object(at: 2) as! UITabBarItem
            if #available(iOS 10.0, *) {
                chatItem.badgeColor = buttonColor
            } else {}
            chatItem.badgeValue = String(globalStrings.Quote_count)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = tabBarController
            globalStrings.showALert(message: obj.message, target: self)
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    // MARK:-  CustomOptions Button Methods
    
    func setupDefaultDropDown()
    {
        DropDown.setupDefaultAppearance()
        dropDown.cellNib = UINib(nibName: "DropDownCell", bundle: Bundle(for: DropDownCell.self))
        dropDown.customCellConfiguration = nil
    }
    
    
    func DropDownMethod(sender: UIButton)
    {
        setupDefaultDropDown()
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        
        var arr = [String]()
        var arrDropDown = [[String: Any]]()
        for j in  commonFunctions.arrAdditionalFields(arrMain: arrCustomOptions, id: String(sender.tag))
        {
            arr.append(String(j[ktitle] as! String) + " + " + String(j[kCurrencySymbol] as! String) + String(j[kprice] as! String))
            arrDropDown.append(j)
        }
        dropDown.dataSource = arr
        
        dropDown.show()
        dropDown.selectionAction =  {(index: Int, item: String) in
            sender.setTitle(item, for: .normal)
        self.arrOptions[String(sender.tag)] = commonFunctions.createDictionary(id: String(sender.tag), typeId: (arrDropDown[index][koption_type_id] as! String?)!, price: (arrDropDown[index][kprice] as! String?)!, type: drop_down)
            self.calculatePrice()
        }
    }
    
    
    
    func DateMethod(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d-MM-yyyy"
        print (self.view.viewWithTag(sender.tag)! )
        let textfield = self.view.viewWithTag(sender.tag) as? UITextField
        textfield?.text = dateFormatter.string(from: sender.date)
        let dictDate = commonFunctions.dictOptions(arrMain: arrCustomOptions, id: String(sender.tag - 400))
        self.arrOptions[String(sender.tag - 400)] = commonFunctions.createDictionary(id: String(sender.tag - 400), typeId: (textfield?.text)!, price: dictDate[kprice] as! String, type: date)
        print (dateFormatter.string(from: sender.date))
        calculatePrice()
    }
    
    func TimeMethod(sender:UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm aa"
        let textfield = self.view.viewWithTag(sender.tag) as? UITextField
        textfield?.text = dateFormatter.string(from: sender.date)
        let dictDate = commonFunctions.dictOptions(arrMain: arrCustomOptions, id: String(sender.tag - 500))
        self.arrOptions[String(sender.tag - 500)] = commonFunctions.createDictionary(id: String(sender.tag - 500), typeId: (textfield?.text)!, price: dictDate[kprice] as! String, type: time)
        print (dateFormatter.string(from: sender.date))
        calculatePrice()
    }
    
    func DateTimeMethod(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d-MM-yyyy hh:mm aa"
        let textfield = self.view.viewWithTag(sender.tag) as? UITextField
        textfield?.text = dateFormatter.string(from: sender.date)
        let dictDate = commonFunctions.dictOptions(arrMain: arrCustomOptions, id: String(sender.tag - 600))
        self.arrOptions[String(sender.tag - 600)] = commonFunctions.createDictionary(id: String(sender.tag - 600), typeId: (textfield?.text)!, price: dictDate[kprice] as! String, type: date_time)
        print (dateFormatter.string(from: sender.date))
        calculatePrice()
    }
    
    func MultipleMethod(sender: UIButton)
    {
        var dict = [String: String]()
        for j in  commonFunctions.arrAdditionalFields(arrMain: arrCustomOptions, id:  sender.accessibilityLabel!)  {
            if j[koption_type_id] as! String == String(sender.tag) {
                dict =  commonFunctions.createDictionary(id: sender.accessibilityLabel!, typeId: String(sender.tag), price: j[kprice] as! String, type: multiple )
            }
        }
        if self.arrOptions[sender.accessibilityLabel!] as? [[String: String]] != nil {
            arrCheckbox = self.arrOptions[sender.accessibilityLabel!] as! [[String : String]]
            print(arrCheckbox)
        } else {
            arrCheckbox.removeAll()
        }
        if sender.currentImage == #imageLiteral(resourceName: "Uncheck") {
            sender.setImage(#imageLiteral(resourceName: "Check"), for: .normal)
            arrCheckbox.append(dict)
            self.arrOptions[sender.accessibilityLabel!] = arrCheckbox as [[String : String]]
        } else {
            sender.setImage(#imageLiteral(resourceName: "Uncheck"), for: .normal)
            if  arrCheckbox.contains(where: { (dict) -> Bool in
                arrCheckbox.remove(at: arrCheckbox.index(where: { (dict) -> Bool in
                    return true })!)
                self.arrOptions[sender.accessibilityLabel!] = arrCheckbox as [[String : String]]
                return true }){
            }
        }
        calculatePrice()
    }
    
    
    
    
    func RadioMethod(sender: UIButton)
    {
        var dict = [String: String]()
        for j in  commonFunctions.arrAdditionalFields(arrMain: arrCustomOptions, id:  sender.accessibilityLabel!)  {
            if j[koption_type_id] as! String == String(sender.tag) && sender.currentImage == #imageLiteral(resourceName: "RadioButton") {
                dict =  commonFunctions.createDictionary(id: sender.accessibilityLabel!, typeId: String(sender.tag), price: j[kprice] as! String , type: radio)
                sender.setImage(#imageLiteral(resourceName: "RadioButtonSelected"), for: .normal)
                self.arrOptions[sender.accessibilityLabel!] = dict
            }else {
                print(j[koption_type_id] as! String)
                let button = self.view.viewWithTag(Int(j[koption_type_id] as! String)!) as? UIButton
                button?.setImage(#imageLiteral(resourceName: "RadioButton"), for: .normal)
            }
        }
        calculatePrice()
    }
    
    
    
    
    //MARK:- Textfield Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.accessibilityLabel == "bundle" {
            if let text = textField.text,
                let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange,
                                                           with: string)
                return updatedText.count < 3
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.accessibilityLabel == "bundle" {
            if var dict : [String:Any] = arrBundle[String(textField.tag)] as? [String : Any] {
                    if !(textField.text?.isEmpty)! {
                        dict[kqty] = textField.text!
                        arrBundle[String(textField.tag)] = dict
                        calculatePrice()
                    }
            }
        }
        else {
            if !(textField.text?.isEmpty())! {
                let dict = commonFunctions.dictOptions(arrMain: arrCustomOptions, id: String(textField.tag))
                self.arrOptions[String(textField.tag)] = commonFunctions.createDictionary(id: String(textField.tag), typeId: (textField.text)!, price: dict[kprice] as! String, type: field)
            } else {
                self.arrOptions.removeValue(forKey:String(textField.tag))
            }
            calculatePrice()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if !(textView.text?.isEmpty())! {
            let dict = commonFunctions.dictOptions(arrMain: arrCustomOptions, id: String(textView.tag))
            self.arrOptions[String(textView.tag)] = commonFunctions.createDictionary(id: String(textView.tag), typeId: (textView.text)!, price: dict[kprice] as! String, type: area)
        } else {
            self.arrOptions.removeValue(forKey: String(textView.tag))
        }
        calculatePrice()
    }
    
    //Mark:- Calculate Price
    func calculatePrice ()
    {
        var total : Float = strPrice == "" ? 0.00 : Float(strPrice)!
        
        for i in arrOptions
        {
            if let d : [String: Any] = i.value as? [String: Any] {
                if (d["price"] as? String) != "0.00"
                {
                    total =  total + Float(d["price"] as! String )!
                }
            }
            else
            {
                for j in i.value as! [[String: Any]]
                {
                    if (j["price"] as? String) != "0.00" {
                        total =   total + Float(j["price"] as! String )!
                    }
                }
            }
        }
        
        // add bundle view total
        let _ = arrBundle.mapValues {
        
            if let dict = $0 as? [String:Any] {
                guard let price = dict[kprice] as? String,let qty = dict[kqty] as? String
                    else { return }
                guard let floatPrice = Float(price), let floatQty = Float(qty)
                    else { return }
                print(floatPrice)
                print(floatQty)
                total += (floatPrice*floatQty)
            }
            if let arr = $0 as? [[String:Any]] {
                let _ = arr.map({
                    guard let price = $0["price"] as? String,let qty = $0[kqty] as? String
                        else { return }
                    guard let floatPrice = Float(price), let floatQty = Float(qty)
                        else { return }
                    total += (floatPrice*floatQty)
                })
            }
        }
        
        lblPrice.text = String(format: "\(globalStrings.currencyIcon)%.2f", total)
        //print(lblPrice.text ?? "")
    }
}

// MARK:- Bundle View Actions
extension BundleProductViewController {
    
    // bundle drop down
    func BundleDropDownMethod(sender: UIButton) {
        
        setupDefaultDropDown()
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        
        var arr = [String]()
        var arrDropDown = [[String: Any]]()
        
        for j in  commonFunctions.arrSelectionFields(arrMain: arrBundleOptions, id: String(sender.tag))
        {
            arr.append(String(j[kname] as! String) + " + " + String(j[kprice] as! String))
            arrDropDown.append(j)
        }
        
        dropDown.dataSource = arr
        dropDown.show()
        dropDown.selectionAction = {(index: Int, item: String) in
            
            sender.setTitle(item, for: .normal)
            sender.titleLabel?.sizeToFit()
            
            self.arrBundle[String(sender.tag)] = commonFunctions.createDictionary(id: String(sender.tag), typeId: (arrDropDown[index][Kselection_id] as! String?)!, price: (arrDropDown[index][kprice] as! String?)!, type: drop_down, qty: (arrDropDown[index][Kselection_qty] as! String))
            self.calculatePrice()
            for view in self.BundleView.subviews {
                if let textField = view as? UITextField, view.tag == sender.tag {
                    textField.text = arrDropDown[index]["selection_qty"] as? String
                    guard let value = arrDropDown[index]["selection_can_change_qty"] as? String, let canChangeQty = Int(value)
                        else { return }
                    textField.isUserInteractionEnabled = canChangeQty == 1
                }
            }
        }
    }
    
    // bundle radio
    func BundleRadioMethod(sender: UIButton) {
        
        var dict = [String: String]()
        for j in  commonFunctions.arrSelectionFields(arrMain: arrBundleOptions, id:  sender.accessibilityLabel!)  {
            if j[kproduct_id] as! String == String(sender.tag) && sender.currentImage == #imageLiteral(resourceName: "RadioButton") {
                dict =  commonFunctions.createDictionary(id: sender.accessibilityLabel!, typeId: j[Kselection_id] as! String, price: j[kprice] as! String , type: radio, qty: "1")
                sender.setImage(#imageLiteral(resourceName: "RadioButtonSelected"), for: .normal)
                
                dict[kqty] = String(describing: j["selection_qty"]!)
                self.arrBundle[sender.accessibilityLabel!] = dict
                self.calculatePrice()
                
                for view in self.BundleView.subviews {
                    
                    if let textField = view as? UITextField,Int(sender.accessibilityLabel!)! == view.tag {
                        textField.text = j["selection_qty"] as? String
                        guard let value = j["selection_can_change_qty"] as? String, let canChangeQty = Int(value)
                            else { return }
                        textField.isUserInteractionEnabled = canChangeQty == 1
                    }
                }
            }
            else {
                let button = self.view.viewWithTag(Int(j[kproduct_id] as! String)!) as? UIButton
                button?.setImage(#imageLiteral(resourceName: "RadioButton"), for: .normal)
            }
        }
    }
    
    // bundle check box
    func BundleCheckboxMethod(sender: UIButton) {
        
        var dict : [String: String] = [:]
        let _ = arrBundleOptions.map {
            guard let optionId = $0[koption_id] as? String else { return }
            if optionId ==  sender.accessibilityLabel! {
                guard let selections = $0[kselections] as? [[String:Any]] else { return }
                let _ = selections.map({
                    if $0[Kselection_id] as! String == String(sender.tag) {
                        dict =  commonFunctions.createDictionary(id: sender.accessibilityLabel!, typeId: String(sender.tag), price: $0[kprice] as! String, type: multiple )
                        dict[kqty] = String(describing: $0[Kselection_qty]!)
                        dict["product_id"] = String(describing: $0[kproduct_id]!)
                    }
                })
            }
        }
        
        if self.arrBundle[sender.accessibilityLabel!] as? [[String: String]] != nil {
            arrCheckbox = self.arrBundle[sender.accessibilityLabel!] as! [[String : String]]
        } else {
            arrCheckbox.removeAll()
        }
        
        if sender.currentImage == #imageLiteral(resourceName: "Uncheck") {
            sender.setImage(#imageLiteral(resourceName: "Check"), for: .normal)
            arrCheckbox.append(dict)
        }
        else {
            sender.setImage(#imageLiteral(resourceName: "Uncheck"), for: .normal)
            
            let index = arrCheckbox.index(where: { (param) -> Bool in
                return param["product_id"] == dict["product_id"]
            })
            if let _ = index {
               arrCheckbox.remove(at: index!)
            }
            
            /*if let index = arrCheckbox.index(of: dict) {
                arrCheckbox.remove(at: index)
            }*/
        }
        
        self.arrBundle[sender.accessibilityLabel!] = arrCheckbox as [[String : String]]
        
        calculatePrice()
    }
}
