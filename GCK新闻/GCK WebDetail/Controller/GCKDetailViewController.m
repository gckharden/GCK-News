//
//  GCKDetailViewController.m
//  GCK新闻
//
//  Created by Harden on 2019/7/19.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKDetailViewController.h"
#import "GCKDetailView.h"
@interface GCKDetailViewController ()

@end

@implementation GCKDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建详情页view
    GCKDetailView *detailview=[[GCKDetailView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //设置view的背景色为白色
    detailview.backgroundColor=[UIColor whiteColor];
    //将新闻模型赋值给详情页view
    detailview.news=self.news;
    //设置为本控制器子view
    [self.view addSubview:detailview];
    // Do any additional setup after loading the view.
}



@end
