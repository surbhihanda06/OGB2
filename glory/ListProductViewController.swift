//
//  ListProductViewController.swift
//  Chnen
//
//  Created by navjot_sharma on 11/15/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

import Alamofire

struct Sort {
    var image: UIImage!
    var name: String!
    
    init(image: UIImage, name: String)
    {
        self.image = image
        self.name = name
    }
}


class ListProductViewController: UIViewController
{
    // Variables
    
    var strID  = String()
    var storedstrID  = String()
    var arrApplyFilters  = [Product]()
    var arrProduct  = [Product]()
    var arrSort  = [Sort]()
    var sortValue = String()
    var isGrid = Bool()
    var isMore = Bool()
    var pageNo = Int()
    
    //Outlets
    
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var imgNoItem: UIImageView!
    @IBOutlet weak var GridCollectionView: UICollectionView!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var SingleViewTable: UITableView!
    @IBOutlet weak var sortTable: UITableView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var btnSort: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        globalStrings.isFromFilter = false
        save.SavedArrApplyFilters = []
        coverView.isHidden = true
        sortTable.isHidden = true
        sortValue = ""
        storedstrID = strID
        arrSort.append(Sort(image: #imageLiteral(resourceName: "sortAZ"), name: AtoZ ))
        arrSort.append(Sort(image: #imageLiteral(resourceName: "SortZA"), name: ZtoA ))
        arrSort.append(Sort(image:  #imageLiteral(resourceName: "SortPriceLH"), name: PriceLowToHigh ))
        arrSort.append(Sort(image:  #imageLiteral(resourceName: "SortPriceHL"), name: PriceHighToLow ))
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        if !globalStrings.isFromFilter
        {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                self.pageNo = Nzero
                self.ListProduct()
                DispatchQueue.main.async(execute: {
                    // UI Updates
                    activityIndicator.startAnimating(activityData)
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:-  Product List Api methods
    
    func ListProduct()
    {
        activityIndicator.startAnimating(activityData)
        var parameters = [String: Any] ()
        if save.SavedArrApplyFilters.count != 0
        {
            arrApplyFilters = save.SavedArrApplyFilters
        }
        if arrApplyFilters.count != 0
        {
            for i  in arrApplyFilters
            {
                let s1 = i.code
                let s2 = i.value
                if s1 != CAT_ID
                {
                    parameters = [ksalt: SALT  , CAT_ID : storedstrID  , PAGE_ID: pageNo , CUST_ID : globalStrings.Cust_id, SORT: sortValue  , kcstore: one  , s1 : s2]
                }
                else
                {
                    storedstrID = s2
                    parameters = [ksalt: SALT, CAT_ID : storedstrID, PAGE_ID: pageNo, CUST_ID : globalStrings.Cust_id, SORT: sortValue, kcstore: one]
                }
            }
        }
        else
        {
            parameters = [ksalt: SALT   , CAT_ID : storedstrID   , PAGE_ID: pageNo  ,CUST_ID : globalStrings.Cust_id, SORT: sortValue   , kcstore: one ]
        }
        let objProduct = Product()
        objProduct.productListApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.ListProductResponse))
        
    }
    
    func ListProductResponse(_ obj: Product)
    {
        if obj.resultText == ksuccess
        {
            if pageNo != Nzero
            {
                arrProduct += obj.arrProducts
            }
            else {
                arrProduct = obj.arrProducts
            }
            arrProduct = obj.arrProducts
            isMore = obj.more
            if arrProduct.count != 0
            {
                if !isGrid
                {
                    SingleViewTable.isHidden = true
                    GridCollectionView.isHidden = false
                    GridCollectionView .reloadData()
                    SingleViewTable .reloadData()
                }
                else
                {
                    SingleViewTable.isHidden = false
                    GridCollectionView.isHidden = true
                    GridCollectionView .reloadData()
                    SingleViewTable .reloadData()
                }
                imgNoItem.isHidden = true
                optionsView.isHidden = false
            }
            else
            {
                imgNoItem.isHidden = false
                optionsView.isHidden = true
                SingleViewTable.isHidden = true
                GridCollectionView.isHidden = true
            }
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        
        activityIndicator.stopAnimating()
    }
    
    // MARK:-  AddProductToWishlist  Api methods
    
    func AddProductToWishlist(productId : String)
    {
        if defaults.bool(forKey: dis_login)
        {
            activityIndicator.startAnimating(activityData)
            
            let  parameters = [ksalt: SALT , PROD_ID : productId, CUST_ID: globalStrings.Cust_id  , QTY: "1", kcstore: one]
            let objProduct = Product()
            objProduct.AddWishlistApi(dict: parameters, target: self, selector: #selector(self.AddProductToWishlistResponse))
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
    
    func AddProductToWishlistResponse(obj:Product)
    {
        if obj.resultText == ksuccess
        {
            ListProduct()
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    // MARK:-  RemoveProductWishlist  Api methods
    
    func RemoveProductWishlist(wishlistId : String)
    {
        if defaults.bool(forKey: dis_login)
        {
            let  parameters : Parameters = [ksalt: SALT, WISHLIST_ITEM_ID : wishlistId, CUST_ID: globalStrings.Cust_id,  kcstore: one]
            let objProduct = Product()
            objProduct.RemoveWishlistApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(self.RemoveProductWishlistResponse))
        }
        else
        {
            let cancelAction = UIAlertAction(title: Ok,
                                             style: .default, handler: toLogin)
            globalStrings.showALertAction(message: NotLoggedInWishlist, target: self, actions: cancelAction)
        }
    }
    
    func RemoveProductWishlistResponse(obj:Product)
    {
        if obj.resultText == ksuccess
        {
            ListProduct()
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }

    // MARK: - Back Button method
    
    @IBAction func BackButton(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Sort Button method
    @IBAction func SortButton(_ sender: UIButton)
    {
        coverView.isHidden = false
        sortTable.isHidden = false
        sortTable.reloadData()
    }

    // MARK: - Filter Button method
    @IBAction func FilterButton(_ sender: UIButton)
    {
        globalStrings.isFromFilter = false
        self.performSegue(withIdentifier: SegueFilter, sender: self)
    }
    
    // MARK: - ChangeView Button method
    
    @IBAction func ChangeViewButton(_ sender: UIButton)
    {
        let Button1 = (self.view.viewWithTag(1001) as? UIButton)!
        let Button2 = (self.view.viewWithTag(1002) as? UIButton)!
        if sender.tag == 1001
        {
            isGrid = true
            if (Button1.imageView?.image?.isEqualToImage(image: #imageLiteral(resourceName: "single_view")))!
            {
                Button1.setImage(#imageLiteral(resourceName: "single_view_selected"), for: .normal)
                Button2.setImage(#imageLiteral(resourceName: "grid_view"), for: .normal)
                GridCollectionView.isHidden = true
                SingleViewTable.isHidden = false
                SingleViewTable.reloadData()
            }
        }
        else
        {
            isGrid = false
            if (Button2.imageView?.image?.isEqualToImage(image: #imageLiteral(resourceName: "grid_view")))!
            {
                Button1.setImage(#imageLiteral(resourceName: "single_view"), for: .normal)
                Button2.setImage(#imageLiteral(resourceName: "grid_view_selected"), for: .normal)
                GridCollectionView.isHidden = false
                SingleViewTable.isHidden = true
                GridCollectionView.reloadData()
            }
        }
    }
    
    func WishlistbuttonClicked(sender:UIButton)
    {
        let image1 = sender.imageView?.image
        let image2 = #imageLiteral(resourceName: "wishlistButton")
        if (image1?.isEqualToImage(image: image2))!
        {
            //image change pending
            
            AddProductToWishlist(productId: arrProduct[sender.tag-555].productId )
        }
        else
        {
            RemoveProductWishlist(wishlistId: arrProduct[sender.tag-555].inWishlist)
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == SegueFilter
        {
            if let destinationVC = segue.destination as? FilterViewController
            {
                destinationVC.strID = strID
            }
        }
    }
    
}

extension ListProductViewController: UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cProductListViewCell, for: indexPath as IndexPath) as! ProductListViewCell
        
        cell.imgProduct.sd_setShowActivityIndicatorView(true)
        cell.imgProduct.sd_setIndicatorStyle(.gray)
        cell.imgProduct.sd_setImage(with: URL(string:arrProduct[indexPath.row].image))
        cell.lblName.text = arrProduct[indexPath.row].name
        cell.lblPrice.text = globalStrings.currencyIcon + arrProduct[indexPath.row].finalPrice
        if arrProduct[indexPath.row].inWishlist == ""
        {
            cell.btnWishlist.setImage(#imageLiteral(resourceName: "wishlistButton"), for: .normal)
        }
        else
        {
            cell.btnWishlist.setImage(#imageLiteral(resourceName: "wishlistButtonSelected"), for: .normal)
        }
        cell.btnWishlist.tag = indexPath.row + 555
        cell.btnWishlist.addTarget(self,action:#selector (WishlistbuttonClicked),for:.touchUpInside)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        globalStrings.isFromFilter = true
        if arrProduct[indexPath.row].typeID == simple
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sProductDetailViewController) as? ProductDetailViewController
            {
                vc.strProd_id =  arrProduct[indexPath.row].productId
                vc.strProd_name =  arrProduct[indexPath.row].name
                vc.strProd_price =  arrProduct[indexPath.row].finalPrice
                vc.strImgUrl =  arrProduct[indexPath.row].image
                present(vc, animated: true, completion: nil)
            }
        }
        else if arrProduct[indexPath.row].typeID == configurable
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sConfigurableProductsView) as? ConfigurableProductsView
            {
                vc.strProd_id =  arrProduct[indexPath.row].productId
                vc.strProd_name =  arrProduct[indexPath.row].name
                vc.strProd_price =  arrProduct[indexPath.row].finalPrice
                vc.strImgUrl =  arrProduct[indexPath.row].image
                present(vc, animated: true, completion: nil)
            }
        }
        else if arrProduct[indexPath.row].typeID == downloadable
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sDownloadableProductsView) as? DownloadableProductsView
            {
                vc.strProd_id =  arrProduct[indexPath.row].productId
                vc.strProd_name =  arrProduct[indexPath.row].name
                vc.strProd_price =  arrProduct[indexPath.row].finalPrice
                vc.strImgUrl =  arrProduct[indexPath.row].image
                present(vc, animated: true, completion: nil)
            }
        }
        else if arrProduct[indexPath.row].typeID == bundle
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sBundleProductViewController) as? BundleProductViewController
            {
                vc.strProd_id =  arrProduct[indexPath.row].productId
                vc.strProd_name =  arrProduct[indexPath.row].name
                vc.strProd_price =  arrProduct[indexPath.row].finalPrice
                vc.strImgUrl =  arrProduct[indexPath.row].image
                self.present(vc, animated: true, completion: nil)
            }
        }
        else if arrProduct[indexPath.row].typeID == virtual
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sVirtualViewController) as? VirtualProductDetailController
            {
                vc.strProd_id =  arrProduct[indexPath.row].productId
                vc.strProd_name =  arrProduct[indexPath.row].name
                vc.strProd_price =  arrProduct[indexPath.row].finalPrice
                vc.strImgUrl =  arrProduct[indexPath.row].image
                self.present(vc, animated: true, completion: nil)
            }
        }
        else if arrProduct[indexPath.row].typeID == grouped
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sGroupedDetailViewController) as? GroupedDetailViewController
            {
                vc.strProd_id =  arrProduct[indexPath.row].productId
                vc.strProd_name =  arrProduct[indexPath.row].name
                vc.strProd_price =  arrProduct[indexPath.row].finalPrice
                vc.strImgUrl =  arrProduct[indexPath.row].image
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 140, height: 210)
    }
}

extension ListProductViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == SingleViewTable
        {
            return arrProduct.count
        }
        else
        {
            return arrSort.count
        }
    }
    
    // Cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == SingleViewTable
        {
            let cell:SingleViewCell = tableView.dequeueReusableCell(withIdentifier: cSingleViewCell) as! SingleViewCell
            cell.imgProduct.sd_setShowActivityIndicatorView(true)
            cell.imgProduct.sd_setIndicatorStyle(.gray)
            cell.imgProduct.sd_setImage(with: URL(string:arrProduct[indexPath.row].image))
            cell.lblName.text = arrProduct[indexPath.row].name
            cell.lblPrice.text = globalStrings.currencyIcon + arrProduct[indexPath.row].finalPrice
            if arrProduct[indexPath.row].inWishlist == ""
            {
                cell.btnWishlist.setImage(#imageLiteral(resourceName: "wishlistButton"), for: .normal)
            }
            else
            {
                cell.btnWishlist.setImage(#imageLiteral(resourceName: "wishlistButtonSelected"), for: .normal)
            }
            cell.btnWishlist.tag = indexPath.row + 555
            cell.btnWishlist.addTarget(self,action:#selector (WishlistbuttonClicked),for:.touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            let cell:SortTableViewCell = tableView.dequeueReusableCell(withIdentifier: cSortTableViewCell) as! SortTableViewCell
            cell.imgSort.image = arrSort[indexPath.row].image
            cell.lblSort.text = arrSort[indexPath.row].name
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == SingleViewTable
        {
            return  SingleViewTable.frame.size.height
        }
        else
        {
            return 44.0
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == SingleViewTable
        {
            globalStrings.isFromFilter = true
            if arrProduct[indexPath.row].typeID == simple
            {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sProductDetailViewController) as? ProductDetailViewController
                {
                    vc.strProd_id =  arrProduct[indexPath.row].productId
                    vc.strProd_name =  arrProduct[indexPath.row].name
                    vc.strProd_price =  arrProduct[indexPath.row].finalPrice
                    vc.strImgUrl =  arrProduct[indexPath.row].image
                    present(vc, animated: true, completion: nil)
                }
            }
            else if arrProduct[indexPath.row].typeID == configurable
            {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sConfigurableProductsView) as? ConfigurableProductsView
                {
                    vc.strProd_id =  arrProduct[indexPath.row].productId
                    vc.strProd_name =  arrProduct[indexPath.row].name
                    vc.strProd_price =  arrProduct[indexPath.row].finalPrice
                    vc.strImgUrl =  arrProduct[indexPath.row].image
                    present(vc, animated: true, completion: nil)
                }
            }
            else if arrProduct[indexPath.row].typeID == downloadable
            {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sDownloadableProductsView) as? DownloadableProductsView
                {
                    vc.strProd_id =  arrProduct[indexPath.row].productId
                    vc.strProd_name =  arrProduct[indexPath.row].name
                    vc.strProd_price =  arrProduct[indexPath.row].finalPrice
                    vc.strImgUrl =  arrProduct[indexPath.row].image
                    present(vc, animated: true, completion: nil)
                }
            }
            else if arrProduct[indexPath.row].typeID == bundle
            {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sBundleProductViewController) as? BundleProductViewController
                {
                    vc.strProd_id =  arrProduct[indexPath.row].productId
                    vc.strProd_name =  arrProduct[indexPath.row].name
                    vc.strProd_price =  arrProduct[indexPath.row].finalPrice
                    vc.strImgUrl =  arrProduct[indexPath.row].image
                    self.present(vc, animated: true, completion: nil)
                }
            }
            else if arrProduct[indexPath.row].typeID == virtual
            {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sVirtualViewController) as? VirtualProductDetailController
                {
                    vc.strProd_id =  arrProduct[indexPath.row].productId
                    vc.strProd_name =  arrProduct[indexPath.row].name
                    vc.strProd_price =  arrProduct[indexPath.row].finalPrice
                    vc.strImgUrl =  arrProduct[indexPath.row].image
                    self.present(vc, animated: true, completion: nil)
                }
            }
            else if arrProduct[indexPath.row].typeID == grouped
            {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sGroupedDetailViewController) as? GroupedDetailViewController
                {
                                    vc.strProd_id =  arrProduct[indexPath.row].productId
                                    vc.strProd_name =  arrProduct[indexPath.row].name
                                    vc.strProd_price =  arrProduct[indexPath.row].finalPrice
                                    vc.strImgUrl =  arrProduct[indexPath.row].image
                    self.present(vc, animated: true, completion: nil)
                }
            }
            
        }
        else
        {
            coverView.isHidden = true
            sortTable.isHidden = true
            switch indexPath.row
            {
            case 0:
                sortValue = name_asc
                btnSort.setImage(arrSort[indexPath.row].image , for: .normal)
                break
            case 1:
                sortValue = name_desc
                btnSort.setImage(arrSort[indexPath.row].image , for: .normal)
                break
            case 2:
                sortValue = price_asc
                btnSort.setImage(arrSort[indexPath.row].image , for: .normal)
                break
            case 3:
                sortValue = price_desc
                btnSort.setImage(arrSort[indexPath.row].image , for: .normal)
                break
            default:
                sortValue = ""
            }
            activityIndicator.startAnimating(activityData)
            self.ListProduct()
        }
    }
}


extension ListProductViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height {
            if isMore {
                pageNo += 1
                ListProduct()
            }
        }
    }
}

