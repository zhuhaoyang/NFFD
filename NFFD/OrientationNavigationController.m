//
//  OrientationNavigationController.m
//  OrientationDemo
//
//  Created by wanghui on 13-4-17.
//  Copyright (c) 2013年 wanghui. All rights reserved.
//

#import "OrientationNavigationController.h"
@class OrientationViewController2;

@interface OrientationNavigationController ()

@end

@implementation OrientationNavigationController

-(void)dealloc
{
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}



#pragma mark-支持自动转屏
-(NSUInteger)supportedInterfaceOrientations
{
    //返回顶层视图支持的旋转方向
    return self.topViewController.supportedInterfaceOrientations;
}

- (BOOL)shouldAutorotate
{
    //返回顶层视图的设置
    return self.topViewController.shouldAutorotate;
}

@end
