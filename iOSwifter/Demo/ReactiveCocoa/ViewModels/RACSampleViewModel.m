//
//  RACSampleViewModel.m
//  iReactiveCocoa
//
//  Created by ZhangNing on 2016/12/18.
//  Copyright © 2016年 iSeen. All rights reserved.
//

#import "RACSampleViewModel.h"
#import "RACSampleModel.h"

@implementation RACSampleViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUpCommand];
    }
    return self;
}

- (void)setUpCommand {
    self.sampleCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            //模拟2s网络请求
            [NSThread sleepForTimeInterval:2];
            //成功,处理数据....
            self.dataSourceModel.sampleStr = @"网络请求的数据";
            [subscriber sendCompleted];
            //失败
//            NSError *error;
//            [subscriber sendError:error];
            
            return [RACDisposable disposableWithBlock:^{
            }];
        }];
    }];
}

- (RACSampleModel *)dataSourceModel {
    if (!_dataSourceModel) {
        _dataSourceModel = [[RACSampleModel alloc] init];
    }
    return _dataSourceModel;
}

@end
