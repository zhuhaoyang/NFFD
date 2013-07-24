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
        self.view.frame = CGRectMake(0, 0, 1024, 768-49-20);
        
        m_scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768-49-20)];
        m_scrollView.delegate = self;
        m_scrollView.pagingEnabled = YES;
		m_scrollView.contentSize = CGSizeMake(1024*13,200);
		m_scrollView.showsHorizontalScrollIndicator = NO;
        m_scrollView.showsVerticalScrollIndicator = NO;
		m_scrollView.scrollsToTop = NO;
        for (NSUInteger i = 0; i < 13; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",i+1]]];
            imageView.frame = CGRectMake(1024*i, 0, 1024, 768-49-20);
            [m_scrollView addSubview:imageView];
        }
        [self.view addSubview:m_scrollView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
