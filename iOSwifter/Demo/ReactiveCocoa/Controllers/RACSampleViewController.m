//
//  RACSampleViewController.m
//  iReactiveCocoa
//
//  Created by ZhangNing on 2016/12/18.
//  Copyright © 2016年 iSeen. All rights reserved.
//

#import "RACSampleViewController.h"
#import "RACSampleView.h"
#import "RACSampleViewModel.h"

@interface RACSampleViewController ()

@property (nonatomic, strong) RACSampleViewModel *viewModel;
@property (nonatomic, strong) RACSampleView *sampleLab;

@end

@implementation RACSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)btnAction:(UIButton *)sender {
    @weakify(self)
    [[self.viewModel.sampleCommand execute:nil] subscribeCompleted:^{
        @strongify(self)
        [self.view addSubview:self.sampleLab];
        self.sampleLab.labText = self.viewModel.dataSourceModel.sampleStr;
        sender.backgroundColor = [UIColor redColor];
    }];
}

- (RACSampleViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[RACSampleViewModel alloc] init];
    }
    return _viewModel;
}

- (RACSampleView *)sampleLab {
    if (!_sampleLab) {
        _sampleLab = [[RACSampleView alloc] initWithFrame:CGRectMake(10, 100, 300, 50)];
        _sampleLab.backgroundColor = [UIColor greenColor];
    }
    return _sampleLab;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
