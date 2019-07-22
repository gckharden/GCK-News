//
//  GCKNewsModel.h
//  GCK新闻
//
//  Created by Harden on 2019/7/13.
//  Copyright © 2019 gck. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCKNewsModel : NSObject
/** 新闻标题*/
@property(nonatomic,copy)NSString* title;
/** 新闻内容*/
@property(nonatomic,copy)NSString* content;
/**新闻图片url数组*/
@property(nonatomic,strong)NSArray *imageUrls;
/** 新闻发布者*/
@property(nonatomic,copy)NSString*posterScreenName;
/** 新闻发布时间*/
@property(nonatomic,copy)NSString*publishDateStr ;
/** 新闻网址*/
@property(nonatomic,strong)NSString *url;
//创建一个快速创建模型的方法
+(instancetype)NewsWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
