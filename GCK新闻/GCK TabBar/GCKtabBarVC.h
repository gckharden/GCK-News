//
//  GCKtabBarVC.h
//  GCK新闻
//
//  Created by Harden on 2019/7/12.
//  Copyright © 2019 gck. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface GCKtabBarVC : UITabBarController
/** tabbaritem数组  */
@property(nonatomic,strong)NSMutableArray *tabBaritems;
-(void)SetUpOneChildViewController:(UIViewController *)vc title:(NSString *)title  image:(UIImage *) image selimage:(UIImage *)selimage;
@end

NS_ASSUME_NONNULL_END
