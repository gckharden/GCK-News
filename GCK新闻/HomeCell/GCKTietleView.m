//
//  GCKTietleView.m
//  GCK新闻
//
//  Created by Harden on 2019/7/15.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKTietleView.h"

@implementation GCKTietleView

//重写label里的文字对齐方式
- (void)drawTextInRect:(CGRect)rect {
    CGRect actualRect = [self textRectForBounds:rect
                                   limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
