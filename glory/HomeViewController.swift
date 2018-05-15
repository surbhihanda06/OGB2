//
//  HomeViewController.swift
//  glory
//
//  Created by navjot_sharma on 11/1/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import Alamofire

import SDWebImage

struct Section {
    var name: String!
    var image: String!
    var items: [[String: Any]]!
    var collapsed: Bool!
    
    init(name: String, image: String, items: [[String: Any]], collapsed: Bool = true) {
        self.name = name
        self.image = image
        self.items = items
        self.collapsed = collapsed
        
    }
}

class HomeViewController: UIViewController,CollapsibleTableViewHeaderDelegate
{
    //Layout 13
    
    @IBOutlet weak var btnImg1: UIButton!
    @IBOutlet weak var btnImg2: UIButton!
    @IBOutlet weak var btnImg3: UIButton!
    @IBOutlet weak var btnImg4: UIButton!
    @IBOutlet weak var btnImg5: UIButton!
    @IBOutlet weak var btnImg6: UIButton!
    @IBOutlet weak var btnImg7: UIButton!
    @IBOutlet weak var btnImg8: UIButton!
    @IBOutlet weak var btnImg9: UIButton!
    @IBOutlet weak var btnImg10: UIButton!
    @IBOutlet weak var btnImg11: UIButton!
    @IBOutlet weak var btnImg12: UIButton!
    @IBOutlet weak var btnImg13: UIButton!
    
    //layout 9
    
    @IBOutlet weak var btnImg91: UIButton!
    @IBOutlet weak var btnImg92: UIButton!
    @IBOutlet  weak var btnImg93: UIButton!
    @IBOutlet weak var btnImg94: UIButton!
    @IBOutlet weak var btnImg95: UIButton!
    @IBOutlet weak var btnImg96: UIButton!
    @IBOutlet weak var btnImg97: UIButton!
    @IBOutlet weak var btnImg98: UIButton!
    @IBOutlet weak var btnImg99: UIButton!
     var selectedIndex = Int ()
    //Outlets for Table
    
    @IBOutlet weak var tableCategory: UITableView!
    
    //Outlets for Constraints
    
    @IBOutlet weak var ConstraintCategoryTableY: NSLayoutConstraint!
    @IBOutlet weak var ConstraintContentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ConstraintKidsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ContraintCategoryTableHeight: NSLayoutConstraint!
    
    //Outlets for Views
    @IBOutlet  var contentView: UIView!
    @IBOutlet  var scrollView: UIScrollView!
    @IBOutlet  var kidsView: UIView!
    @IBOutlet weak var topCollectionView: UICollectionView!
    
    //initializing
    var applicationDictionary = [[String: Any]]()
    var arrChild  = [[String: Any]]()
    var sections = [Section]()
    var headerSaved =  CollapsibleTableViewHeader()
    var indexSaved =  Int()
    var strId =  String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        kidsView.isHidden = true
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            // Background thread
            self.HomePageApi()
            DispatchQueue.main.async(execute: {
                // UI Updates
                activityIndicator.startAnimating(activityData)
            })
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:-  Home Page Api methods
    
