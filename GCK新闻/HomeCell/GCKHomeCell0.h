//
//  GCKHomeCell0.h
//  GCK新闻
//
//  Created by Harden on 2019/7/15.
//  Copyright © 2019 gck. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GCKNewsModel;
@interface GCKHomeCell0 : UITableViewCell
/**收藏按钮*/
@property(nonatomic,strong)UIButton*collectionbt;
/**新闻属性 */
@property(nonatomic,strong)GCKNewsModel *news;

@end


NS_ASSUME_NONNULL_END
