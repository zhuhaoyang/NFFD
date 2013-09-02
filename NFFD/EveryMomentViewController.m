//
//  EveryMomentViewController.m
//  NFFD
//
//  Created by Myth on 13-7-16.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "EveryMomentViewController.h"

@interface EveryMomentViewController ()

@end

@implementation EveryMomentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.view.autoresizesSubviews=YES;
        self.view.frame = CGRectMake(0, 0, 1024, 768-44-49-20);
                
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        title.text = @"农发福地";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor colorWithRed:0.808 green:0.757 blue:0.647 alpha:1];
        title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        title.font = [UIFont boldSystemFontOfSize:23];
        self.navigationItem.titleView = title;

        
        UIButton *btShopping = [UIButton buttonWithType:UIButtonTypeCustom];
        [btShopping setImage:[UIImage imageNamed:@"shopping1"] forState:UIControlStateNormal];
        [btShopping addTarget:self action:@selector(shopping) forControlEvents:UIControlEventTouchUpInside];
        btShopping.frame = CGRectMake(0, 0, 60, 30);
        //    [self.toolbar addSubview:btShopping];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:btShopping];
        [self.navigationItem setRightBarButtonItem:rightButton];
        
//        self.navigationItem.leftBarButtonItem.enabled = NO;
//        self.view.backgroundColor = [UIColor blackColor];
//        [self.tabBarItem.]
        UIImageView *homePage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"homePage1"]];
        homePage1.frame = CGRectMake(0, 0, 1024, 444);
        [self.view addSubview:homePage1];
        
        UIImageView *homePage2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"homePage2"]];
        homePage2.frame = CGRectMake(0, 444, 1024, 60);
        [self.view addSubview:homePage2];
        
            
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//        UIButton *bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        bt.frame = CGRectMake(15+251, 10, 229, 133);
//        bt.showsTouchWhenHighlighted = YES;
//        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//        [m_scrollView addSubview:bt];
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
               
       
    }
    return self;
}

- (void)load
{
   
}
- (void)viewDidAppear:(BOOL)animated
{
//    [super viewDidAppear:YES];
//    [m_scrollView addSubview:activity];
//    activity.hidden = NO;
//    NSLog(@"%@",[m_scrollView subviews]);

   
}

//- (void)viewDidLayoutSubviews
//{
//    m_serviceGettype = [[serviceGettype alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
//    [m_serviceGettype sendRequestWithData:@"device=pad" addr:@"gettype?"];
//
//}

- (void)shopping
{
    m_ShoppingViewController = [[ShoppingViewController alloc]initWithNibName:@"ShoppingViewController" bundle:nil];
    [self.navigationController pushViewController:m_ShoppingViewController animated:YES];
    
    
}

- (void)click:(id)sender
{
    UIButton *bt = sender;
    NSUInteger i = bt.tag;
    CommodityViewController *m_CommodityViewController = [[CommodityViewController alloc]initWithNibName:@"CommodityViewController" bundle:nil typeData:[arrTypeData objectAtIndex:i]];
    [self.navigationController pushViewController:m_CommodityViewController animated:YES];
    self.navigationController.view.frame = CGRectMake(0, 0, 1024, 768-20);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.alpha = 0;
    m_scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 504, 1024, 153)];
    m_scrollView.pagingEnabled = YES;
    m_scrollView.showsHorizontalScrollIndicator = NO;
    m_scrollView.showsVerticalScrollIndicator = NO;
    m_scrollView.scrollsToTop = NO;
    m_scrollView.delegate = self;
    m_scrollView.backgroundColor = [UIColor colorWithRed:0.980 green:0.965 blue:0.925 alpha:1];
    //        m_scrollView.backgroundColor = [UIColor redColor];
    activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.color = [UIColor blackColor];
    activityIndicatorView.frame = CGRectMake(0, 0, 37, 37);
    activityIndicatorView.hidden =NO;
    [activityIndicatorView startAnimating];
    activity = [[UIView alloc]initWithFrame:CGRectMake(1024/2-37/2, 153/2-30, 37, 37)];
    activity.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [activity addSubview:activityIndicatorView];
    [m_scrollView addSubview:activity];
    [self.view addSubview:m_scrollView];

    m_serviceGettype = [[serviceGettype alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
    [m_serviceGettype sendRequestWithData:@"device=pad" addr:@"gettype?"];


//    NSLog(@"%@",self.view);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark serviceCallBack
- (void)serviceGettypeCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
{

    [activityIndicatorView stopAnimating];
    [activity removeFromSuperview];
    if (arrCallBack == nil || [arrCallBack count] == 0) {
        NSLog(@"Gettype nil");
    }else{
        arrTypeData = [[NSArray alloc]initWithArray:arrCallBack];
        m_scrollView.contentSize = CGSizeMake(251*[arrTypeData count],133);
        NSUInteger i = 0;
        for (NSDictionary * dic in arrTypeData) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            bt.frame = CGRectMake(15+251*i, 10, 229, 133);
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"spic"]]];
            [bt setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
            bt.showsTouchWhenHighlighted = YES;
            bt.tag = i;
            [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [m_scrollView addSubview:bt];
            i++;
                
        }
    }
}


@end
