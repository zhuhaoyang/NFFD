//
//  MagazineViewController.m
//  NFFD
//
//  Created by Myth on 13-8-28.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "MagazineViewController.h"

@interface MagazineViewController ()

@end

@implementation MagazineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil aid:(NSString *)aid title:(NSString *)title
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_aid = [NSString stringWithString:aid];
        UILabel *m_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        m_title.text = title;
        m_title.textAlignment = NSTextAlignmentCenter;
        m_title.textColor = [UIColor colorWithRed:0.808 green:0.757 blue:0.647 alpha:1];
        m_title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        m_title.font = [UIFont boldSystemFontOfSize:23];
        self.navigationItem.titleView = m_title;
        self.view.frame = CGRectMake(0, 0, 1024, 768-49-20);

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    m_serviceGetarticledetail = [[serviceGetarticledetail alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
    NSString *strAid = [NSString stringWithFormat:@"aid=%@",m_aid];
    [m_serviceGetarticledetail sendRequestWithData:strAid addr:@"getarticledetail?"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 60, 30);
    [backButton setBackgroundImage:[UIImage imageNamed:@"btBack"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *liftButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:liftButton];

}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)serviceGetarticledetailCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
{
    
    if (arrCallBack == nil || [arrCallBack count] == 0) {
        NSLog(@"Getarticledetail nil");
        
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"fadeScreen" object:nil];
        
    }else{
        m_scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768-49-20-44)];
        m_scrollView.delegate = self;
        m_scrollView.pagingEnabled = YES;
		m_scrollView.contentSize = CGSizeMake(1024*[arrCallBack count],768-49-20-44);
		m_scrollView.showsHorizontalScrollIndicator = NO;
        m_scrollView.showsVerticalScrollIndicator = NO;
		m_scrollView.scrollsToTop = NO;
        for (NSUInteger i = 0; i < [arrCallBack count]; i++) {
//            - (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<EGOImageViewDelegate>)aDelegate {
            EGOImageView *imageView = [[EGOImageView alloc]initWithPlaceholderImage:nil delegate:self];
            imageView.frame = CGRectMake(1024*i, 0, 1024, 768-20-49-44);
            UIActivityIndicatorView *activit = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            activit.color = [UIColor blackColor];
            activit.frame = CGRectMake(1024/2-37/2, (768-20-44-49)/2 - 37/2, 37, 37);
            activit.tag = 101;
            [imageView addSubview:activit];
            [activit startAnimating];
//            EGOImageView *imageView = [[EGOImageView alloc]initWithFrame:CGRectMake(1024*i, 0, 1024, 768-20-49-44)];
            imageView.imageURL = [NSURL URLWithString:[[arrCallBack objectAtIndex:i]objectForKey:@"text"]];
            [m_scrollView addSubview:imageView];
        }
        [self.view addSubview:m_scrollView];
        //        [activity stopAnimating];
        //        [activity removeFromSuperview];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"fadeScreen" object:nil];
    }
}

- (void)imageViewLoadedImage:(EGOImageView*)imageView{
    UIActivityIndicatorView *activit = (UIActivityIndicatorView*)[imageView viewWithTag:101];
    [activit removeFromSuperview];

}

@end
