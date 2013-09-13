//
//  ViewController.h
//  NFFD
//
//  Created by Myth on 13-7-16.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EveryMomentViewController.h"
#import "LifeViewController.h"
#import "OrientationNavigationController.h"
#import "PayedorderViewController.h"
//#import "ShoppingViewController.h"
//#import "OrientationTabBarController.h"
@interface ViewController : UIViewController<UITabBarControllerDelegate>
{
    UIImageView *startLoge;
    NSTimer *timer;
    EveryMomentViewController *m_EveryMomentViewController;
    LifeViewController *m_LifeViewController;
    OrientationNavigationController *nav1;
    OrientationNavigationController *nav2;
    PayedorderViewController *m_PayedorderViewController;
//    ShoppingViewController *m_ShoppingViewController;
//    OrientationTabBarController *tabBarController;
    UIToolbar *toolbar;
    NSInteger selectedTab;
    UIImageView *triangle;
    UIButton *btShopping;
}
@property(nonatomic,retain)OrientationNavigationController *nav1;
@property(nonatomic,retain)OrientationNavigationController *nav2;
@property(nonatomic,retain)LifeViewController *m_LifeViewController;
@property(nonatomic,retain)UIToolbar *toolbar;
//@property(nonatomic) NSInteger selectedTab;
- (void)setMyLayout;
- (void)fadeScreen;
- (void)finishedFading;
- (void)showMain;
@end
