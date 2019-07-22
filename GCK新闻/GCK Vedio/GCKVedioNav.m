//
//  GCKVedioNav.m
//  GCK新闻
//
//  Created by Harden on 2019/7/12.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKVedioNav.h"
#import"GCKVedioVC.h"

@interface GCKVedioNav ()

@end

@implementation GCKVedioNav

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建视频控制器
    GCKVedioVC *vediovc=[[GCKVedioVC alloc]init];
    //将控制器添加的导航控制器中
    [self addChildViewController:vediovc];
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
