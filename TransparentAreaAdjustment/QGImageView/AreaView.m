//
//  AreaView.m
//  Zmodo
//
//  Created by Qinggong on 16/10/17.
//  Copyright © 2016年 Zmodo. All rights reserved.
//

#import "AreaView.h"

@interface AreaView ()

@property (assign, nonatomic) CGRect holeRect;

@end

@implementation AreaView

- (void)drawRect:(CGRect)rect {
    [[UIColor colorWithWhite:0.0f alpha:0.5f] setFill];//阴影效果 根据透明度来设计
    UIRectFill(rect);
    CGRect holeRectIntersection = CGRectIntersection(self.holeRect, rect);
    [[UIColor clearColor] setFill];
    UIRectFill(holeRectIntersection);
}

- (void)resizeWithRect:(CGRect)holeRect
{
    self.holeRect = holeRect;
    [self setNeedsDisplay];
}

@end
