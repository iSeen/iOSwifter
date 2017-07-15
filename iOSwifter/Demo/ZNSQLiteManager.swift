//
//  ZNSQLiteManager.swift
//  iOSwift
//
//  Created by ZN on 16/10/12.
//  Copyright © 2016年 iSeen. All rights reserved.
//

import UIKit
import FMDB

let QUESTION_LIST = "question_list"   // 题目 数据表

class ZNSQLiteManager: NSObject {
    
    static let shareManager = ZNSQLiteManager()   // FMDB单例
    
    private let sqliteDBName = "question.db"      // sqlite数据库名
    
    let dbQueue: FMDatabaseQueue
    
    override init() {
        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let dbPath = "\(documentPath)/\(sqliteDBName)"
        
        print(dbPath)
        
        // 根据路径打开数据库, 开启一个串行队列
        dbQueue = FMDatabaseQueue(path: dbPath)
        super.init()

        // 创建数据库表
        creatQuestionTable(tableName: QUESTION_LIST)
    }
    
    private func creatQuestionTable(tableName: String) {
        
        let sql = "CREATE TABLE IF NOT EXISTS \(tableName) ( \n" +
            "id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, \n" +
            "questionid INTEGER, \n" +
            "question TEXT, \n"
        
        dbQueue.inDatabase { (db) in
            if (db?.executeStatements(sql))! {
                print("\(tableName)表创建成功")
            } else {
                print("\(tableName)表创建失败")
            }
        }
        
    }
}
