//
//  AnimationController.swift
//  iOSwift
//
//  Created by ZN on 16/12/5.
//  Copyright © 2016年 iSeen. All rights reserved.
//

import UIKit

class AnimationController: UIViewController {
    
    let cellIdentifer = "cellIdentifer"
    
    var titleArr: [[[String: String]]] = [
        [
            ["className": "CABasicAnimationController", "title":"CABasicAnimation"],
            ["className": "CASpringAnimViewController", "title":"CABasicAnim子类CASpringAnim"],
            ["className": "CAKeyframeAnimationController", "title":"CAKeyframeAnimation"]
        ],
        [
            ["className": "CATransitionController", "title":"CATransition"]
        ],
        [
            ["className": "CAAnimationGroupController", "title":"CAAnimationGroup"]
        ],
        [
            ["className": "FireAnimController", "title":"Fire"],
            ["className": "DrawLineController", "title":"DrawLine"],
            ["className": "DrawViewController", "title":"Draw"], //oc
            ["className": "ZNSphereController", "title":"Sphere"],
            ["className": "WaterWaveController", "title":"WaterWave"]
        ]
    ]
    let sectionTitleArray = ["CAPropertyAnimation", "CATransition", "CAAnimationGroup", "动效"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        view.addSubview(tableView)
    }
    
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AnimationController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempArr = titleArr[indexPath.section]
        let tempDic = tempArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
        cell.textLabel?.text = tempDic["title"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tempDic = titleArr[indexPath.section][indexPath.row]
        let nameSpace = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
        
        guard let clsName = tempDic["className"],
            let cls = NSClassFromString(nameSpace + "." + clsName) as? UIViewController.Type
            else {
                
                if tempDic["className"] == "DrawViewController" {
                    let clas = NSClassFromString("DrawViewController") as! UIViewController.Type
                    let vc = clas.init()
                    vc.title = tempDic["title"]
                    navigationController?.pushViewController(vc, animated: true)
                }
                
                return
        }
        
        let vc = cls.init()
        vc.title = tempDic["title"]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleArray[section]
    }
}
