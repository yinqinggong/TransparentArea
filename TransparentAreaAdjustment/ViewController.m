//
//  ViewController.m
//  TransparentAreaAdjustment
//
//  Created by Qinggong on 2017/3/6.
//  Copyright © 2017年 Qinggong. All rights reserved.
//

#import "ViewController.h"
#import "QGImageView.h"

@interface ViewController ()<QGImageViewDelegate>

@property (weak, nonatomic) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //背景图片默认尺寸16：9
    QGImageView *iconView = [[QGImageView alloc] initWithFrame:CGRectMake(0.0, 100.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 9.0 / 16.0)];
    iconView.image = [UIImage imageNamed:@"Bg_Device"];
    iconView.delegate = self;
    [self.view addSubview:iconView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(iconView.frame) + 50.0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    [self.view addSubview:label];
    self.label = label;
    
    [iconView setAreaWithX:0.25 Y:0.25 Width:0.5 Height:0.5];
}

#pragma mark - QGImageViewDelegate
- (void)adjustingArea:(CGRect)rect
{
    self.label.text = [NSString stringWithFormat:@"Current area: %@", NSStringFromCGRect(rect)];
}

@end

