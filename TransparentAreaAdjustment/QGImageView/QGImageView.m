//
//  QGImageView.m
//  TransparentAreaAdjustment
//
//  Created by Qinggong on 2017/3/7.
//  Copyright © 2017年 Qinggong. All rights reserved.
//

#import "QGImageView.h"
#import "AreaView.h"
#import "HoleView.h"

const CGFloat FingerWidth = 40.0;

@interface QGImageView ()

@property (weak, nonatomic) AreaView *areaView;
@property (weak, nonatomic) HoleView *holeView;

@end

@implementation QGImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        //半透明遮盖和透明侦测区域
        AreaView *areaView = [[AreaView alloc]initWithFrame:self.bounds];
        areaView.backgroundColor = [UIColor clearColor];
        areaView.opaque =NO;
        [self addSubview:areaView];
        self.areaView = areaView;
        
        //中间透明侦测区域
        HoleView *holeView = [[HoleView alloc] initWithFrame:self.bounds];
        holeView.center = CGPointMake(CGRectGetWidth(frame) * 0.5, CGRectGetHeight(frame) * 0.5);
        [self addSubview:holeView];
        self.holeView = holeView;
        [areaView resizeWithRect:holeView.frame];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panArea:)];
        [holeView addGestureRecognizer:pan];
    }
    return self;
}

- (void)setAreaWithX:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height
{
    CGRect rect = CGRectMake(CGRectGetWidth(self.frame) * x,
                             CGRectGetHeight(self.frame) * y,
                             CGRectGetWidth(self.frame) * width,
                             CGRectGetHeight(self.frame) * height);
    self.holeView.frame = rect;
    [self.areaView resizeWithRect:rect];
    [self.holeView setNeedsDisplay];
    
    if ([self.delegate respondsToSelector:@selector(adjustingArea:)]) {
        [self.delegate adjustingArea:self.holeView.frame];
    }
}

- (void)panArea:(UIPanGestureRecognizer *)panGesture
{
    CGPoint pt = [panGesture locationInView:panGesture.view];
    CGPoint translation = [panGesture translationInView:panGesture.view];
    CGRect rect = panGesture.view.frame;
    
    if (pt.x <= FingerWidth && pt.y <= FingerWidth) {//左上角
        
        rect.origin.x += translation.x;
        rect.origin.y += translation.y;
        rect.size.width -= translation.x;
        rect.size.height -= translation.y;
        
        if (rect.origin.x >= 0.0 && rect.origin.y >= 0.0 &&
            rect.size.width >= CGRectGetWidth(self.frame) * 0.2 &&
            rect.size.height >= CGRectGetHeight(self.frame) * 0.2) {
            
            panGesture.view.frame = rect;
            [self.areaView resizeWithRect:panGesture.view.frame];
            [panGesture.view setNeedsDisplay];
        }
        
    }else if (pt.x >= CGRectGetWidth(panGesture.view.frame) - FingerWidth && pt.y <= FingerWidth) {//右上角
        
        rect.origin.y += translation.y;
        if (rect.origin.y < 0.0) {
            rect.origin.y = 0.0;
        }
        rect.size.width += translation.x;
        if (rect.origin.x + rect.size.width > CGRectGetWidth(self.frame)) {
            rect.size.width = CGRectGetWidth(self.frame) - rect.origin.x;
        }
        if (rect.origin.y != 0.0) {
            rect.size.height -= translation.y;
        }
        if (rect.origin.y + rect.size.height > CGRectGetHeight(self.frame)) {
            rect.size.height = CGRectGetHeight(self.frame) - rect.origin.y;
        }
        
        if (CGRectGetMaxX(panGesture.view.frame) <= CGRectGetMaxX(self.bounds) && CGRectGetMinY(panGesture.view.frame) >= CGRectGetMinY(self.bounds) &&
            rect.size.width >= CGRectGetWidth(self.frame) * 0.2 &&
            rect.size.height >= CGRectGetHeight(self.frame) * 0.2) {
            
            panGesture.view.frame = rect;
            [self.areaView resizeWithRect:panGesture.view.frame];
            [panGesture.view setNeedsDisplay];
        }
    }else if (pt.x <= FingerWidth && pt.y >= CGRectGetHeight(panGesture.view.frame) - FingerWidth) {//左下角
        
        rect.origin.x += translation.x;
        if (rect.origin.x < 0.0) {
            rect.origin.x = 0.0;
        }
        if (rect.origin.x != 0.0) {
            rect.size.width -= translation.x;
        }
        rect.size.height += translation.y;
        if (rect.origin.y + rect.size.height > CGRectGetHeight(self.frame)) {
            rect.size.height = CGRectGetHeight(self.frame) - rect.origin.y;
        }
        if (CGRectGetMinX(panGesture.view.frame) >= CGRectGetMinX(self.bounds) && CGRectGetMaxY(panGesture.view.frame) <= CGRectGetMaxY(self.bounds) &&
            rect.size.width >= CGRectGetWidth(self.frame) * 0.2 &&
            rect.size.height >= CGRectGetHeight(self.frame) * 0.2) {
            
            panGesture.view.frame = rect;
            [self.areaView resizeWithRect:panGesture.view.frame];
            [panGesture.view setNeedsDisplay];
        }
    }else if (pt.x >= CGRectGetWidth(panGesture.view.frame) - FingerWidth && pt.y >= CGRectGetHeight(panGesture.view.frame) - FingerWidth) {//右下角
        
        rect.size.width += translation.x;
        rect.size.height += translation.y;
        if (rect.origin.y + rect.size.height > CGRectGetHeight(self.frame)) {
            rect.size.height = CGRectGetHeight(self.frame) - rect.origin.y;
        }
        if (rect.origin.x + rect.size.width > CGRectGetWidth(self.frame)) {
            rect.size.width = CGRectGetWidth(self.frame) - rect.origin.x;
        }
        
        if (CGRectGetMaxX(panGesture.view.frame) <= CGRectGetMaxX(self.bounds) && CGRectGetMaxY(panGesture.view.frame) <= CGRectGetMaxY(self.bounds) &&
            rect.size.width >= CGRectGetWidth(self.frame) * 0.2 &&
            rect.size.height >= CGRectGetHeight(self.frame) * 0.2) {
            
            panGesture.view.frame = rect;
            [self.areaView resizeWithRect:panGesture.view.frame];
            [panGesture.view setNeedsDisplay];
        }
    }else{
        
        // 1.在view上面挪动的距离
        
        rect.origin.x += translation.x;
        rect.origin.y += translation.y;
        
        if (CGRectGetMinX(rect) >= CGRectGetMinX(self.bounds) &&
            CGRectGetMaxX(rect) <= CGRectGetMaxX(self.bounds) &&
            CGRectGetMinY(rect) >= CGRectGetMinY(self.bounds) &&
            CGRectGetMaxY(rect) <= CGRectGetMaxY(self.bounds)) {
            
            panGesture.view.frame = rect;
            
            [self.areaView resizeWithRect:panGesture.view.frame];
        }
    }
    
    // 2.清空移动的距离
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
    
    if ([self.delegate respondsToSelector:@selector(adjustingArea:)]) {
        [self.delegate adjustingArea:self.holeView.frame];
    }
}

@end
