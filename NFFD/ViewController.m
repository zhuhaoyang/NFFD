//
//  ViewController.m
//  NFFD
//
//  Created by Myth on 13-7-16.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.frame = CGRectMake(0, 20, 1024, 768);
//    self.view.backgroundColor = [UIColor blackColor];
	// Do any additional setup after loading the view, typically from a nib.
//    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;//   esSubviews=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideToolbar) name:@"hideToolbar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showToolbar) name:@"showToolbar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fadeScreen) name:@"fadeScreen" object:nil];

    
    
    
   
    
    
    if (1) {
//        [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        startLoge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
        startLoge.frame = CGRectMake(0, 0, 1024, 768);
        
        [self.view addSubview:startLoge];
        [self.view bringSubviewToFront:startLoge];
        timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                 target: self
//                                               selector: @selector(fadeScreen)
                                               selector: @selector(showMain)

                                               userInfo: nil repeats: NO];
    }else {
        [self showMain];
    }

}


- (void) fadeScreen
{
	[UIView beginAnimations: nil context: nil];
	[UIView setAnimationDuration: 0.1];
	[UIView setAnimationDelegate: self];
	[UIView setAnimationDidStopSelector: @selector(finishedFading)];
	startLoge.alpha = 0;
	[UIView commitAnimations];
}

- (void) finishedFading
{
	[UIView beginAnimations: nil context: nil];
	[UIView setAnimationDuration: 0.1];
	self.nav1.view.alpha = 1.0;
    self.toolbar.alpha = 1.0;
	[UIView commitAnimations];
	[startLoge removeFromSuperview];
    
//    [self showMain];
}

- (void)showMain
{
//    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    selectedTab = 1;
    self.toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 768-20-49, 1024, 49)];
//    NSLog(@"%@",self.toolbar);
//    [self.toolbar setBackgroundImage:[UIImage imageNamed:@"toolbar"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsLandscapePhone];
//    [self.toolbar setTintColor:[UIColor colorWithRed:0.612 green:0.573 blue:0.490 alpha:1]];
    [self.toolbar setBackgroundImage:[UIImage imageNamed:@"toolbar"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    UIButton *btPayedorder = [UIButton buttonWithType:UIButtonTypeCustom];
    btPayedorder.frame = CGRectMake(1024-50, (49-27)/2, 27, 27);
    [btPayedorder setImage:[UIImage imageNamed:@"btPayedorder"] forState:UIControlStateNormal];
    [btPayedorder addTarget:self action:@selector(showPayedorder:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolbar addSubview:btPayedorder];
    
    UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt2 setImage:[UIImage imageNamed:@"tab1"] forState:UIControlStateNormal];
    bt2.frame = CGRectMake(153, 0, 123, 49);
    [bt2 addTarget:self action:@selector(clickBt2) forControlEvents:UIControlEventTouchUpInside];
    [self.toolbar addSubview:bt2];

    UIButton *bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt1 setImage:[UIImage imageNamed:@"tab2"] forState:UIControlStateNormal];
    bt1.frame = CGRectMake(20, 0, 123, 49);
    [bt1 addTarget:self action:@selector(clickBt1) forControlEvents:UIControlEventTouchUpInside];
    [self.toolbar addSubview:bt1];

//    NSArray *arrItems = [[NSArray alloc]initWithObjects:bt1,bt2, nil];
//    [self.toolbar setItems:arrItems];
//    NSLog(@"%@ %@",bt1.customView,bt2.customView);
    triangle = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"triangle"]];
    triangle.frame = CGRectMake(60, 0, 22, 12);
    [self.toolbar addSubview:triangle];
    
