//
//  FilterViewController.swift
//  Chnen
//
//  Created by navjot_sharma on 11/18/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

import Alamofire

class FilterViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource
{
    //initializing
    var strID  = String()
    var storedstrID  = String()
    var arrFilters  = [Product]()
    
    var arrApplyFilters  = [Product]()
    var arrSubFilters  = [Product]()
    
    
    @IBOutlet weak var AppliedFilterView: UIView!
    @IBOutlet weak var CollectionAplliedFilters: UICollectionView!
    @IBOutlet weak var FilterOptionstable: UITableView!
    @IBOutlet weak var SelectFilterTable: UITableView!
    @IBOutlet weak var coverview: UIView!
    
    @IBOutlet weak var constraintOptionTableHeight: NSLayoutConstraint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        coverview.isHidden = true
        SelectFilterTable.isHidden = true
        storedstrID = strID
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.ListFilter()
            DispatchQueue.main.async(execute: {
                activityIndicator.startAnimating(activityData)
            })
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:-  Product List Api methods
    
    
    func ListFilter()
    {
        var parameters = Parameters ()
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
                    parameters = [ksalt: SALT   , CAT_ID : storedstrID   , PAGE_ID: Nzero  , SORT: Nzero   , kcstore: one   , s1 : s2  ]
                }
                else
                {
                    parameters = [ksalt: SALT   , CAT_ID : storedstrID   , PAGE_ID: Nzero  , SORT: Nzero   , kcstore: one   ]
                }
            }
        }
        else
        {
            parameters = [ksalt: SALT   , CAT_ID : storedstrID   , PAGE_ID: Nzero  , SORT: Nzero   , kcstore: one   ]
        }
        
        let objProduct = Product()
        objProduct.productListApi(dict: parameters as [String : AnyObject], target: self, selector: #selector(ListFilterResponse))
        
    }
    
    func ListFilterResponse(_ obj: Product)
    {
        if obj.resultText == ksuccess
        {
            arrFilters = obj.arrFilters
            if arrFilters.count != 0
            {
                
                CollectionAplliedFilters.reloadData()
                FilterOptionstable.reloadData()
                SelectFilterTable.reloadData()
            }
        }
        else
        {
            globalStrings.showALert(message: SomethingWrong, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    //Mark:- Back Button Methods
    
    @IBAction func BackButton(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return arrApplyFilters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cApplyFiltercell, for: indexPath as IndexPath) as! ApplyFiltercell
        
        cell.lblFilter.text = arrApplyFilters[indexPath.row].label
        cell.removeFilter.tag = indexPath.row + 555
        cell.removeFilter.addTarget(self,action:#selector(removebuttonClicked),
                                    for:.touchUpInside)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        print(arrApplyFilters[indexPath.row])
    }
    
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        label.text = arrApplyFilters[indexPath.row].label
        let w =  label.intrinsicContentSize.width + 45
        return  CGSize(width: w , height: 20)
    }
    
    // MARK:-  Table  methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == FilterOptionstable
        {
            return arrFilters.count
        }
        else
        {
            return arrSubFilters.count
        }
        
    }
    
    // Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == FilterOptionstable
        {
            let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: ccell)! as UITableViewCell
            
            cell.detailTextLabel?.text = ""
            cell.detailTextLabel?.textColor = textColor
            
            if arrApplyFilters.count != 0
            {
                let dict = arrFilters[indexPath.row].arrOptions
                for  dict1 in dict
                {
                    if  (arrApplyFilters as NSArray).contains(dict1)
                    {
                        print(dict1, arrApplyFilters[(arrApplyFilters as NSArray).index(of: dict1)], indexPath.row)
                        cell.detailTextLabel?.text = arrApplyFilters[(arrApplyFilters as NSArray).index(of: dict1)].label
                    }
                }
            }
            cell.textLabel?.text = arrFilters[indexPath.row].label
            cell.textLabel?.textColor = textColor
            tableView.tableFooterView = UIView()
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cSubcell)! as UITableViewCell
            cell.textLabel?.text = arrSubFilters[indexPath.row].label
            cell.textLabel?.textColor = textColor
            tableView.tableFooterView = UIView()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return  44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == FilterOptionstable
        {
            arrSubFilters = arrFilters[indexPath.row].arrOptions
            
            
            if arrApplyFilters.count != 0
                
            {
                for  dict1 in arrApplyFilters
                {
                    if  (arrSubFilters as NSArray).contains(dict1)
                    {
                        arrApplyFilters.remove(at: (arrApplyFilters as NSArray).index(of: dict1))
                    }
                }
                save.SavedArrApplyFilters = arrApplyFilters
            }
            if arrSubFilters.count != 0
            {
                coverview.isHidden = false
                SelectFilterTable.isHidden = false
                let Arrcount = Double(arrSubFilters.count) * 44.0 + 40.0
                constraintOptionTableHeight.constant = CGFloat(Arrcount)
                SelectFilterTable.reloadData()
            }
        }
        else
        {
            coverview.isHidden = true
            SelectFilterTable.isHidden = true
            if (arrSubFilters[indexPath.row].code) != CAT_ID
            {
                arrApplyFilters.append(arrSubFilters[indexPath.row] )
                save.SavedArrApplyFilters = arrApplyFilters
                FilterOptionstable.reloadData()
                CollectionAplliedFilters.reloadData()
            }
            else
            {
                storedstrID = arrSubFilters[indexPath.row].value
                arrApplyFilters.append(arrSubFilters[indexPath.row] )
                save.SavedArrApplyFilters = arrApplyFilters
                FilterOptionstable.reloadData()
                activityIndicator.startAnimating(activityData)
                self.ListFilter()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if tableView == SelectFilterTable
        {
            let vw = UIView()
            vw.backgroundColor = buttonColor
            let label = UILabel(frame: CGRect(x: 10, y: 5, width: 100, height: 30))
            label.textAlignment = .center
            label.text = Select
            label.textColor = UIColor.white
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
        if tableView == SelectFilterTable
        {
            return 40
        }
        else
        {
            return 0
        }
    }
    
    @IBAction func ResetAppliedFilters(_ sender: AnyObject)
    {
        storedstrID = strID
        arrApplyFilters.removeAll()
        save.SavedArrApplyFilters = arrApplyFilters
        activityIndicator.startAnimating(activityData)
        ListFilter()
    }
    
    @IBAction func ApplyFilters(_ sender: AnyObject)
    {
        save.SavedArrApplyFilters = arrApplyFilters
        self.dismiss(animated: true, completion: nil)
    }
    
    func removebuttonClicked(sender:UIButton)
    {
        let dict = arrApplyFilters[sender.tag-555]
        print(dict)
        if dict.code == CAT_ID
        {
            storedstrID = strID
            arrApplyFilters.removeAll()
            save.SavedArrApplyFilters = arrApplyFilters
        }
        else
        {
            arrApplyFilters.remove(at: sender.tag-555)
            save.SavedArrApplyFilters = arrApplyFilters
        }
        activityIndicator.startAnimating(activityData)
        ListFilter()
    }
}
