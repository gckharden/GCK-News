//
//  GCKHomeCell0.m
//  GCK新闻
//
//  Created by Harden on 2019/7/15.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKHomeCell0.h"
#import"GCKNewsModel.h"
#import "GCKLabel.h"
#import"Masonry.h"
@interface GCKHomeCell0()
/**标题view  */
@property(nonatomic,strong)GCKLabel*titleview;
/**其他文字view*/
@property(nonatomic,strong)UILabel *othertext;
/**时间view  */
@property(nonatomic,strong)UILabel *timetext;
@property(nonatomic,strong)GCKNewsModel *collectionnews;
@end
@implementation GCKHomeCell0
//初始化l控制器
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        GCKLabel *titleview=[[GCKLabel alloc]init];
        self.titleview=titleview;
        self.titleview.font=[UIFont systemFontOfSize:20];
        [self.contentView addSubview:titleview];
        UILabel* othertext=[[UILabel alloc]init];
        othertext.font=[UIFont systemFontOfSize:15];
        othertext.textColor=[UIColor grayColor];
        self.othertext=othertext;
        [self.contentView addSubview:othertext];
        UILabel*timetext=[[UILabel alloc]init];
        self.timetext=timetext;
        timetext.font=[UIFont systemFontOfSize:15];
        timetext.textColor=[UIColor grayColor];
        [self.contentView addSubview:timetext];
        //初始化收藏按钮
        _collectionbt=[UIButton buttonWithType:UIButtonTypeCustom];
        [_collectionbt setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectionbt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _collectionbt.backgroundColor=[UIColor whiteColor];
        [_collectionbt setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_collectionbt];
    }
    return self;
}
//设置子控制器的frame
- (void)layoutSubviews
{
     //让标题view的长度自适应
    self.titleview.numberOfLines=0;
    //设定标题约束
    [self.titleview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10);
        make.bottom.mas_equalTo(self.othertext.mas_top).with.offset(-10);
        make.left.equalTo(self.contentView).with.offset(10);
        make.right.equalTo(self.contentView).with.offset(-10);
    }];
    //设置发布者约束
    [self.othertext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleview);
        make.top.mas_equalTo(self.titleview.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.right.mas_equalTo(self.timetext.mas_left).offset(-5);
    }];
    //设置时间文本约束
    [self.timetext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleview.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.right.mas_equalTo(self.contentView);
    }];
  
}
/**设置新闻属性 */
-(void)setNews:(GCKNewsModel *)newsmodel
{
    //替换标题文本框文字
    NSString *titletext=[newsmodel.title stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    self.titleview.text=titletext;
    //替换时间文本框的文字
  NSString *timetext=[newsmodel.publishDateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    self.timetext.text=timetext;
    self.othertext.text=newsmodel.posterScreenName;
   // 用一个属性关联着新闻模型
    self.collectionnews=newsmodel;
}

@end
