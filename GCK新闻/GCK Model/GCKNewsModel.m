//
//  GCKNewsModel.m
//  GCK新闻
//
//  Created by Harden on 2019/7/13.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKNewsModel.h"
@implementation GCKNewsModel
+(instancetype)NewsWithDict:(NSDictionary *)dict
{
    GCKNewsModel *news=[[self alloc]init];
    [news setValuesForKeysWithDictionary:dict];
    return news;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // do nothing
}
@end
