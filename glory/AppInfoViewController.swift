//
//  AppInfoViewController.swift
//  Chnen
//
//  Created by navjot_sharma on 12/15/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

class AppInfoViewController: UIViewController
{
    var arrAppInfo = [String]()
    var arrAppDetailInfo = [String]()
    
    @IBOutlet weak var tableAppInfo: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrAppInfo = [AppName,AppVersion,ApiEnvironment]
        arrAppDetailInfo = [Chnen,"1.0",Live]
        print(arrAppInfo)
        tableAppInfo.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Back button
    
    @IBAction func BackButton(_ sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AppInfoViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrAppInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:AppInfoCell = tableView.dequeueReusableCell(withIdentifier: cAppInfoCell) as! AppInfoCell
        cell.TitleLabel .text = arrAppInfo[indexPath.row]
        cell.detailLabel .text = arrAppDetailInfo[indexPath.row]
        cell.selectionStyle = .none
        tableView.tableFooterView = UIView()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 54
    }
}
