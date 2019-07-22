//
//  GCKHomeNavigationBar.m
//  GCK新闻
//
//  Created by Harden on 2019/7/18.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKHomeNavigationBar.h"
#import"Masonry.h"
#import "GCKColorTool.h"
@interface GCKHomeNavigationBar()
/**搜索框  */
@property(nonatomic,strong)UITextField*homesearchtextfield;
/**logo  */
@property(nonatomic,strong)UIImageView *logoimageview;
@end
@implementation GCKHomeNavigationBar
// 初始化子控制器
- (instancetype)initWithFrame:(CGRect)frame
{
     if (self=[super initWithFrame:(CGRect)frame])
     {
         //创建搜索框
         UITextField *homesearchtextfield=[UITextField new];
         self.homesearchtextfield=homesearchtextfield;
         //将搜索框添加到navbar中
         [self addSubview:homesearchtextfield];
         //设置搜索框背景颜色
         homesearchtextfield.backgroundColor=[GCKColorTool colorWithHexString:@"#f4f5f7" alpha:1.0 ];
         //设置搜索框默认字
         homesearchtextfield.placeholder=@"搜索";
         //设置搜索框颜色
         homesearchtextfield.tintColor=[UIColor blueColor];
         //设置搜索框文字向左对齐
         homesearchtextfield.textAlignment=NSTextAlignmentLeft;
          //  设置搜索框样式
    homesearchtextfield.borderStyle=UITextBorderStyleRoundedRect;
         
         [homesearchtextfield addTarget:self action:@selector(TextFieldTouch) forControlEvents:UIControlEventTouchDown];
         //创建左边的标志
         UIImageView *logoimageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"腾讯新闻"]];
         //添加到view中
         [self addSubview:logoimageview];
        //用一个属性关联
         self.logoimageview=logoimageview;
     }
    return self;
}

//设置子控制器约束
- (void)layoutSubviews
{
    //设置搜索框约束
    [self.homesearchtextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(50);
        make.bottom.equalTo(self).offset(-5);
        make.right.equalTo(self).offset(-10);
    }];
    //设置logo约束
    [self.logoimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.width.mas_equalTo(32);
    make.right.mas_equalTo(self.homesearchtextfield.mas_left).offset(-10);
        make.top.equalTo(self.homesearchtextfield);
        make.bottom.equalTo(self.homesearchtextfield);
        
    }];
}
-(void)TextFieldTouch
{
    [self.delegate  search];
}
@end
