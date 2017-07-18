//
//  TableViewController.swift
//  iRxSwift
//
//  Created by ZN on 2017/2/17.
//  Copyright © 2017年 iSeen. All rights reserved.
//

import UIKit
//import RxCocoa
import RxSwift
import RxDataSources

let identifier = "cellIdentifier"

class TableViewController: UIViewController {
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, RxUser>>()
    
    let viewModel = RxViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.addSubview(tableView)
        tableView.register(RxTableViewCell.self, forCellReuseIdentifier: identifier)
        
        dataSource.configureCell = {_, tableView, indexPath, user in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RxTableViewCell
            cell.tag = indexPath.row
            cell.user = user
            return cell
        }
        
        viewModel.getUsers()
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
    }
    
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: self.view.bounds, style: .plain)
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("Tab释放")
    }
}
