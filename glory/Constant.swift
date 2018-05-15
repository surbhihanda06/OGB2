//
//  Constant.swift
//Chnen
//  Created by navjot_sharma on 11/11/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

// Mark:- URL + Method Names
//https://chnen.com/index.php/minimart/miniapi/homepage?salt=0af013754b211b040fd35a938c6becb0
//http://toleena.com/minimart/miniapi/

let BASE_URL             = "http://182.75.88.145:8088/Magento217/minimart/miniapi/" //"http://192.168.0.82/Magento217/minimart/miniapi/"

let SALT                 = ""

//important
let globalStrings         = CommonFunctions.sharedInstance()
let defaults              = UserDefaults.standard
let save                  = SaveClass.sharedInstance
let server                = ServerClass.sharedInstance
let activityData          = ActivityData()
let activityIndicator     = NVActivityIndicatorPresenter.sharedInstance

//METHODS
let HOME_PAGE                     = "homepage"
let PRODUCT_LIST                  = "productlist"
let addProductToWishList          = "addProductToWishList"
let removeWishListItem            = "removeWishListItem"
let CART_DETAIL                   = "cartDetail"
let DELETE_FROM_CART              = "deletefromcart"
let MOVE_TO_WISHLIST              = "movetowishlist"
let UPDATE_CART                   = "updateCart"
let GET_WISHLIST_ITEMS            = "getWishlistItems"
let GET_SEARCHFORM_DATA           = "getSearchFormData"
let GET_SEARCH                    = "getSearch"
let PRODUCT_DETAIL                = "productDetail"
let ADD_TO_CART                   = "addtocart"
let LOGIN                         = "login"
let SET_QUOTE_ADDRESS             = "setQuoteAddress"
let GET_CUSTOMER_ADDRLIST         = "getCustomerAddrList"
let GET_CUSTOMER_ADDR_BY_ID       = "getCustomerAddrById"
let UPDATE_ADDR_PREF              = "updateAddrPref"
let GET_METHODS                   = "getMethods"
let ASSIGN_SHIP_TO_QUOTE          = "assignShiptoQuote"
let ASSIGN_PAYMENT_TO_QUOTE       = "assignPaymentToQuote"
let PLACE_ORDER                   = "placeOrder"
let ORDER_LIST                    = "orderList"
let ORDER_INFO                    = "orderInfo"
let CANCEL_ORDER                  = "CancleOrder"
let GETDOWLOAD_LINK               = "getDLinkUrl"
let REGISTRATION                  = "registration"
let RESET_PASSWORD                = "resetPassword"
let USER_INFO                     = "userInfo"
let UPDATE_USER_INFO              = "updateUserInfo"
let GET_STORE_LIST                = "getStoreList"
let GET_COUNTRY                   = "getCountry"
let GET_REGION                    = "getRegion"
let UPDATE_CUST_ADDR              = "updateCustAddrData"
let GETMYDOWNLOADABLES            = "getMyDownlodables"

//REQUEST PARAMETERS

