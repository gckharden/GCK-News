//
//  GCKWebController.h
//  GCK新闻
//
//  Created by Harden on 2019/7/19.
//  Copyright © 2019 gck. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GCKNewsModel;
@interface GCKWebController :UIViewController
/**新闻模型 */
@property(nonatomic,strong)GCKNewsModel *news;

@end

NS_ASSUME_NONNULL_END
