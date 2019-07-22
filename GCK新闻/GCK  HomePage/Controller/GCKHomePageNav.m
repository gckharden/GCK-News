//
//  GCKHomePageNav.m
//  GCK新闻
//
//  Created by Harden on 2019/7/12.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKHomePageNav.h"
#import"GCKHomePageVC.h"

@interface GCKHomePageNav ()

@end

@implementation GCKHomePageNav

- (void)viewDidLoad
{
    [super viewDidLoad];
    //创建主页控制器
    GCKHomePageVC *homevc=[[GCKHomePageVC alloc]init];
    //将控制器添加的导航控制器中
    [self addChildViewController:homevc];
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