let CAT_ID                        = "cat_id"
let PAGE_ID                       = "page_id"
let SORT                          = "sort"
let PROD_ID                       = "prod_id"
let CUST_ID                       = "cust_id"
let QTY                           = "qty"
let WISHLIST_ITEM_ID              = "wishlist_item_id"
let VISITOR_ID                    = "visitor_id"
let QUOTE_ID                      = "quote_id"
let SKU                           = "sku"
let ITEM_ID                       = "item_id"
let KEYWORD                       = "keyword"
var EMAIL                         = "email"
let PASSWORD                      = "password"
let DEVICE_TYPE                   = "device_type"
let DEVICE_ID                     = "device_id"
let SOCIAL_ID                     = "social_id"
let FBSOCIAL_ID                   = "fb_social_id"
let GMAILSOCIAL_ID                = "gmail_social_id"
let LOGIN_TYPE                    = "login_type"
let USE_FOR_SHIPPING              = "use_for_shipping"
let FIRST_NAME                    = "firstname"
let LAST_NAME                     = "lastname"
let NAME                          = "name"
let SOCIALFIRST_NAME              = "first_name"
let SOCIALLAST_NAME               = "last_name"
let SOCIALNAME                    = "name"
let SCACHE_KEY                    = "cache_key"
let SDATA                         = "data"
let SPICTURE                      = "picture"
let STREET                        = "street"
let CITY                          = "city"
let REGION                        = "region"
let REGION_ID                     = "region_id"
let STATE                         = "state"
let ZIP                           = "zip"
let COUNTRY_ID                    = "country_id"
let PHONE                         = "phone"
let EXTRA_PHONE                   = "extra_phone"
let FAX                           = "fax"
let SFIRST_NAME                   = "s_firstname"
let SLAST_NAME                    = "s_lastname"
let SSTREET                       = "s_street"
let SCITY                         = "s_city"
let SSTATE                        = "s_state"
let SREGION                       = "s_region"
let SREGIONID                     = "S_region_id"
let SZIP                          = "s_zip"
let SCOUNTRY_ID                   = "s_country_id"
let SPHONE                        = "s_phone"
let SEXTRA_PHONE                  = "s_extra_phone"
let SFAX                          = "s_fax"
let SEMAIL                        = "s_email"
let SREGION_ID                    = "s_region_id"

let ADDR_ID                       = "addr_id"
let ONLY_SHIP                     = "only_ship"
let BILL_ID                       = "bill_id"
let SHIP_ID                       = "ship_id"
let SHIP_METHOD                   = "ship_method"
let PAY_METHOD                    = "pay_method"
let UID                           = "uid"
let GENDER                        = "gender"
let CURRENT_PASS                  = "current_pass"

//Mark:- Constant Numbers

let Nzero                        = 0
let None                         = 1
let Ntwo                         = 2
let one                          = "1"
let zero                         = "0"

// Mark:- Segues

let SegueListing                 =  "SegueListing"
let SegueFilter                  = "SegueFilter"
let SegueBagToGuest              = "SegueBagToGuest"
let SegueGuestToAddress          = "SegueGuestToAddress"
let SegueToShipping              = "SegueToShipping"
let SegueToAddresslist           = "SegueToAddresslist"
let SegueGuestToBilling          = "SegueGuestToBilling"
let SegueEditBilling             = "SegueEditBilling"
let SegueEditShipping            = "SegueEditShipping"
let SegueCheckout                = "SegueCheckout"
let SegueChangeAddress           = "SegueChangeAddress"
let SegueToPaymentMethods        = "SegueToPaymentMethods"
let SegueToOrderDetail           = "SegueToOrderDetail"
let SegueToForgotPassword        = "SegueToForgotPassword"

// Mark:- Constant Strings

let customerAlreadyExist = "This customer email already exists"
let invalidLoginCredentials = "Invalid login or password."

let SomethingWrong          = "Oops!!Something went wrong"
let noInternet              = "Please check Internet Connection"
let TextEmpty               = "Please fill the mandatory fields"
let NotValidEmail           = "Email format should be correct."
let AtoZ                    = "A to Z"
let ZtoA                    = "Z to A"
let LessCharacteredPassword = "Password should be of at least 6 character"
let Lessfirstname           = "Firstname should be of at least 3 character"
let Lesslastname           = "Firstname should be of at least 3 character"
let PriceLowToHigh          = "Price Low to High"
let PriceHighToLow          = "Price High to Low"
let Select                  = "Select"
let PRODUCT                 = " PRODUCT"
let PRODUCTS                = " PRODUCTS"
let SelectAShippingMethod   = "Select a shipping method"
let Male                    = "Male"
let Female                  = "Female"
let account                 = "Account"
let language                = "Language"
let appInfo                 = "App Info"
let aboutUs                 = "About Us"
let signout                 = "Sign out"
let OrderNo                 = "Order No "
let Items                   = "Items"
let total                   = "Total "
let Qty                     =  "Qty : "
let AppName                 =  "App Name -"
let Chnen                   =  "Chnen"
let AppVersion              =  "App Version -"
let ApiEnvironment          = "Api Environment -"
let Live                    = "Live"
let NotLoggedInWishlist     = "You must be logged in to add this product to Wishlist."
let NotLoggedInBag          = "You must be logged in to avail this product."
let SpecifyShipMethod       = "Please specify shipping method. "
let Ok                      = "Ok"
let AddressChanged          = "Default Address Changed."
let PasswordChanged         = "Password Changed."
let ProfileChanged          = "Profile Updated."
let PhoneChanged            = "Phone Number Updated."

