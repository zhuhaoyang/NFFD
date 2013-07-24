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
//#import "OrientationTabBarController.h"
@interface ViewController : UIViewController<UITabBarControllerDelegate>
{
    UIImageView *startLoge;
    NSTimer *timer;
    EveryMomentViewController *m_EveryMomentViewController;
    LifeViewController *m_LifeViewController;
    OrientationNavigationController *nav;
//    OrientationTabBarController *tabBarController;
    UIToolbar *toolbar;
    NSInteger selectedTab;
}
@property(nonatomic,retain)OrientationNavigationController *nav;
@property(nonatomic,retain)LifeViewController *m_LifeViewController;
@property(nonatomic,retain)UIToolbar *toolbar;
//@property(nonatomic) NSInteger selectedTab;
- (void)setMyLayout;
- (void)fadeScreen;
- (void)finishedFading;
- (void)showMain;
@end
