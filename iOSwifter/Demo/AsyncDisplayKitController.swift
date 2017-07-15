//
//  AsyncDisplayKitController.swift
//  CoderStars
//
//  Created by ZN on 2017/4/22.
//  Copyright © 2017年 iSeen. All rights reserved.
//  官方文档 http://texturegroup.org/docs/getting-started.html

import UIKit
import AsyncDisplayKit

class AsyncDisplayKitController: UIViewController, ASTableDelegate, ASTableDataSource {

    let tableNode = ASTableNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.backgroundColor = UIColor.white
        tableNode.view.tableFooterView = UIView()
        view.addSubview(tableNode.view)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableNode.frame = view.bounds
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return CustomCellNode()
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


class CustomCellNode: ASCellNode {
    
    let iconImageView = ASImageNode()
    let titleLabel = ASTextNode()
    
    override init() {
        super.init()
        iconImageView.image = UIImage.as_imageNamed("voice")
        addSubnode(iconImageView)
        
        titleLabel.backgroundColor = UIColor.blue
        titleLabel.attributedText = NSAttributedString(string: "我是标题sfmksfmsldfmslfmlskdfmksmldfmslkfdlskmflks;ldkfmslkf", attributes: [
            NSForegroundColorAttributeName: UIColor.orange,
            NSFontAttributeName: UIFont.systemFont(ofSize: 12)
            ])
        addSubnode(titleLabel)
    }
    
    //计算cell高度并返回
    override func calculateSizeThatFits(_ constrainedSize: CGSize) -> CGSize {
        return CGSize(width: constrainedSize.width, height: 70)
    }
    
    //布局
    override func layout() {
        iconImageView.frame = CGRect(x: 10, y: 5, width: 40, height: 40)
        titleLabel.frame = CGRect(x: 10 + 40 + 10, y: 10, width: self.calculatedSize.width - 70, height: 50)
    }
}