// Mark:- Constants Parameters

let name_desc      = "name_desc"
let name_asc       = "name_asc"
let price_desc     = "price_desc"
let price_asc      = "price_asc"
let Iphone         = "Iphone"
let dateFormat1    = "yyyy-MM-dd HH:mm:ss"
let simple         = "simple"
let configurable   = "configurable"
let downloadable   = "downloadable"
let bundle         = "bundle"
let virtual        = "virtual"
let grouped        = "grouped"
let drop_down      = "drop_down"
let bundle_select  = "select"
let checkbox       = "checkbox"
let date           = "date"
let date_time      = "date_time"
let multiple       = "multiple"
let radio          = "radio"
let area           = "area"
let field          = "field"
let time           = "time"


// Mark:- Constant Keys

let kreturnCode                  = "returnCode"
let kresultText                  = "resultText"
let kresult                      = "result"
let khomepagesection             = "homepage_sections"
let kProduct                     = "product"
let kfilters                     = "filters"
let kCategories                  = "categories"
let kWishlistId                  = "wishlist_item_id"
let kImages                      = "images"
let kProducts                    = "products"
let kWishlistItems               = "wishlist_items"
let kCurrencySymbol              = "currency_symbol"
let kVisitorId                   = "visitor_id"
let kOrder                       = "order"
let ksuccess                     = "success"
let kisFail                      = "fail"
let kresponse                    = "response"
let kmessage                     = "message"
let kresponse_msg                = "response_msg"
let kAddress                     = "address"
let kAddresses                   = "addresses"
let kBilling                     = "default_billing"
let kShipping                    = "default_shipping"
let ksalt                        = "salt"
let konly_section                = "only_section"
let kcstore                      = "cstore"
let kimage                       = "image"
let kimg                         = "img"
let kurl                         = "url"
let kfirst                       = "first"
let ksecond                      = "second"
let kselections                   = "selections"
let kblocks                      = "blocks"
let kchilds                      = "childs"
let klayout                      = "layout"
let kprimary_cat                 = "primary_cat"
let ktitle                       = "title"
let klink_selection_required     = "link_selection_required"
let klinks_purchased_separately  = "links_purchased_separately"
let kprepend_link                = "prepend_link"
let kname                        = "name"
let kchildren                    = "children"
let kfinal_price                 = "final_price"
let kproduct_title               = "product_title"
let klink_hash                   = "link_hash"
let kid                          = "id"
let kcategory_id                 = "category_id"
let kproduct_id                  = "product_id"
let klabel                       = "label"
let ktittle                      = "title"
let kis_shareable                = "is_shareable"
let ksample_file                 = "sample_file"
let ksample_url                  = "sample_url"
let klink_price                  = "link_price"
let kis_required                 = "is_required"
let koptions                     = "options"
let kdescription                 = "description"
let kcode                        = "code"
let kvalue                       = "value"
let kwishlist_item_id            = "wishlist_item_id"
let kInStock                     = "in_stock"
let kproduct_url                 = "product_url"
let kspecification               = "specification"
let ksku                         = "sku"
let kquote_id                    = "quote_id"
let kquote_count                 = "quote_count"
let kmsg                         = "msg"
let kprice                       = "price"
let Kselection_id                = "selection_id"
let Kselection_qty               = "selection_qty"
let klinkPrice                   = "link_price"
let kqty                         = "qty"
let kgrandtotal                  = "grandtotal"
let ksubtotal                    = "subtotal"
let kdiscount                    = "discount"
let kship_cost                   = "ship_cost"
let kship_charge                 = "ship_charge"
let ktype_id                     = "type_id"
let kprod_Id                     = "prod_Id"
let kitem_id                     = "item_id"
let kis_desc_html                = "is_desc_html"
let kwishlist_id                 = "wishlist_id"
let kproduct_name                = "product_name"
let kproduct_image               = "product_image"
let kcust_id                     = "cust_id"
let kas_html                     = "as_html"
let kaddr_id                     = "addr_id"
let kfirstname                   = "firstname"
let klastname                    = "lastname"
let kemail                       = "email"
let kstreet                      = "street"
let kcountry_id                  = "country_id"
let kcity                        = "city"
let kpostcode                    = "postcode"
let ktelephone                   = "telephone"
let kextra_phone                 = "extra_phone"
let kregion                      = "region"
let kbilling_addr                = "billing_addr"
let kcust_has_addr               = "cust_has_addr"
let kshipping_addr               = "shipping_addr"
let kcarrier_title               = "carrier_title"
let kmethod_code                 = "method_code"
let kcarrier_code                = "carrier_code"
let kprice_excl_tax              = "price_excl_tax"
let kship_method                 = "ship_method"
let kpayment                     = "payment"
let kproduct                     = "product"
let kproducts                    = "products"
let korder_id                    = "order_id"
let kMethod_name                 = "method_name"
let kcustomer_info               = "customer_info"
let kshipping_address            = "shipping_address"
let kcreated                     = "created"
let kstate                       = "state"
let kHash                        = "hash"

