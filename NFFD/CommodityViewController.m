//
//  CommodityViewController.m
//  NFFD
//
//  Created by Myth on 13-7-18.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "CommodityViewController.h"

@interface CommodityViewController ()

@end

@implementation CommodityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isHide = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter]postNotificationName:@"hideToolbar" object:nil];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    self.navigationController.navigationBar.alpha = 0;
    self.navigationItem.leftBarButtonItem.enabled = NO;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 60, 30);
    [backButton setBackgroundImage:[UIImage imageNamed:@"btBack"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *liftButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:liftButton];

    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    thumbnailView = [[UIView alloc]initWithFrame:CGRectMake(0,768-20-5.5, 1024, 166)];
    thumbnailView.backgroundColor = [UIColor colorWithRed:0.9843 green:0.9686 blue:0.9294 alpha:1];
    UIImageView *brownLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 5.5)];
    brownLine.backgroundColor = [UIColor colorWithRed:0.4667 green:0.4078 blue:0.349 alpha:1];
    brownLine.layer.shadowColor = [UIColor grayColor].CGColor;
    brownLine.layer.shadowOffset = CGSizeMake(0, 4);
    brownLine.layer.shadowOpacity = 0.5;
    brownLine.layer.shadowRadius = 4.0;

    [thumbnailView addSubview:brownLine];
    btHide = [UIButton buttonWithType:UIButtonTypeCustom];
    [btHide setImage:[UIImage imageNamed:@"btShow"] forState:UIControlStateNormal];
    [btHide addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
    btHide.tag = 0;
    btHide.frame = CGRectMake(453.5, 768-20-5.5-32.5+1, 117, 32.5);
    [self.view addSubview:btHide];
    [self.view addSubview:thumbnailView];

}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hide:(id)sender
{
    UIButton *bt = sender;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    if (bt.tag) {
        [btHide setImage:[UIImage imageNamed:@"btShow"] forState:UIControlStateNormal];
        btHide.frame = CGRectMake(453.5, 768-20-5.5-32.5+1, 117, 32.5);
        thumbnailView.frame = CGRectMake(0,768-20-5.5, 1024, 166);
        btHide.tag = 0;
    }else{
        [btHide setImage:[UIImage imageNamed:@"btHide"] forState:UIControlStateNormal];
        btHide.frame = CGRectMake(453.5, 608-32.5+1, 117, 32.5);
        thumbnailView.frame = CGRectMake(0, 608, 1024, 166);
        btHide.tag = 1;
    
    }
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    [super.navigationController setNavigationBarHidden:isflage animated:TRUE];
    //    self.navigationController.navigationBar.hidden = isflage;
   
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        
        if (isHide) {
            self.navigationController.navigationBar.alpha = 1;
            self.navigationItem.leftBarButtonItem.enabled = YES;
        }else{
            self.navigationController.navigationBar.alpha = 0;
            self.navigationItem.leftBarButtonItem.enabled = NO;
        }
        [UIView setAnimationDelegate:self];
        [UIView commitAnimations];
        isHide=!isHide;
    
    //    [super.navigationController setToolbarHidden:isflage animated:TRUE];
}


@end
