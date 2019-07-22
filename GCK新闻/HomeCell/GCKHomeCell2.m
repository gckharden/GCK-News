//
//  GCKHomeCell2.m
//  GCK新闻
//
//  Created by Harden on 2019/7/15.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKHomeCell2.h"
#import "GCKLabel.h"
#import "GCKNewsModel.h"
#import"UIImageView+AFNetworking.h"
#import "Masonry.h"
@interface GCKHomeCell2()
/**标题view */
@property(nonatomic,strong)GCKLabel*titleview;
/** 其他文字view*/
@property(nonatomic,strong)UILabel *othertext;
/** 时间view*/
@property(nonatomic,strong)UILabel *timetext;
/**存放图片view的数组 */
@property(nonatomic,strong)NSMutableArray *iconArr;
@end
@implementation GCKHomeCell2
-(NSMutableArray *)iconArr
{
    if(!_iconArr)
    {
        _iconArr=[NSMutableArray array];
    }
    return _iconArr;
}
/** 初始化子控制器 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //初始化标题view
        GCKLabel *titleview=[[GCKLabel alloc]init];
        self.titleview=titleview;
        self.titleview.font=[UIFont systemFontOfSize:18];
        [self.contentView addSubview:titleview];
        //初始化其他文字view
        UILabel* othertext=[[UILabel alloc]init];
        othertext.font=[UIFont systemFontOfSize:15];
        othertext.textColor=[UIColor grayColor];
        self.othertext=othertext;
        [self.contentView addSubview:othertext];
        //初始化其他文字label
        UILabel*timetext=[[UILabel alloc]init];
        self.timetext=timetext;
        timetext.font=[UIFont systemFontOfSize:15];
        timetext.textColor=[UIColor grayColor];
        [self.contentView addSubview:timetext];
        //将第一个图片view放入数组中
        UIImageView *newsicon1=[[UIImageView alloc]init];
        [self.iconArr addObject:newsicon1];
        [self.contentView addSubview:newsicon1];
         NSLog(@"%@",self.iconArr[0]);
        UIImageView *newsicon2=[[UIImageView alloc]init];
        //将第二个图片view放入数组中
       [self.iconArr addObject:newsicon2];
        [self.contentView addSubview:newsicon2];
        //初始化收藏按钮
        _collectionbt=[UIButton buttonWithType:UIButtonTypeCustom];
        [_collectionbt setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectionbt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _collectionbt.backgroundColor=[UIColor whiteColor];
        [_collectionbt setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_collectionbt];

    }
    return  self;
}
/**设置子控制器的frame  */
- (void)layoutSubviews
{
    //设置行数,选择0的话会根据自适应
    self.titleview.numberOfLines=0;
    //获取两个图片
    UIImageView *newsicon1=self.iconArr[0];
    UIImageView *newsicon2=self.iconArr[1];
    //设置titleview的约束
    [self.titleview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(5);
        make.bottom.mas_equalTo(newsicon1.mas_top);
        make.left.equalTo(self.contentView).with.offset(10);
        make.right.equalTo(self.contentView).with.offset(-15);
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
        make.bottom.equalTo(self.othertext);
        make.top.equalTo(self.othertext);
    }];
    //设置图片1约束
    [newsicon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.othertext.mas_top).offset(-5);
        make.right.mas_equalTo(self.contentView.mas_centerX).offset(-10);
        make.height.mas_equalTo(70);
   make.left.mas_equalTo(self.contentView.mas_centerX).multipliedBy(0.5);
    }];
    //设置图片1约束
    [newsicon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.othertext.mas_top).offset(-5);
        make.width.equalTo(newsicon1);
        make.top.equalTo(newsicon1);
        make.left.mas_equalTo(newsicon1.mas_right).offset(5);
    }];
}

/** 设置news属性  */
-(void)setNews:(GCKNewsModel *)newsmodel
{
    //替换标题里的文字
    NSString *titletext=[newsmodel.title stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    self.titleview.text=titletext;
    //替换时间文本里的文字
    NSString *timetext=[newsmodel.publishDateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    self.timetext.text=timetext;
    self.othertext.text=newsmodel.posterScreenName;
    //设置图片
    [self setimage:newsmodel];
}
/**设置图片view里的图片 */
- (void)setimage:(GCKNewsModel *)newsmodel
{
    NSLog(@"%@",self.iconArr[0]);
    //取到新闻图片数组
    NSArray *imageUrls=newsmodel.imageUrls;
    //设置第一张图片
    [self.iconArr[0] setImageWithURL:[NSURL URLWithString:  imageUrls[0]] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    //设置第二张图片
    [self.iconArr[1] setImageWithURL:[NSURL URLWithString:  imageUrls[1]] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    
}


@end