//    btShopping = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btShopping setImage:[UIImage imageNamed:@"shopping1"] forState:UIControlStateNormal];
//    [btShopping addTarget:self action:@selector(shopping) forControlEvents:UIControlEventTouchUpInside];
//    btShopping.frame = CGRectMake(0, 0, 60, 30);
////    [self.toolbar addSubview:btShopping];
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:btShopping];
//    [self.navigationItem setRightBarButtonItem:rightButton];

    
    m_LifeViewController = [[LifeViewController alloc]initWithNibName:@"LifeViewController" bundle:nil];
    self.nav1 = [[OrientationNavigationController alloc]initWithRootViewController:m_LifeViewController];
    self.nav1.view.frame = CGRectMake(0, 0, 1024, 768-49-20);
    //    [self.nav.navigationBar setTintColor:[UIColor colorWithRed:0.612 green:0.573 blue:0.490 alpha:1]];
    [self.nav1.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
    
    m_EveryMomentViewController = [[EveryMomentViewController alloc]initWithNibName:@"EveryMomentViewController" bundle:nil];
    self.nav2 = [[OrientationNavigationController alloc]initWithRootViewController:m_EveryMomentViewController];
    self.nav2.view.frame = CGRectMake(0, 0, 1024, 768-49-20);
//    [self.nav.navigationBar setTintColor:[UIColor colorWithRed:0.612 green:0.573 blue:0.490 alpha:1]];
    [self.nav2.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
//    self.nav.view.frame = [[UIScreen mainScreen] bounds];
    
    self.nav1.view.alpha = 0;
    self.toolbar.alpha = 0;
    [self.view addSubview:self.nav1.view];
    [self.view addSubview:self.toolbar];
//    [m_EveryMomentViewController load];
    
    m_PayedorderViewController = [[PayedorderViewController alloc]initWithNibName:@"PayedorderViewController" bundle:nil];

    }

//- (void)shopping
//{
//    m_ShoppingViewController = [[ShoppingViewController alloc]initWithNibName:@"ShoppingViewController" bundle:nil];
//    [self.nav pushViewController:m_ShoppingViewController animated:YES];
//
//   
//}



- (void)showPayedorder:(id)sender
{

    
    
    m_PayedorderViewController.view.frame = CGRectMake(1024, 0, 1024, 768);
    [self.view addSubview:m_PayedorderViewController.view];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    m_PayedorderViewController.view.frame = CGRectMake(0, 0, 1024, 768);
    [UIView setAnimationDidStopSelector: @selector(remove)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];

}

- (void)clickBt1
{
    if (selectedTab == 2) {
        [self.nav2.view removeFromSuperview];
        [self.view addSubview:self.nav1.view];
        [self.view bringSubviewToFront:self.toolbar];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        triangle.frame = CGRectMake(60, 0, 22, 12);
        [UIView setAnimationDelegate:self];
        [UIView commitAnimations];
        
        btShopping.alpha = 0;
        btShopping.enabled = NO;
        

        selectedTab = 1;
    }
}
- (void)clickBt2
{
    if (selectedTab == 1) {
                
        [self.nav1.view removeFromSuperview];
        [self.view addSubview:self.nav2.view];
        [self.view bringSubviewToFront:self.toolbar];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];

        triangle.frame = CGRectMake(193, 0, 22, 12);

        [UIView setAnimationDelegate:self];
        [UIView commitAnimations];
        
        btShopping.alpha = 1;
        btShopping.enabled = YES;

        selectedTab = 2;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSUInteger)supportedInterfaceOrientations//返回该controller支持的设备状态
{
//    [self setMyLayout];
    return UIInterfaceOrientationMaskLandscape;//支持左右横屏
}
- (BOOL)shouldAutorotate//设置该controller是否可自动旋屏
{
    return YES;
}

//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration NS_AVAILABLE_IOS(3_0)//当发送旋屏事件后，就会掉用该方法
//{
//    [self setMyLayout];
//}
//为了兼容IOS6以前的版本而保留的方法
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
//    return (toInterfaceOrientation == UIInterfaceOrientationMaskLandscape);
    BOOL b = (toInterfaceOrientation == UIDeviceOrientationLandscapeLeft || toInterfaceOrientation == UIDeviceOrientationLandscapeRight);
    return b;//即在IOS6.0以下版本，支持所用方向的旋屏
}

- (void)setMyLayout
{
//    self.view.frame = CGRectMake(0, 0, 748, 1024);
//    self.nav.view.frame = CGRectMake(0, 0, 1024, 768-49-20);
//    self.toolbar.frame = CGRectMake(0, 768-20-49, 1024, 49);
//    NSLog(@"NAV = %@",self.nav.view);
//    NSLog(@"VIEW = %@",self.view);
}

- (void)hideToolbar
{
        CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    self.toolbar.frame = CGRectMake(0, 768, 1024, 49);
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

- (void)showToolbar
{
    self.toolbar.frame = CGRectMake(0, 768-20-49, 1024, 49);
    self.nav2.view.frame = CGRectMake(0, 0, 1024, 768-20-49);

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideToolbar" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showToolbar" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"fadeScreen" object:nil];

}
@end
