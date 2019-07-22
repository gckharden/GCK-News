//
//  GCKLabel.m
//  GCK新闻
//
//  Created by Harden on 2019/7/17.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKLabel.h"

@implementation GCKLabel


- (void)drawTextInRect:(CGRect)rect
{
    CGRect actualRect = [self textRectForBounds:rect
                         limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
