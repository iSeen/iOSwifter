//
//  ViewModel.swift
//  iRxSwift
//
//  Created by ZN on 2017/2/16.
//  Copyright © 2017年 iSeen. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class RxViewModel: NSObject {
    
    func getUsers() -> Observable<[SectionModel<String, RxUser>]> {
        return Observable.create({ (observer) -> Disposable in
            let users = [
                RxUser(followersCount: 19_901_990, followingCount: 1990, screenName: "Marco Sun"),
                RxUser(followersCount: 19_890_000, followingCount: 1989, screenName: "Taylor Swift"),
                RxUser(followersCount: 250_000, followingCount: 25, screenName: "Rihanna")]
            
            let section = [SectionModel(model: "", items: users)]
            observer.onNext(section)
            observer.onCompleted()
            return Disposables.create()
        })
    }
}
