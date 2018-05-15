//
//  SearchViewController.swift
//  glory
//
//  Created by navjot_sharma on 11/1/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire
 

class SearchViewController: UIViewController  {
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController)
    {
    }
    
    @IBOutlet weak var GridCollectionView: UICollectionView!
    @IBOutlet weak var tableSearch: UITableView!
    @IBOutlet var SearchBar: UISearchBar!
    
    var searchActive : Bool = false
    var data = [Search]()
    var dataProduct = [Search]()
    var filtered = [String]()
    var ArrProductName = [String]()
    var strID  = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableSearch.tableFooterView = UIView()
        GridCollectionView.isHidden = true
        GridCollectionView.dataSource = self;
        GridCollectionView.delegate = self;
        SearchCategory()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:-  Search Form Api methods
    
    func SearchCategory()
    {
        activityIndicator.startAnimating(activityData)
        let parameters = [ksalt: SALT , CUST_ID : globalStrings.Cust_id , PAGE_ID: Nzero , kcstore: one] as [String : Any]
        let objProduct = Search()
        objProduct.SearchFormApi(dict: parameters, target: self, selector: #selector(self.SearchCatgResponse))
    }
    
    func SearchCatgResponse(obj: Search)
    {
        if obj.resultText == ksuccess
        {
            data = obj.arrCategories
            ArrProductName = obj.arrProducts
            tableSearch.reloadData()
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    // MARK:-  Search Get Api methods
    
    func SearchProduct(text: String)
    {
        activityIndicator.startAnimating(activityData)
        let parameters = [ksalt: SALT , CUST_ID : globalStrings.Cust_id , KEYWORD: text , kcstore: one ]
        let objProduct = Search()
        objProduct.getSearchApi(dict: parameters, target: self, selector: #selector(SearchProductResponse(_:)))
        
    }
    
    func SearchProductResponse(_ obj: [Search])
    {
        if obj[0].resultText == ksuccess
        {
            dataProduct = obj
            GridCollectionView.reloadData()
            GridCollectionView.isHidden = false
            tableSearch.isHidden = true
        }
        else
        {
            globalStrings.showALert(message: obj[0].message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    // MARK:-  AddProductToWishlist  Api methods
    
    func AddProductToWishlist(productId : String)
    {
        if defaults.bool(forKey: dis_login)
        {
            activityIndicator.startAnimating(activityData)
            
            let  parameters = [ksalt: SALT , PROD_ID : productId , CUST_ID: globalStrings.Cust_id, QTY: "1" , kcstore: one]
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
    
    
    func AddProductToWishlistResponse(obj:Product)
    {
        if obj.resultText == ksuccess
        {
            SearchCategory()
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
            let  parameters : Parameters = [ksalt: SALT , WISHLIST_ITEM_ID : wishlistId , CUST_ID: globalStrings.Cust_id ,  kcstore: one]
            let objProduct = Product()
            objProduct.RemoveWishlistApi(dict: parameters, target: self, selector: #selector(self.RemoveProductWishlistResponse))
            
        }
        else
        {
            let cancelAction = UIAlertAction(title: Ok,
                                             style: .default, handler: toLogin)
            globalStrings.showALertAction(message: NotLoggedInWishlist, target: self, actions: cancelAction)
        }
    }
    
    func RemoveProductWishlistResponse(obj : Product)
    {
       if obj.resultText == ksuccess
        {
            SearchCategory()
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    func WishlistbuttonClicked(sender:UIButton)
    {
        let image1 = sender.imageView?.image
        let image2 = #imageLiteral(resourceName: "wishlistButton")
        if (image1?.isEqualToImage(image: image2))!
        {
            AddProductToWishlist(productId: dataProduct[sender.tag-555].productId)
        }
        else
        {
            RemoveProductWishlist(wishlistId: dataProduct[sender.tag-555].inWishlist)
        }
    }
    
    //MARK:- Actions
    
    func toLogin(action: UIAlertAction){
        let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        tabBarController.selectedIndex = 4
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController
    }
    
    @IBAction func BackAction(_ sender: AnyObject)
    {
        GridCollectionView.isHidden = true
    }
}

extension SearchViewController : UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        searchActive = false;
        tableSearch.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        SearchProduct(text: SearchBar.text!)
        GridCollectionView.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        print(ArrProductName)
        filtered = ArrProductName.filter { $0.contains(searchText) }
        
        if(filtered.count == 0){
            searchActive = true;
        } else {
            searchActive = true;
        }
        if  searchText == ""
        {
            GridCollectionView.isHidden = true
            tableSearch.isHidden = false
            searchActive = false;
        }
        self.tableSearch.reloadData()
    }
    
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: cCELL) as UITableViewCell!
        if !(cell != nil)
        {
            cell = UITableViewCell(style:.default, reuseIdentifier: cCELL)
        }
        if(searchActive)
        {
            cell?.textLabel!.text = filtered[indexPath.row]
        }
        else
        {
            cell?.textLabel!.text = data[indexPath.row].name
        }
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 40;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if(searchActive)
        {
            SearchProduct(text: filtered[indexPath.row])
        }
        else
        {
            let objList = self.storyboard?.instantiateViewController(withIdentifier: "ListProductViewController")   as! ListProductViewController
            objList.strID = data[indexPath.row].category_id
            self.present(objList, animated: true, completion: nil)
        }
    }
}

extension SearchViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataProduct.count
    }
    
    func collectionView (_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cSearchProdCell, for: indexPath as IndexPath) as! SearchProdCell
        
        cell.imgProduct.sd_setImage(with: URL(string: dataProduct[indexPath.row].image))
        cell.lblName.text = dataProduct[indexPath.row].name
        cell.lblPrice.text = globalStrings.currencyIcon + dataProduct[indexPath.row].final_price
        if dataProduct[indexPath.row].inWishlist == ""
        {
            cell.btnWishlist.setImage(#imageLiteral(resourceName: "wishlistButton"), for: .normal)
        }
        else
        {
            cell.btnWishlist.setImage(#imageLiteral(resourceName: "wishlistButtonSelected"), for: .normal)
        }
        cell.btnWishlist.tag = indexPath.row + 555
        cell.btnWishlist.addTarget(self,action:#selector(WishlistbuttonClicked),
                                   for:.touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if dataProduct[indexPath.row].typeId == simple
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sProductDetailViewController) as? ProductDetailViewController
            {
                vc.strProd_id =  dataProduct[indexPath.row].productId
                vc.strProd_name =  dataProduct[indexPath.row].name
                vc.strProd_price =  dataProduct[indexPath.row].final_price
                vc.strImgUrl =  dataProduct[indexPath.row].image
                present(vc, animated: true, completion: nil)
            }
        }
        else if dataProduct[indexPath.row].typeId == configurable
        {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sConfigurableProductsView) as? ConfigurableProductsView
            {
                vc.strProd_id =  dataProduct[indexPath.row].productId
                vc.strProd_name =  dataProduct[indexPath.row].name
                vc.strProd_price =  dataProduct[indexPath.row].final_price
                vc.strImgUrl =  dataProduct[indexPath.row].image
                present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 140, height: 180)
    }
    
}

