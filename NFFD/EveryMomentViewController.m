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
//        self.navigationItem.leftBarButtonItem.enabled = NO;
//        self.view.backgroundColor = [UIColor blackColor];
//        [self.tabBarItem.]
        
        
        m_scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 524, 1024, 133)];
        m_scrollView.pagingEnabled = YES;
		m_scrollView.contentSize = CGSizeMake(251*6,133);
		m_scrollView.showsHorizontalScrollIndicator = NO;
        m_scrollView.showsVerticalScrollIndicator = NO;
		m_scrollView.scrollsToTop = NO;
		m_scrollView.delegate = self;
        //        m_scrollView.backgroundColor = [UIColor redColor];
        [self.view addSubview:m_scrollView];
        for (int i = 0; i < 6; i++) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            bt.frame = CGRectMake(15+251*i, 0, 229, 133);
            [bt setImage:[UIImage imageNamed:@"life__04"] forState:UIControlStateNormal];
            bt.showsTouchWhenHighlighted = YES;
            bt.tag = i;
            [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [m_scrollView addSubview:bt];
            
        }

    }
    return self;
}

- (void)click:(id)sender
{
    UIButton *bt = sender;
//    bt.tag
    CommodityViewController *m_CommodityViewController = [[CommodityViewController alloc]initWithNibName:@"CommodityViewController" bundle:nil];
    [self.navigationController pushViewController:m_CommodityViewController animated:YES];
    self.navigationController.view.frame = CGRectMake(0, 0, 1024, 768-20);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.alpha = 0;

//    NSLog(@"%@",self.view);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