    func HomePageApi()
    {
        activityIndicator.startAnimating(activityData)
        let parameters = [ksalt: SALT , konly_section : one  , kcstore: one ]
        let objHome = Home()
        objHome.homepageApi(dict: parameters, target: self, selector: #selector(self.HomepageResponse))
    }
    
    func HomepageResponse(obj: Home)
    {
        if obj.resultText == ksuccess
        {
            applicationDictionary = obj.homePageSection
            if applicationDictionary.count != 0
            {
                self.setPageLayout(applicationDictionary[0])
                topCollectionView.reloadData()
            }
            else
            {
                globalStrings.showALert(message: obj.message, target: self)
            }
        }
        else
        {
            globalStrings.showALert(message: obj.message, target: self)
        }
        activityIndicator.stopAnimating()
    }
    
    // MARK:-  Helper methods
    
    func setPageLayout(_ dict: [String: Any])
    {
        indexSaved = Int()
        headerSaved = CollapsibleTableViewHeader()
        let layout = dict[klayout] as! String
        let arrBlock = dict[kblocks] as! [[String : Any]]
        if layout == "13"
        {
            self.Layout13(arrBlock: arrBlock)
        }
        else
        {
            self.Layout9(arrBlock: arrBlock)
        }
        
        arrChild  = (dict[kchilds] as? [[String: Any]])!
        ContraintCategoryTableHeight.constant = CGFloat(arrChild.count * 40)
        ConstraintContentViewHeight.constant = (ConstraintContentViewHeight.constant -  (236 - ContraintCategoryTableHeight.constant))
        sections.removeAll()
        for  j in arrChild
        {
            let name = j[kname] as! String
            let img = j[kimage] as! String
            let  arrItems  = j[kchildren] as! [[String: Any]]
            sections.append(Section(name: name,image: img, items: arrItems))
        }
        
        tableCategory.reloadData()
    }
    
    func Layout13(arrBlock : [[String: Any]])
    {
        kidsView.isHidden = true
        btnImg1.isHidden = false
        btnImg2.isHidden = false
        btnImg3.isHidden = false
        btnImg4.isHidden = false
        btnImg5.isHidden = false
        btnImg6.isHidden = false
        btnImg7.isHidden = false
        btnImg8.isHidden = false
        btnImg9.isHidden = false
        btnImg10.isHidden = false
        btnImg11.isHidden = false
        btnImg12.isHidden = false
        btnImg13.isHidden = false
        if arrBlock.count != 0
        {
            var i = 0
            for  dict in arrBlock
            {
                switch i
                {
                case 0:
                    btnImg1.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg1.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg1)
                    break
                case 1:
                    btnImg2.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg2.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg2)
                    break
                case 2:
                    btnImg3.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg3.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg3)
                    break
                case 3:
                    btnImg4.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg4.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg4)
                    break
                case 4:
                    btnImg5.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg5.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg5)
                    break
                case 5:
                    btnImg6.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg6.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg6)
                    break
                case 6:
                    btnImg7.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg7.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg7)
                    break
                case 7:
                    btnImg8.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg8.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg8)
                    break
                case 8:
                    btnImg9.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg9.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg9)
                    break
                case 9:
                    btnImg10.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg10.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg10)
                    break
                case 10:
                    btnImg11.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg11.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg11)
                    break
                case 11:
                    btnImg12.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg12.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg12)
                    break
                case 12:
                    btnImg13.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg13.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg13)
                    break
                default:
                    print(dict)
                }
                i += 1
            }
        }
    }
    
    func Layout9(arrBlock : [[String: Any]])
    {
        ConstraintCategoryTableY.constant = 8
        kidsView.isHidden = false
        btnImg1.isHidden = true
        btnImg2.isHidden = true
        btnImg3.isHidden = true
        btnImg4.isHidden = true
        btnImg5.isHidden = true
        btnImg6.isHidden = true
        btnImg7.isHidden = true
        btnImg8.isHidden = true
        btnImg9.isHidden = true
        btnImg10.isHidden = true
        btnImg11.isHidden = true
        btnImg12.isHidden = true
        btnImg13.isHidden = true
        
        if arrBlock.count != 0
        {
            var i = 0
            for  dict in arrBlock
            {
                switch i
                {
                case 0:
                    btnImg91.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg91.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg91)
                    break
                case 1:
                    btnImg92.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg92.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg92)
                    break
                case 2:
                    btnImg93.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg93.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg93)
                    break
                case 3:
                    btnImg94.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg94.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg94)
                    break
                case 4:
                    btnImg95.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg95.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg95)
                    break
                case 5:
                    btnImg96.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg96.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg96)
                    break
                case 6:
                    btnImg97.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg97.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg97)
                    break
                case 7:
                    btnImg98.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg98.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg98)
                    break
                case 8:
                    btnImg99.sd_setImage(with: URL(string:(dict[kimg] as? String)!), for: UIControlState.normal, placeholderImage: #imageLiteral(resourceName: "Place_Holder") )
                    btnImg99.accessibilityLabel = dict[kid] as? String
                    self.setConstraints(sender: btnImg99)
                    break
                default:
                    print(dict)
                }
                i += 1
            }
        }
    }
    
    func ClearButtonImages()
    {
        btnImg1 .setImage(UIImage(named:""), for: .normal)
        btnImg2 .setImage(UIImage(named:""), for: .normal)
        btnImg3 .setImage(UIImage(named:""), for: .normal)
        btnImg4 .setImage(UIImage(named:""), for: .normal)
        btnImg5 .setImage(UIImage(named:""), for: .normal)
        btnImg6 .setImage(UIImage(named:""), for: .normal)
        btnImg7 .setImage(UIImage(named:""), for: .normal)
        btnImg8 .setImage(UIImage(named:""), for: .normal)
        btnImg9 .setImage(UIImage(named:""), for: .normal)
        btnImg10 .setImage(UIImage(named:""), for: .normal)
        btnImg11 .setImage(UIImage(named:""), for: .normal)
        btnImg12 .setImage(UIImage(named:""), for: .normal)
        btnImg13 .setImage(UIImage(named:""), for: .normal)
        
        btnImg91 .setImage(UIImage(named:""), for: .normal)
        btnImg92 .setImage(UIImage(named:""), for: .normal)
        btnImg93 .setImage(UIImage(named:""), for: .normal)
        btnImg94 .setImage(UIImage(named:""), for: .normal)
        btnImg95 .setImage(UIImage(named:""), for: .normal)
        btnImg96 .setImage(UIImage(named:""), for: .normal)
        btnImg97 .setImage(UIImage(named:""), for: .normal)
        btnImg98 .setImage(UIImage(named:""), for: .normal)
        btnImg99 .setImage(UIImage(named:""), for: .normal)
        
    }
    
    func setConstraints(sender: UIButton)
    {
        contentView.frame.size.height = 1265
        tableCategory.frame.origin.y = 1017
        ConstraintCategoryTableY.constant = -(tableCategory.frame.origin.y-(sender.frame.origin.y +  sender.frame.size.height))
        ConstraintContentViewHeight.constant = (contentView.frame.size.height+ConstraintCategoryTableY.constant)
    }
    
    
    // MARK: - Section Header Delegate
    
    func toggleSection(header: CollapsibleTableViewHeader, section: Int)
    {
        if (indexSaved != section && header != headerSaved)
        {
            if  sections[indexSaved].collapsed == false
            {
                sections[indexSaved].collapsed = true
                headerSaved.setCollapsed(collapsed: true)
                tableCategory.beginUpdates()
                tableCategory.reloadSections(NSIndexSet(index: indexSaved) as IndexSet , with: .automatic)
                ConstraintContentViewHeight.constant = (ConstraintContentViewHeight.constant-CGFloat(sections[indexSaved].items.count * 40))
                tableCategory.endUpdates()
            }
            
        }
        
        let collapsed = !sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed: collapsed)
        
        // Adjust the height of the rows inside the section
        tableCategory.beginUpdates()
        for i in 0 ..< sections[section].items.count
        {
            tableCategory.reloadRows(at: [NSIndexPath.init(row: i, section: section) as IndexPath], with: .automatic)
        }
        ContraintCategoryTableHeight.constant = CGFloat(sections.count * 40+sections[section].items.count * 40)
        //print(ContraintCategoryTableHeight.constant)
        
        if collapsed
        {
            ConstraintContentViewHeight.constant = (ConstraintContentViewHeight.constant-CGFloat(sections[section].items.count * 40))
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        else
        {
            ConstraintContentViewHeight.constant = (ConstraintContentViewHeight.constant+CGFloat(sections[section].items.count * 40))
            scrollView.layoutSubviews()
            
            if ConstraintContentViewHeight.constant < (tableCategory.frame.origin.y + scrollView.bounds.height) {
                scrollView.setContentOffset(CGPoint.init(x: 0, y: ConstraintContentViewHeight.constant-scrollView.bounds.height), animated: true)
            }
            else {
               scrollView.setContentOffset(CGPoint.init(x: 0, y: tableCategory.frame.origin.y), animated: true)
            }
        }
        tableCategory.endUpdates()
        
        headerSaved = header
        indexSaved = section
    }
    
    // MARK: - Category button Method
    
    @IBAction func CategoryButtons(_ sender: UIButton)
    {
        if(sender.accessibilityLabel != nil)
        {
            strId = sender.accessibilityLabel!
            self.performSegue(withIdentifier: SegueListing, sender: self)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == SegueListing
        {
            if let destinationVC = segue.destination as? ListProductViewController
            {
                destinationVC.strID = strId
            }
        }
    }
}
extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width / 2 - 5, height : 40)
    }
}
extension HomeViewController : UITableViewDelegate,UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(sections.count != 0)
        {
            //print(sections[section].items)
            return sections[section].items.count
        }
        else
        {
            return sections.count
        }
    }
    
    // Cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:CategoryTableCell = tableView.dequeueReusableCell(withIdentifier: cCategoryTableCell) as! CategoryTableCell
        if(sections.count != 0)
        {
            let dict = sections[indexPath.section].items[indexPath.row]
            //print(dict)
            cell.imgCategory .sd_setImage(with: URL(string: (dict[kimage] as? String)!))
            cell.lblcategoryName!.text = dict[kname] as? String
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.contentView.backgroundColor = themeColor
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return sections[indexPath.section].collapsed! ? 0 : 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        if(sections.count != 0)
        {
            header.imageView.sd_setImage(with: URL(string: sections[section].image))
            header.titleLabel.text = sections[section].name
            header.setCollapsed(collapsed: sections[section].collapsed)
        }
        header.arrowLabel.setImage(#imageLiteral(resourceName: "ArrowWhite"), for: .normal)
        header.section = section
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 1.0
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dict = sections[indexPath.section].items[indexPath.row]
        strId = (dict[kcategory_id] as? String)!
        self.performSegue(withIdentifier: SegueListing, sender: self)
    }
}
extension HomeViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return  applicationDictionary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let collectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCollectionViewCell", for: indexPath) as! TopCollectionViewCell
        collectionViewCell.lblTab.text = applicationDictionary[indexPath.row][ktitle] as? String
        
        if selectedIndex == indexPath.row
        {
              collectionViewCell.cellImg .isHidden = false
        }
        else
        {
            collectionViewCell.cellImg .isHidden = true
        }
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.setPageLayout(applicationDictionary[indexPath.row])
        selectedIndex = indexPath.row
        self.topCollectionView.reloadData()
    }
}
