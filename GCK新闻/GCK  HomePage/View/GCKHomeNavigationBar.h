//
//  GCKHomeNavigationBar.h
//  GCK新闻
//
//  Created by Harden on 2019/7/18.
//  Copyright © 2019 gck. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol GCKTabBarDelegate <NSObject>
-(void)search;

@end
@interface GCKHomeNavigationBar : UINavigationBar
@property(nonatomic,weak)id <GCKTabBarDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
