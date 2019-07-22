//
//  GCKWebController.m
//  GCK新闻
//
//  Created by Harden on 2019/7/19.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKWebController.h"
#import "GCKWKWebView.h"
#import "GCKDetailViewController.h"
#import "GCKNewsModel.h"
@interface GCKWebController()
@property(nonatomic,strong)GCKWKWebView *webview;
@end
@implementation GCKWebController
- (void)viewDidLoad
{
    //加载webview
    [self LoadWebview];
    //设置返回按钮
    [self  SetBackButton];
    //设置详情按钮
    [self setDetailButton];
}
-(void)LoadWebview
{
    //1让web从tabbar下面开始布局
    self.navigationController. navigationBar.translucent = NO;
    //2、获取容器的宽，准备赋值给WKWebView
    CGFloat width = self.view.frame.size.width;
    //3、获取容器的高，准备赋值给WKWebView
    CGFloat height = self.view.frame.size.height;
    //4、根据获取到的宽高初始化将要使用的WKWebView对象
    self.webview = [[GCKWKWebView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    //5.设置自己的view为本控制器的子view
    [self.view addSubview:self.webview];
   //6.加载url
    [self LoadUrl];
}
/** 加载url*/
-(void)LoadUrl
{
    NSURL *url=[NSURL URLWithString:self.news.url];
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];

}
/** 设置返回按钮*/
-(void)SetBackButton
{
  //创建按钮
    UIBarButtonItem *backbuttonitem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(Back) ];
    //设置为返回按钮
    self. navigationItem.leftBarButtonItem=backbuttonitem;
    
}
/** 设置详情页按钮*/
-(void)setDetailButton
{
//创建按钮
UIBarButtonItem *rightbuttonitem=[[UIBarButtonItem alloc]initWithTitle:@"详情" style:UIBarButtonItemStyleDone target:self action:@selector(PushToDetail) ];
//设置为返回按钮
self. navigationItem.rightBarButtonItem=rightbuttonitem;
}
  /**返回 */
-(void)Back
{
    //出栈
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)PushToDetail
{
    //创建详情页控制器
    GCKDetailViewController *detailvc=[GCKDetailViewController new];
    //将新闻模型赋值给详情页控制器
    detailvc.news=self.news;
    //push到详情页
    [self.navigationController pushViewController:detailvc animated:YES];
}
@end
