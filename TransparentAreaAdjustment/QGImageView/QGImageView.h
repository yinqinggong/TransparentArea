//
//  QGImageView.h
//  TransparentAreaAdjustment
//
//  Created by Qinggong on 2017/3/7.
//  Copyright © 2017年 Qinggong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QGImageViewDelegate <NSObject>

@optional
- (void)adjustingArea:(CGRect)rect;

@end

@interface QGImageView : UIImageView

- (void)setAreaWithX:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height;

@property (weak, nonatomic) id<QGImageViewDelegate> delegate;

@end
