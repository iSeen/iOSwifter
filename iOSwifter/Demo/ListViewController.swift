//
//  ViewController.swift
//  iRxSwift
//
//  Created by ZN on 2017/2/16.
//  Copyright © 2017年 iSeen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cellIdentifer = "cellIdentifer"
    
    var titleArr: [[[String: String]]] = [
        [
            ["className": "TableViewController", "title": "TableView"],
            ["className": "ConceptController", "title": "概念(查看代码)"],
            ["className": "POPViewController", "title": "面向协议编程"]
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "RxSwift"
        
        view.addSubview(tableView)
    }
    
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifer)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tempArray = self.titleArr[section]
        return tempArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempArray = self.titleArr[indexPath.section]
        let tempDic = tempArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
        cell.textLabel?.text = tempDic["title"]
        return cell
    }
}
