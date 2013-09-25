//
//  LifeViewController.m
//  NFFD
//
//  Created by Myth on 13-7-16.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "LifeViewController.h"

@interface LifeViewController ()

@end

@implementation LifeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
//        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"iOS7"]);
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"iOS7"] boolValue]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.automaticallyAdjustsScrollViewInsets = NO;
            self.extendedLayoutIncludesOpaqueBars = NO;
//            barPosition
        }
        
        self.view.frame = CGRectMake(0, 0, 1024, 768-49-20);
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        title.text = @"每月鲜报";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor colorWithRed:0.808 green:0.757 blue:0.647 alpha:1];
        title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        title.font = [UIFont boldSystemFontOfSize:23];
        self.navigationItem.titleView = title;

//        activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        activity.frame = CGRectMake(1024/2 -37/2, 699/2-37/2, 37, 37);
        
        
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//        m_scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768-49-20)];
//        m_scrollView.delegate = self;
//        m_scrollView.pagingEnabled = YES;
//		m_scrollView.contentSize = CGSizeMake(1024*13,200);
//		m_scrollView.showsHorizontalScrollIndicator = NO;
//        m_scrollView.showsVerticalScrollIndicator = NO;
//		m_scrollView.scrollsToTop = NO;
//        for (NSUInteger i = 0; i < 13; i++) {
//            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",i+1]]];
//            imageView.frame = CGRectMake(1024*i, 0, 1024, 768-49-20);
//            [m_scrollView addSubview:imageView];
//        }
//        [self.view addSubview:m_scrollView];
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    isLoaded = YES;
    m_scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768-49-20-44)];
    m_scrollView.delegate = self;
    m_scrollView.pagingEnabled = YES;
    m_scrollView.showsHorizontalScrollIndicator = NO;
    m_scrollView.showsVerticalScrollIndicator = NO;
    m_scrollView.scrollsToTop = NO;
    m_scrollView.alwaysBounceVertical = YES;
    m_scrollView.backgroundColor = [UIColor colorWithRed:0.980 green:0.965 blue:0.925 alpha:1];
    [self.view addSubview:m_scrollView];

    m_serviceGetarticle = [[serviceGetarticle alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
    [m_serviceGetarticle sendRequestWithData:@"device=pad&idx=1" addr:@"getarticle?"];
   
   
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < -200) {
//        m_serviceGetarticle = [[serviceGetarticle alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
        [m_serviceGetarticle sendRequestWithData:@"device=pad&idx=1" addr:@"getarticle?"];

    }
}

- (void)viewDidAppear:(BOOL)animated
{
//    [self.view addSubview:activity];
//    activity.hidden = NO;
//    [activity startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)serviceGetarticleCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
{
    
    if (arrCallBack == nil || [arrCallBack count] == 0) {
        NSLog(@"Getarticle nil");
        
        if (isLoaded) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"fadeScreen" object:nil];
            isLoaded = NO;
        }

    }else{
        arrArticles = [[NSArray alloc]initWithArray:arrCallBack];
        NSUInteger num = [arrArticles count];
        NSUInteger rows = (num%3)?(num/3+1):(num/3);
        NSUInteger column = 0;
        NSUInteger row = 0;
		m_scrollView.contentSize = CGSizeMake(1024,(20+rows*280)<(768-49-20-44)?(768-49-20-44):(20+rows*280));
        NSLog(@"%f",m_scrollView.contentSize.height);
        for (NSUInteger i = 0; i < num; i++) {
            
            
            UIView *backImgView = [[UIView alloc]initWithFrame:CGRectMake(43+column*330, 20+row*280+30, 256+22, 175+22)];
            backImgView.backgroundColor = [UIColor colorWithRed:0.945 green:0.922 blue:0.882 alpha:1];
            
//            backImgView.backgroundColor = [UIColor redColor];
            EGOImageButton *bt = [EGOImageButton buttonWithType:UIButtonTypeCustom];
            bt.frame = CGRectMake(11, 11, 256, 175);
            [bt setImageURL:[NSURL URLWithString:[[arrArticles objectAtIndex:i]objectForKey:@"title_pic"]]];
            bt.backgroundColor = [UIColor whiteColor];
            bt.tag = i;
            [bt addTarget:self action:@selector(loadMagz:) forControlEvents:UIControlEventTouchUpInside];
            [backImgView addSubview:bt];
            [m_scrollView addSubview:backImgView];
            
            column++;
            if (column==3) {
                column=0;
                row++;
            }
        }
//        [self.view addSubview:m_scrollView];
//        [activity stopAnimating];
//        [activity removeFromSuperview];
        if (isLoaded) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"fadeScreen" object:nil];
            isLoaded = NO;
        }    }
}

- (void)loadMagz:(id)sender
{
    EGOImageButton *bt = sender;
    NSString *aid = [[arrArticles objectAtIndex:bt.tag] objectForKey:@"aid"];
    NSString *title = [[arrArticles objectAtIndex:bt.tag] objectForKey:@"title"];
    MagazineViewController *m_MagazineViewController = [[MagazineViewController alloc]initWithNibName:@"MagazineViewController" bundle:nil aid:aid title:title];
    [self.navigationController pushViewController:m_MagazineViewController animated:YES];
}


@end
