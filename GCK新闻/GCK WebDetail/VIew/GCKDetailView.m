//
//  GCKDetailView.m
//  GCK新闻
//
//  Created by Harden on 2019/7/19.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKDetailView.h"
#import"GCKNewsModel.h"
#import"UIImageView+AFNetworking.h"
#import "Masonry.h"
@interface GCKDetailView()
/**详情页view */
@property(nonatomic,strong)UIView*detailview;
/**第一张图片view */
@property(nonatomic,strong)UIImageView*fristimageview;
/**标题文字 */
@property(nonatomic,strong)UILabel*titlelabel;
/**内容文字 */
@property(nonatomic,strong)UILabel*contentlabel;
/**其他图片 */
@property(nonatomic,strong)UIScrollView*otherimagesview;
@end
@implementation GCKDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        //初始化第一张图片view
        [self SetUpFirstImageView];
        //初始化标题view
        [self SetUpTitleView];
         //初始化内容view
        [self SetUpContentLabel];
      //初始化其他图片view
        [self SetUpOtherImagview];
    }
    return self;
}
/**初始化标题view  */
-(void)SetUpTitleView
{
UILabel *titlelabel=[[UILabel alloc]init];
  self.titlelabel=titlelabel;
    //让字体自适应
    self.titlelabel.numberOfLines=0;
self.titlelabel.font=[UIFont systemFontOfSize:22];
//self.titlelabel.backgroundColor=[UIColor redColor];
[self addSubview:titlelabel];
}
/** 初始化第一张图片view*/
-(void)SetUpFirstImageView
{
    UIImageView *fristimageview=[[UIImageView alloc]init];
    self.fristimageview=fristimageview;
  //  self.fristimageview.backgroundColor=[UIColor yellowColor];
    [self  addSubview:fristimageview];
}
/** 初始化内容view*/
-(void)SetUpContentLabel
{
UILabel *contentlabel=[[UILabel alloc]init];
self.contentlabel=contentlabel;
    //让字体自适应
    self.contentlabel.numberOfLines=0;
//self.contentlabel.backgroundColor=[UIColor greenColor];
self.contentlabel.font=[UIFont systemFontOfSize:20];
[self  addSubview:contentlabel];
}
  //初始化其他图片view
-(void)SetUpOtherImagview
{
    UIScrollView *otherimagesview=[[UIScrollView alloc]init];
    self.otherimagesview=otherimagesview;
//    self.otherimagesview.backgroundColor=[UIColor blueColor];
    [self addSubview:otherimagesview];
}
/**设置子控件约束 */
-(void)layoutSubviews
{
    /**设置标题view约束 */
    [self LayouTitleLabel];
    /**设置第一张图片view约束 */
    [self LayouFirstImagview];
    /**设置内容view约束 */
    [self LayouContentview];
    /**设置其他图片view约束 */
    [self LayouOtherImagview];
}
/**设置标题view约束 */
 -(void)LayouTitleLabel
{
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.bottom.mas_equalTo(self.fristimageview.mas_top).offset(-5);
    }];
}
/**设置第一张图片view约束 */
-(void)LayouFirstImagview
{
    [self.fristimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentlabel.mas_top).offset(-5);
          make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.mas_equalTo(180);
        make.left.equalTo(self.titlelabel);
        make.right.equalTo(self.titlelabel);
    }];
}
/**设置内容view约束 */
-(void)LayouContentview
{
    [self.contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.otherimagesview.mas_top).offset(-5);
          make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.left.equalTo(self.titlelabel);
        make.right.equalTo(self.titlelabel);
    }];
}
/**设置其他图片view约束 */
-(void)LayouOtherImagview
{

    [self.otherimagesview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-180);
          make.height.mas_equalTo(180);
        make.left.equalTo(self.titlelabel);
        make.right.equalTo(self.titlelabel);
    }];
 //使其他图片view没有弹簧效果
    self.otherimagesview.bounces=NO;
}
//重写set方法
- (void)setNews:(GCKNewsModel *)news
{
    NSString *titletext=[news.title stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    NSString *contentext1=[news.content stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    NSString *contentext2=[contentext1 stringByReplacingOccurrencesOfString:@"&" withString:@"\""];
    self.titlelabel.text=titletext;
    self.contentlabel.text=contentext2;;
    //设置图片
    [self setimage:news];
    
}
/**设置图片view里的图片 */
- (void)setimage:(GCKNewsModel *)newsmodel
{
    //取到其他图片view的宽度
    CGFloat  width=[UIScreen mainScreen].bounds.size.width;
    //取到新闻图片数组
    NSArray *imageUrls=newsmodel.imageUrls;
    //取到新闻图片个数
    NSInteger  count=imageUrls.count;
    //如果没有图片就将内容上提
    if(count==0)
    {
        [self.contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(200);
            make.left.equalTo(self.titlelabel);
            make.right.equalTo(self.titlelabel);
            make.top.equalTo(self.titlelabel).offset(70);
        }];
    }
    else
    {
    for (NSInteger i=0; i<count;i++)
    {
        //设置第一张图片
           if(i==0)
          {
            [self.fristimageview setImageWithURL:[NSURL URLWithString:
                                                  imageUrls[0]] placeholderImage:[UIImage imageNamed: @"占位图片"]];
            }
        //设置其他图片
    else
          {
              //创建一个imageview
              UIImageView *imageview=[[UIImageView alloc]init];
              [imageview setImageWithURL:[NSURL URLWithString: imageUrls[i]] placeholderImage:[UIImage imageNamed: @"占位图片"]];
              //添加到其他图片view中
              [self.otherimagesview addSubview:imageview];
              //设置图片的frame
              imageview.frame=CGRectMake((i-1)*width, 0, width, 180);
           }
    }
    }
    //设置其他图片view的contentsize
    self.otherimagesview.contentSize=CGSizeMake((count-1)*width, 180);
}
@end