let kshipping_total              = "shipping_total"
let kitems                       = "items"
let kimg_url                     = "img_url"
let kgrand_total                 = "grand_total"
let kinWishlist                  = "inWishlist"
let kgender                      = "gender"
let kstores                      = "stores"
let kcurrency                    = "currency"
let kdefault_store_id            = "default_store_id"
let kis_virtual                  = "is_virtual"
let kconfig_attributes           = "config_attributes"
let kdownloadable_options        = "downloadable_options"
let kbundle_options              = "bundle_options"
let kassociated                  =  "associated"
let kattributes                  = "attributes"
let ksamples                     = "samples"
let klinks                       = "links"
let krows                        = "rows"
let kis_visible                  = "is_visible"
let kvisualization_type          = "visualization_type"
let korder_date                  = "order_date"
let kicon                        = "icon"
let kcolor                       = "color"
let kmedia_url                   = "media_url"
let khave_stock                  = "have_stock"
let kavailable                   = "available"
let ktype                        = "type"
let kadditional_fields           = "additional_fields"
let koption_id                   = "option_id"
let koption_type_id              = "option_type_id"
let kdefault_title               = "default_title"
let kdefault_price               = "default_price"
let kmore                        = "more"
let kiso2_code                   = "iso2_code"
let kregion_id                   = "region_id"
let kis_active                   = "is_active"
let kstore_id                    = "store_id"

// cell names

let cCategoryTableCell                 = "CategoryTableCell"
let cProductListViewCell               = "ProductListViewCell"
let cSingleViewCell                    = "SingleViewCell"
let cSortTableViewCell                 = "SortTableViewCell"
let cApplyFiltercell                   = "ApplyFiltercell"
let ccell                              = "cell"
let cSubcell                           = "Subcell"
let cCartViewCell                      = "CartViewCell"
let cWishListCell                      = "WishListCell"
let sDownloadblesLIstVC                = "DownloadblesLIstVC"
let cSearchProdCell                    = "SearchProdCell"
let cSavedAddressCell                  = "SavedAddressCell"
let cCartCheckoutCell                  = "CartCheckoutCell"
let cShippingMethodCell                = "ShippingMethodCell"
let cPaymentMethodCell                 = "PaymentMethodCell"
let cOrderListCustomCell               = "OrderListCustomCell"
let cOrderListCustomHeader             = "OrderListCustomHeader"
let cOrderDetailCell                   = "OrderDetailCell"
let cCELL                              = "CELL"
let cAppInfoCell                       = "AppInfoCell"
let cSizeCollectionCell                = "SizeCollectionCell"
let cColorCollectionCell               = "ColorCollectionCell"
let cDownloadableCell                  = "DownloadableCell"
let cGroupedCell                       = "GroupedCell"
//StoryBoard Ids

