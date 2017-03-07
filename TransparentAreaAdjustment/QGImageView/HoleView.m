//
//  HoleView.m
//  Zmodo
//
//  Created by Qinggong on 16/10/17.
//  Copyright © 2016年 Zmodo. All rights reserved.
//

#import "HoleView.h"

const CGFloat LineLength = 18.0;

@implementation HoleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    //画边线
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 1.0/[UIScreen mainScreen].scale);
    
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, rect.size.width, 0.0);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextAddLineToPoint(context, 0.0, rect.size.height);
    CGContextAddLineToPoint(context, 0.0, 0.0);
    
    CGContextStrokePath(context);
    CGContextRestoreGState(context);

    //画边角
    CGContextSetStrokeColorWithColor(context,  [UIColor redColor].CGColor);
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 3.0);
    
    //左上横线
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, LineLength, 0.0);
    //左上竖线
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, 0.0, LineLength);
    //右上横线
    CGContextMoveToPoint(context, rect.size.width - LineLength, 0.0);
    CGContextAddLineToPoint(context, rect.size.width, 0.0);
    //右上竖线
    CGContextMoveToPoint(context, rect.size.width, 0.0);
    CGContextAddLineToPoint(context, rect.size.width, LineLength);
    //左下横线
    CGContextMoveToPoint(context, 0.0, rect.size.height);
    CGContextAddLineToPoint(context, LineLength, rect.size.height);
    //左下竖线
    CGContextMoveToPoint(context, 0.0, rect.size.height - LineLength);
    CGContextAddLineToPoint(context, 0.0, rect.size.height);
    //右下横线
    CGContextMoveToPoint(context, rect.size.width - LineLength, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    //右下竖线
    CGContextMoveToPoint(context, rect.size.width, rect.size.height - LineLength);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    
    CGContextStrokePath(context);
}

@end
