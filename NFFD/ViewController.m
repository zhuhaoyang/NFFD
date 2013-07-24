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

    if (1) {
//        [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        startLoge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
        startLoge.frame = CGRectMake(0, 0, 1024, 768);
        
        [self.view addSubview:startLoge];
        
        timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                 target: self
                                               selector: @selector(fadeScreen)
                                               userInfo: nil repeats: NO];
    }else {
        [self showMain];
    }

}


- (void) fadeScreen
{
	[UIView beginAnimations: nil context: nil];
	[UIView setAnimationDuration: 0.1f];
	[UIView setAnimationDelegate: self];
	[UIView setAnimationDidStopSelector: @selector(finishedFading)];
	self.view.alpha = 0;
	[UIView commitAnimations];
}

- (void) finishedFading
{
	[UIView beginAnimations: nil context: nil];
	[UIView setAnimationDuration: 0.1f];
	self.view.alpha = 1.0;
	[UIView commitAnimations];
	[startLoge removeFromSuperview];
    
    [self showMain];
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
    UIBarButtonItem *bt1 = [[UIBarButtonItem alloc]initWithTitle:@"每时每刻" style:UIBarButtonItemStylePlain target:self action:@selector(clickBt1)];
    UIBarButtonItem *bt2 = [[UIBarButtonItem alloc]initWithTitle:@"生活方式" style:UIBarButtonItemStylePlain target:self action:@selector(clickBt2)];
    NSArray *arrItems = [[NSArray alloc]initWithObjects:bt1,bt2, nil];
    [self.toolbar setItems:arrItems];
    m_EveryMomentViewController = [[EveryMomentViewController alloc]initWithNibName:@"EveryMomentViewController" bundle:nil];
    self.nav = [[OrientationNavigationController alloc]initWithRootViewController:m_EveryMomentViewController];
    self.nav.view.frame = CGRectMake(0, 0, 1024, 768-49-20);
//    [self.nav.navigationBar setTintColor:[UIColor colorWithRed:0.612 green:0.573 blue:0.490 alpha:1]];
    [self.nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
//    self.nav.view.frame = [[UIScreen mainScreen] bounds];
    self.m_LifeViewController = [[LifeViewController alloc]initWithNibName:@"LifeViewController" bundle:nil];
    
    [self.view addSubview:self.nav.view];
    [self.view addSubview:self.toolbar];
//    NSLog(@"%@",self.nav.view);
//    tabBarController = [[OrientationTabBarController alloc]init];
//    tabBarController.delegate = self;
//    tabBarController.view.frame =CGRectMake(0, 0, 1024, 768-20);

//    tabBarController.tabBar.frame = CGRectMake(0, 1024-49, 720, 49);
//    tabBarController.viewControllers = @[nav,m_LifeViewController];
//    [self.view addSubview:tabBarController.view];
    
    
//    NSMutableArray *tabBarItems = [[[[self.view subviews] objectAtIndex:1] subviews] mutableCopy];
//    
//    for (int item = 0; item < [tabBarItems count]; item++) {
//        for (int subview = 0; subview < [[[tabBarItems objectAtIndex:item] subviews] count]; subview++) {
//            if ([[[[tabBarItems objectAtIndex:item] subviews] objectAtIndex:subview] isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")]) {
//                [[[[tabBarItems objectAtIndex:item] subviews] objectAtIndex:subview] setFont:[UIFont systemFontOfSize:6.0f]];
//                [[[[tabBarItems objectAtIndex:item] subviews] objectAtIndex:subview] setFrame: CGRectMake(0, 0, 30, 30)];
////                 [[[[tabBarItems objectAtIndex:item] subviews] objectAtIndex:subview] setTextAlignment:UITextAlignmentCenter];
//                 }
//                 }
//                 }
    
}

- (void)clickBt1
{
    if (selectedTab == 2) {
        [self.m_LifeViewController.view removeFromSuperview];
        [self.view addSubview:self.nav.view];
        [self.view bringSubviewToFront:self.toolbar];
        selectedTab = 1;
    }
}
- (void)clickBt2
{
    if (selectedTab == 1) {
        [self.nav.view removeFromSuperview];
        [self.view addSubview:self.m_LifeViewController.view];
        [self.view bringSubviewToFront:self.toolbar];
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration NS_AVAILABLE_IOS(3_0)//当发送旋屏事件后，就会掉用该方法
{
    [self setMyLayout];
}

- (void)setMyLayout
{
//    self.view.frame = CGRectMake(0, 0, 748, 1024);
    self.nav.view.frame = CGRectMake(0, 0, 1024, 768-49-20);
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
    self.nav.view.frame = CGRectMake(0, 0, 1024, 768-20-49);

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideToolbar" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showToolbar" object:nil];
}
@end