let sProductDetailViewController     = "ProductDetailViewController"
let sPaymentMethodsViewController    = "PaymentMethodsViewController"
let sSuccessViewController           = "SuccessViewController"
let sOrderListVC                     = "OrderListVC"
let sAddressViewController           = "AddressViewController"
let sBillingAddressViewController    = "BillingAddressViewController"
let sGuestUserViewController         = "GuestUserViewController"
let sLoginViewController             = "LoginViewController"
let sAppInfoViewController           = "AppInfoViewController"
let sAccountViewController           = "AccountViewController"
let sAboutUsViewController           = "AboutUsViewController"
let sLanguageViewController          = "LanguageViewController"
let sConfigurableProductsView        = "ConfigurableProductsView"
let sDownloadableProductsView        = "DownloadableProductsView"
let sBundleProductViewController     = "BundleProductViewController"
let sVirtualViewController           = "VirtualProductDetailController"
let sGroupedDetailViewController     = "GroupedDetailViewController"


// User defaults keys
let dquote_id                        = "Quote_id"
let dquote_count                     = "Quote_count"
let demail                           = "email"
let ddevice_id                       = "device_id"
let dcust_id                         = "cust_id"
let dis_login                        = "is_login"

extension String {
    func isValidEmail() -> Bool
    {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isEmpty() -> Bool {
        if self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count > 0  {
            return false
        } else {
            return true
        }
    }
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height )
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
    var html2AttributedString: NSAttributedString?
    {
        guard let data = data(using: .utf8) else
        {
            return nil
        }
        do
        {
            return try NSAttributedString(data: data, options:[NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
            return  nil
        }
    }
    var html2String: String
    {
        return html2AttributedString?.string ?? ""
    }
    
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    //: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

extension UIViewController {
    var appDelegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

extension Array {
    func random() -> Element? {
        if self.isEmpty { return nil }
        let randomInt = Int(arc4random_uniform(UInt32(self.count)))
        return self[randomInt]
    }
}

extension UINavigationController {
    func pop(animated: Bool) {
        _ = self.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        _ = self.popToRootViewController(animated: animated)
    }
}

extension UIImage
{
    func isEqualToImage(image: UIImage) -> Bool {
        let data1: NSData = UIImagePNGRepresentation(self)! as NSData
        let data2: NSData = UIImagePNGRepresentation(image)! as NSData
        return data1.isEqual(data2)
    }
    
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}


private var maxLengths = [UITextField: Int]()
private var allowChars = [UITextField: String]()

extension UITextField
{
    @IBInspectable var maxLength: Int
        {
        get
        {
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set
        {
            maxLengths[self] = newValue
            addTarget(
                self,
                action: #selector(limitLength),
                for: UIControlEvents.editingChanged)
        }
    }
    
    func limitLength(textField: UITextField) {
        guard let prospectiveText = textField.text
            , prospectiveText.characters.count > maxLength else {
                return
        }
        let selection = selectedTextRange
        text = prospectiveText.substring(with: Range<String.Index>(prospectiveText.startIndex ..< prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength) ))
        selectedTextRange = selection
    }
    
    
    @IBInspectable var AllowedChars: String {
        get {
            return self.AllowedChars
        }
        set
        {
            allowChars[self] = newValue
            addTarget(self, action: #selector(limitChars), for: .editingChanged)
        }
    }
    
    func limitChars()
    {
        let inverseSet = NSCharacterSet(charactersIn:allowChars[self]!).inverted
        let components = self.text?.components(separatedBy: inverseSet)
        let filtered = components?.joined(separator: "")
        self.text = filtered
    }
}

extension UIView
{
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

extension CALayer
{
    func setBorderUIColor(color: UIColor)
    {
        borderColor = color.cgColor
    }
    
    func borderUIColor() -> UIColor
    {
        return UIColor.init(cgColor: borderColor!)
    }
}

extension UIButton
{
    func centerTextAndImage(spacing: CGFloat)
    {
        let insetAmount = spacing / 2
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: insetAmount )
        imageEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount * 2, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: 0)
    }
}


