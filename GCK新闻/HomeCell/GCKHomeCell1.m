//
//  GCKHomeCell1.m
//  GCK新闻
//
//  Created by Harden on 2019/7/15.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKHomeCell1.h"
#import "GCKNewsModel.h"
#import"GCKLabel.h"
#import "Masonry.h"
#import"UIImageView+AFNetworking.h"

@interface GCKHomeCell1()
/** 标题view*/
@property(nonatomic,strong)GCKLabel *titleview;
/**其他文字view*/
@property(nonatomic,strong)UILabel *othertext;
/**时间view*/
@property(nonatomic,strong)UILabel *timetext;
/** 图片view*/
@property(nonatomic,strong)UIImageView *newsicon;

@end
@implementation GCKHomeCell1
/** 初始化子控制器 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加标题view
        GCKLabel * titleview=[[GCKLabel alloc]init];
        self.titleview=titleview;
        self.titleview.font=[UIFont systemFontOfSize:20];
        [self.contentView addSubview:titleview];
        //添加新闻图片view
        UIImageView *newsicon=[[UIImageView alloc]init];
        self.newsicon=newsicon;
        [self.contentView addSubview:newsicon];
        //添加其他文字view
        UILabel* othertext=[[UILabel alloc]init];
        othertext.font=[UIFont systemFontOfSize:15];
        othertext.textColor=[UIColor grayColor];
        self.othertext=othertext;
        [self.contentView addSubview:othertext];
        //添加timeview
        UILabel*timetext=[[UILabel alloc]init];
        self.timetext=timetext;
        timetext.font=[UIFont systemFontOfSize:15];
        timetext.textColor=[UIColor grayColor];
        [self.contentView addSubview:timetext];
        //添加收藏按钮
        _collectionbt=[UIButton buttonWithType:UIButtonTypeCustom];
        [_collectionbt setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectionbt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _collectionbt.backgroundColor=[UIColor whiteColor];
        [_collectionbt setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_collectionbt];
    }
    return self;
}
/**设置子控制器的frame  */
-(void)layoutSubviews
{
    //设置行数,选择0的话会根据自适应
    self.titleview.numberOfLines=0;
    //设置titleview的约束
    [self.titleview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10);
        make.bottom.mas_equalTo(self.othertext.mas_top).with.offset(-15);
        make.left.equalTo(self.contentView).with.offset(10);
        make.right.mas_equalTo(self.newsicon.mas_left).with.offset(-10);
    }];
    //设置其他文字约束
    [self.othertext  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-5);
        make.left.equalTo(self.titleview);
        make.right.mas_equalTo(self.timetext.mas_left).offset(-5);
    }];
    //设置时间文字的约束
    [self.timetext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.othertext);
        make.right.equalTo(self.titleview);
        make.bottom.equalTo(self.timetext);
    }];
    //设置图片约束
    [self.newsicon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(12);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.left.mas_equalTo(self.contentView.mas_right).offset(-120);
    }];
}
/** 设置news属性  */
-(void)setNews:(GCKNewsModel *)newsmodel
{
    //替代标题文本框里的文字
    NSString *titletext=[newsmodel.title stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    self.titleview.text=titletext;
    //替代时间文本框里的文字
    NSString *timetext=[newsmodel.publishDateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    self.timetext.text=timetext;
    self.othertext.text=newsmodel.posterScreenName;
    //设置图片
    [self setimage:newsmodel];
}
/**设置图片view里的图片 */
- (void)setimage:(GCKNewsModel *)newsmodel
{
    //取到新闻图片数组
    NSArray *imageUrls=newsmodel.imageUrls;
    //设置图片
    [self.newsicon setImageWithURL:[NSURL URLWithString:  imageUrls[0]] placeholderImage:[UIImage imageNamed:@"占位图片"]];
}


@end
