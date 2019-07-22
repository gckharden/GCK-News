//
//  GCKtabBarVC.m
//  GCK新闻
//
//  Created by Harden on 2019/7/12.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKtabBarVC.h"
#import "GCKTabBar.h"
#import "GCKHomePageNav.h"
#import "GCKHomePageVC.h"
#import "GCKVedioNav.h"
#import"GCKVedioVC.h"
#import "GCKCollectionNav.h"
#import"GCKCollectionVC.h"
#import "GCKHistoryNav.h"
#import "GCKHistoryVC.h"
@interface GCKtabBarVC ()
@property(nonatomic,strong)GCKTabBar *tabbar;
@end

@implementation GCKtabBarVC
/**懒加载tabbaritems */
-(NSMutableArray *)tabBaritems
{
    if(!_tabBaritems)
    {
        _tabBaritems=[NSMutableArray array];
    }
    return _tabBaritems;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    //创建所有控制器
    [self SetUpAllControllers];
    //创建 tabbar
   // [self SetUpTabBar];
    
}
//添加所有的控制器
-(void)SetUpAllControllers
{
    [self SetUpHomePage];
    [self SetUpCollection];
    [self SetUpVedio];
    [self SetUpHistory];
}
//添加一个子控制器的方法
-(void)SetUpOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(UIImage *)image selimage:(UIImage *)selimage
{
    //添加子控制器
    [self addChildViewController:vc];
    //将传递过来的参数赋值到vc的tabitem中
    vc.tabBarItem.title=title;
    vc.tabBarItem.image=image;
    vc.tabBarItem.selectedImage=selimage;
    
}
    //添加主页界面
-(void)SetUpHomePage
{
    GCKHomePageVC *homevc=[[GCKHomePageVC alloc]init];
    GCKHomePageNav *homenav=[[GCKHomePageNav alloc]initWithRootViewController:homevc];
    [self SetUpOneChildViewController:homenav title:@"主页" image:[UIImage imageNamed:@"主页"] selimage:[UIImage imageNamed:@"主页"]];;
}
//创建收藏界面
-(void) SetUpCollection
{
    GCKCollectionVC *collectionvc=[[GCKCollectionVC alloc]init];
    GCKCollectionNav *collectionnav=[[GCKCollectionNav alloc]initWithRootViewController:collectionvc];
    [self SetUpOneChildViewController:collectionnav title:@"收藏" image:[UIImage imageNamed:@"收藏"] selimage:[UIImage imageNamed:@"收藏"]];
}
    //创建视频界面
-(void)SetUpVedio
{
    GCKVedioVC *vediovc=[[GCKVedioVC alloc]init];
    GCKVedioNav *vedionav=[[GCKVedioNav alloc]initWithRootViewController:vediovc];
    [self SetUpOneChildViewController:vedionav title:@"视频" image:[UIImage imageNamed:@"视频"] selimage:[UIImage imageNamed:@"视频"]];
}
  //创建历史记录界面
-(void)SetUpHistory
  {
      GCKHistoryVC *historyvc=[[GCKHistoryVC alloc]init];
      GCKHistoryNav *historynav=[[GCKHistoryNav alloc]initWithRootViewController:historyvc];
      [self SetUpOneChildViewController:historynav title:@"历史" image:[UIImage imageNamed:@"历史"] selimage:[UIImage imageNamed:@"历史"]];
  }

@end
