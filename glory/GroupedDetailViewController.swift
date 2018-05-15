//
//  GroupedDetailViewController.swift
//  Chnen
//
//  Created by user on 2/12/18.
//  Copyright © 2018 navjot_sharma. All rights reserved.
//


import UIKit
import DropDown
import Alamofire


class GroupedDetailViewController: UIViewController,UIScrollViewDelegate,UIWebViewDelegate,UITextViewDelegate,UITextFieldDelegate
    
{
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
    @IBOutlet weak var ConstraintInfoCareWebViewHeight:NSLayoutConstraint!
    @IBOutlet weak var ContraintViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ConstraintDetailViewY: NSLayoutConstraint!
    @IBOutlet var GroupedOption: UIView!
    @IBOutlet var GroupedOptionView: UIView!
    @IBOutlet var inStokeLbl: UILabel!
    @IBOutlet weak var groupedTableView: UITableView!
    @IBOutlet weak var ConstraintGroupedViewHeight: NSLayoutConstraint!
    @IBOutlet var ConstraintInfoViewTop: NSLayoutConstraint!
    @IBOutlet var cartCountLbl: UILabel!
    // Variables
    
    var strProd_id  = String()
    var strImgUrl  = String()
    var strProd_name  = String()
    var strProd_price  = String()
    var  wishlist_item_id = String()
    var arrImages = [[String: Any]]()
    var visualization_type = String()
    var mediaUrl = String()
    var arrGroupedValues = [[String: Any]]()
    var strPrice = String()
    var objResponse = Product()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        PageControl.currentPageIndicatorTintColor = buttonColor
        imageToZoom .sd_setImage(with: URL(string:  strImgUrl ), placeholderImage: UIImage(named: ""))
        lblProductName.text = strProd_name
        lblPrice.text = globalStrings.currencyIcon +  strProd_price
        
        lblProductType.text = strProd_name
        
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
            if arrImages.count != 0
            {
                imageToZoom.sd_setShowActivityIndicatorView(true)
                imageToZoom.sd_setIndicatorStyle(.gray)
                imageToZoom.sd_setImage(with: URL(string: arrImages[0][kurl] as! String))
            }
            
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
            
            lblProductName.text = obj.name
            strPrice = obj.finalPrice
            print(strPrice)
            lblPrice.text = "\(globalStrings.currencyIcon +  obj.finalPrice)"
            
            lblProductType.text! = obj.name
            
            print(lblPrice.text!)
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
            
            
            // MARK:- Grouped options View
            if obj.grouped_Values.count != 0
            {
                arrGroupedValues = obj.grouped_Values
                GroupedOptionView.isHidden = false
                groupedTableView.reloadData()
                ConstraintGroupedViewHeight.constant = CGFloat(arrGroupedValues.count*96)+GroupedOption.frame.origin.y
            }
            else
            {
                GroupedOptionView.isHidden = true
                ConstraintGroupedViewHeight.constant = 0
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
    
    // MARK:-  Remove ProductToWishlist  Api methods
    
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
    
    func toLogin(action: UIAlertAction)
    {
        let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        tabBarController.selectedIndex = 4
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController
    }
    
    
    @IBAction func cartBtn(_ sender: Any)
    {
        let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        tabBarController.selectedIndex = 2
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
            var parameters = [ksalt: SALT , PROD_ID : strProd_id , VISITOR_ID : globalStrings.Visitor_id, CUST_ID : globalStrings.Cust_id , QUOTE_ID: globalStrings.Quote_id , SKU: objResponse.sku, kcstore: one] as [String : Any]

            for i in 0..<arrGroupedValues.count {
                if let cell = groupedTableView.cellForRow(at: IndexPath.init(row: i, section: 0)) as? GroupedCell{
                    if Int(cell.quantityField.text!)! > 0 {
                        parameters["super_group[\(arrGroupedValues[i]["id"] ?? "")]"] = cell.quantityField.text!
                    }
                }
            }
            print(parameters)
            let objProduct = Product()
            activityIndicator.startAnimating(activityData)
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
    
   
}


func GroupedCustomOptionView (dict: [String: Any], view: UIView,target:AnyObject , selector:Selector) -> UIView
{
    let lblContentTitle = UILabel.init(frame: CGRect(x: 0,y: view.frame.size.height  ,width:view.frame.size.width , height: 21 ))
    lblContentTitle.text = (dict[ktitle] as? String)!
    lblContentTitle.textColor = buttonColor
    lblContentTitle.font = UIFont.systemFont(ofSize: 12.0)
    view.addSubview(lblContentTitle)
    
    
    let lblTitleQuant = UILabel.init(frame:CGRect(x: 200, y:view.frame.size.height , width: 200, height: 21))
    lblTitleQuant.text = "Quantity"
    lblTitleQuant.textColor = buttonColor
    lblTitleQuant.font = UIFont.systemFont(ofSize: 12.0)
    view.addSubview(lblTitleQuant)
    
    let textfield = UITextField.init(frame: CGRect(x: 200,y: lblTitleQuant.frame.size.height + lblTitleQuant.frame.origin.y ,width: 50 , height: 30 ))
    textfield.backgroundColor = UIColor.white
    textfield.tag = Int(dict[koption_id] as! String)!
    textfield.font = UIFont.systemFont(ofSize: 12.0)
    view.addSubview(textfield)
    
    view.frame = CGRect(x: view.frame.origin.x ,y: view.frame.origin.y ,width:view.frame.size.width , height: lblContentTitle.frame.size.height + textfield.frame.size.height)
    return view
}

extension GroupedDetailViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGroupedValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cGroupedCell) as! GroupedCell
        cell.delegate = self
        cell.configureCell(arrGroupedValues[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

extension GroupedDetailViewController : GroupedCellDelegate {
    func calculateGroupedPrice()
    {
        var total : Float =  0.00
        for i in 0..<arrGroupedValues.count {
            if let cell = groupedTableView.cellForRow(at: IndexPath.init(row: i, section: 0)) as? GroupedCell{
                if Int(cell.quantityField.text!)! > 0 {
                    total =   total + Float(cell.quantityField.text!)!*Float(arrGroupedValues[i]["price"] as! String)!
                }
            }
        }
        lblPrice.text = "\(total)"
    }
}
