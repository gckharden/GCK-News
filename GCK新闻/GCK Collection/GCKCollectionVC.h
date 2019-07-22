//
//  GCKCollectionVC.h
//  GCK新闻
//
//  Created by Harden on 2019/7/12.
//  Copyright © 2019 gck. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCKNewsModel;
NS_ASSUME_NONNULL_BEGIN
@interface GCKCollectionVC : UIViewController
/** 一个收藏新闻的接口方法*/
-(void)CollectNews:(GCKNewsModel *)news;

-(void)ReloadData;
@end

NS_ASSUME_NONNULL_END
