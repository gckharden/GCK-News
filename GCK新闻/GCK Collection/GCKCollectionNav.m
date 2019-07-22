//
//  GCKCollectionNav.m
//  GCK新闻
//
//  Created by Harden on 2019/7/12.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKCollectionNav.h"
#import"GCKCollectionVC.h"
@interface GCKCollectionNav ()

@end

@implementation GCKCollectionNav

- (void)viewDidLoad
{
    [super viewDidLoad];
    //创建收藏界面
    GCKCollectionVC *collectionvc=[GCKCollectionVC new];
    //添加到导航控制器中
    [self addChildViewController:collectionvc];
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
