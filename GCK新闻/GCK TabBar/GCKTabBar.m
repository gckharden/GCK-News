//
//  GCKTabBar.m
//  GCK新闻
//
//  Created by Harden on 2019/7/17.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKTabBar.h"
#import"GCKTabBarBtn.h"
#import "Masonry.h"
@implementation GCKTabBar


- (void)setItems:(NSMutableArray *)items
{
    _items=items;
    for (int i=0; i<_items.count; i++) {
        //添加子控制器
        GCKTabBarBtn *button=[GCKTabBarBtn new];
        //将按钮添加到tabbar
        [self addSubview:button];
        //取到每个item
        UITabBarItem *tabbarItem=self.items[i];
        //设置两种状态下的图片
        [button setBackgroundImage:tabbarItem.image forState:UIControlStateNormal];
        [button setBackgroundImage:tabbarItem.selectedImage forState:UIControlStateSelected];
        
        button.backgroundColor=[UIColor redColor];
        
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //获取按钮个数
    NSInteger  count=self.subviews.count;
    //设置子控件约束
    for(int i=0;i<count;i++)
    {
        //获取每个按钮
        UIButton *btn=self.subviews[i];
        if(i<count-1)
        {
        UIButton *rightbtn=self.subviews[i+1];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.width.equalTo(self.mas_width).multipliedBy(1.0/count);
            make.right.equalTo(rightbtn.mas_left);
        }];
    }
        else
        {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top);
                make.bottom.equalTo(self.mas_bottom);
                make.width.equalTo(self.mas_width).multipliedBy(1.0/count);
                make.right.equalTo(self.mas_right);
            }];
      }
    }
}
@end
