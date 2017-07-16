//
//  RACSampleViewModel.h
//  iReactiveCocoa
//
//  Created by ZhangNing on 2016/12/18.
//  Copyright © 2016年 iSeen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RACSampleModel.h"

@interface RACSampleViewModel : NSObject

@property (nonatomic, strong) RACCommand *sampleCommand;
@property (nonatomic, strong) RACSampleModel *dataSourceModel;

@end
