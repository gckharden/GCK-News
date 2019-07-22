//
//  GCKHistoryNav.m
//  GCK新闻
//
//  Created by Harden on 2019/7/12.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKHistoryNav.h"
#import "GCKHistoryVC.h"

@interface GCKHistoryNav ()

@end

@implementation GCKHistoryNav

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建历史界面
    GCKHistoryVC *historyvc=[GCKHistoryVC new];
    //添加子控制器
    [self addChildViewController:historyvc];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
