//
//  ZNSwiftTableViewController.swift
//  iOSwift
//
//  Created by ZhangNing on 2016/11/21.
//  Copyright © 2016年 iSeen. All rights reserved.
//

import UIKit

class ZNSwiftTableViewController: UITableViewController {
    
    let cellIdentifer = "cellIdentifer"
    
    var titleArr: [[[String: String]]] = [
        [
            ["className": "AnimationController", "title":"CAAnimation"]
        ]
    ]
    
    var sectionTitleArr = ["动画"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "示例"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return titleArr.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tempArray = self.titleArr[section]
        return tempArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempArray = self.titleArr[indexPath.section]
        let tempDic = tempArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
        cell.textLabel?.text = tempDic["title"]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tempArray = self.titleArr[indexPath.section]
        let tempDic = tempArray[indexPath.row]
        let nameSpace = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
        
        guard let clsName = tempDic["className"],
            let cls = NSClassFromString(nameSpace + "." + clsName) as? UIViewController.Type
            else {
            return
        }
        
        let vc = cls.init()
        vc.title = tempDic["title"]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleArr[section]
    }
}
