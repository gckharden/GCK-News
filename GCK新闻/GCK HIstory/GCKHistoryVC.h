//
//  GCKHistoryVC.h
//  GCK新闻
//
//  Created by Harden on 2019/7/12.
//  Copyright © 2019 gck. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GCKNewsModel;
@interface GCKHistoryVC : UIViewController
-(void)AddHistory:(GCKNewsModel *)news;
@end

NS_ASSUME_NONNULL_END
