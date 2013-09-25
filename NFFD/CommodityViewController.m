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
@synthesize activity = _activity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil typeData:(NSDictionary *)dic
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        self.view.backgroundColor = [UIColor blackColor];
        // Custom initialization
//        self.view.frame =  [[UIScreen mainScreen] bounds];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"iOS7"] boolValue]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.automaticallyAdjustsScrollViewInsets = NO;
            self.extendedLayoutIncludesOpaqueBars = NO;
        }
        dicTypeData = [[NSDictionary alloc]initWithDictionary:dic];
        isHide = YES;
        isDetail = NO;
        isShareView = NO;
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        title.text = [dicTypeData objectForKey:@"tname"];
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor colorWithRed:0.808 green:0.757 blue:0.647 alpha:1];
        title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        title.font = [UIFont boldSystemFontOfSize:23];
        self.navigationItem.titleView = title;
//        NSLog(@"%@",self.bttttt);
        [self.activity startAnimating];
        activit1 = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activit1.color = [UIColor blackColor];
        activit1.frame = CGRectMake(382/2-37/2, 359/2 - 37/2, 37, 37);
        triangle = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"triangle"]];
        
        
       //        [self.view sendSubviewToBack:imgBpic];

    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
//    activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    activity.frame = CGRectMake(1024/2-18.5, 300-20, 37, 37);
//    activity.color = [UIColor blackColor];
//    [activity startAnimating];
//    [self.view addSubview:activity];
//    [self.view bringSubviewToFront:activity];
    self.view.frame = CGRectMake(0, 0, 1024, 748);
    EGOImageView *imgBpic = [[EGOImageView alloc]init];
    imgBpic.imageURL = [NSURL URLWithString:[dicTypeData objectForKey:@"bpic"]];
    imgBpic.frame = CGRectMake(0, 0, 1024, self.view.frame.size.height);
    //    imgBpic.backgroundColor = [UIColor blackColor];
    [self.view addSubview:imgBpic];
    [self.view sendSubviewToBack:imgBpic];
    
//    NSLog(@"%@",imgBpic);
    
    //    UIImageView *background = [[UIImageView alloc]init];//WithImage:[UIImage imageNamed:@""]];
    //    background.frame = CGRectMake(0, 0, 1024, 768-20-5.5);
    //    background.backgroundColor = [UIColor blackColor];
    //    [self.view addSubview:background];
    
    detailView = [[UIView alloc]initWithFrame:CGRectMake(0, -602, 1024, self.view.frame.size.height-166)];
    detailView.backgroundColor = [UIColor colorWithRed:0.925 green:0.929 blue:0.878 alpha:1];
//        detailView.backgroundColor = [UIColor colorWithRed:0.984 green:0.984 blue:0.984 alpha:1];
    [self.view addSubview:detailView];
    
    
    
    thumbnailView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-5.5, 1024, 166)];
    thumbnailView.backgroundColor = [UIColor colorWithRed:0.9843 green:0.9686 blue:0.9294 alpha:1];
    
    m_ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1024, 166)];
    //    m_ScrollView.pagingEnabled = YES;
    m_ScrollView.showsHorizontalScrollIndicator = NO;
    m_ScrollView.showsVerticalScrollIndicator = NO;
    m_ScrollView.scrollsToTop = NO;
    m_ScrollView.delegate = self;
    m_ScrollView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];;
    [thumbnailView addSubview:m_ScrollView];
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //    UIButton *bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    bt.frame = CGRectMake(0, 0, 80, 50);
    //    [bt addTarget:self action:@selector(browseDetail:) forControlEvents:UIControlEventTouchUpInside];
    //    [m_ScrollView addSubview:bt];
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    UIImageView *brownLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 5.5)];
    brownLine.backgroundColor = [UIColor colorWithRed:0.4667 green:0.4078 blue:0.349 alpha:1];
    brownLine.layer.shadowColor = [UIColor grayColor].CGColor;
    brownLine.layer.shadowOffset = CGSizeMake(0, 4);
    brownLine.layer.shadowOpacity = 0.5;
    brownLine.layer.shadowRadius = 4.0;
    
    
    [thumbnailView addSubview:brownLine];
    btHide = [UIButton buttonWithType:UIButtonTypeCustom];
    btHide.frame = CGRectMake(453.5, self.view.frame.size.height-5.5-43+1, 150, 43);
//    btHide = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btHide setImage:[UIImage imageNamed:@"btShow"] forState:UIControlStateNormal];
//    btHide.frame = CGRectMake(100, 100, 500, 100);
    [btHide addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
    btHide.tag = 0;
    [self.view addSubview:btHide];
    //    [self.view bringSubviewToFront:btHide];
    [self.view addSubview:thumbnailView];
    
    //    [self.view bringSubviewToFront:thumbnailView];
    //    arrProductlist = [[NSArray alloc]initWithArray:arrCallBack];
    //    m_ScrollView.contentSize = CGSizeMake(50+200*10,119);//170*158
    //    NSUInteger i = 0;
    //    //        for (NSDictionary *dic in arrProductlist) {
    //    for (NSUInteger i = 0; i<10; i++) {
    //
    //
    //        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    //        //            [bt setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"pic"]]]] forState:UIControlStateNormal];
    //        [bt addTarget:self action:@selector(browseDetail) forControlEvents:UIControlEventTouchUpInside];
    //        [bt setBackgroundColor:[UIColor whiteColor]];
    //        bt.frame = CGRectMake(50+i*200, 0, 128, 119);
    //        bt.tag = i;
    //        [m_ScrollView addSubview:bt];
    //            i++;
    //    }
    //
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    UIButton *btClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btClose setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    btClose.frame = CGRectMake(8, 44+8, 47, 47);
    [btClose addTarget:self action:@selector(closeDetail) forControlEvents:UIControlEventTouchUpInside];
    [detailView addSubview:btClose];
    
//    btShare = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btShare setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//    btShare.frame = CGRectMake(1024-8-50, 44+8, 50, 50);
//    [btShare addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
//    [detailView addSubview:btShare];
    
    imageProduct = [[UIImageView alloc]initWithFrame:CGRectMake(76-40, 44+85, 382, 359)];
    [detailView addSubview:imageProduct];
    
//    label1 = [[UILabel alloc]initWithFrame:CGRectMake(76+382+76-80, 44+85, 300, 40)];
    //    label1.text = @"饭先生   1.5kg";
//    label1.font = [UIFont systemFontOfSize:35];
//    label1.textColor = [UIColor colorWithRed:0.4667 green:0.408 blue:0.349 alpha:1];
//    label1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//    [detailView addSubview:label1];
    
    
    //    label2 = [[UILabel alloc]initWithFrame:CGRectMake(76+382+76, 44+85+40, 600, 40)];
    //    label2.text = @"100%有机 清爽休闲装";
    //    label2.font = [UIFont systemFontOfSize:18];
    //    label2.textColor = [UIColor colorWithRed:0.4667 green:0.408 blue:0.349 alpha:1];
    //    label2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    //    [detailView addSubview:label2];
    
    label3 = [[UILabel alloc]initWithFrame:CGRectMake(76+382+76-80, 44+85+40+50, 600, 70)];
    //    label3.text = @"$  300.00";
    label3.font = [UIFont systemFontOfSize:55];
    label3.textColor = [UIColor colorWithRed:1 green:0.369 blue:0.369 alpha:1];
    label3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [detailView addSubview:label3];
    
    label4 = [[UILabel alloc]initWithFrame:CGRectMake(76+382+76-80, 44+85+40+50+80, 600, 40)];
    //    label4.text = @"库存:  100";
    label4.font = [UIFont systemFontOfSize:18];
    label4.textColor = [UIColor colorWithRed:0.4667 green:0.408 blue:0.349 alpha:1];
    label4.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [detailView addSubview:label4];
    
    label5 = [[UILabel alloc]initWithFrame:CGRectMake(76+382+76-80, 44+85+40+50+80+40, 50, 40)];
    label5.text = @"数量:";
    label5.font = [UIFont systemFontOfSize:18];
    label5.textColor = [UIColor colorWithRed:0.4667 green:0.408 blue:0.349 alpha:1];
    label5.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [detailView addSubview:label5];
    
    UIButton *btSubtraction = [UIButton buttonWithType:UIButtonTypeCustom];
    [btSubtraction setImage:[UIImage imageNamed:@"subtraction"] forState:UIControlStateNormal];
    [btSubtraction addTarget:self action:@selector(subtraction) forControlEvents:UIControlEventTouchUpInside];
    btSubtraction.frame = CGRectMake(76+382+76+50-80, 44+85+40+50+80+40+10, 20, 20);
    [detailView addSubview:btSubtraction];
    
    UIButton *btPlus = [UIButton buttonWithType:UIButtonTypeCustom];
    [btPlus setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [btPlus addTarget:self action:@selector(plus) forControlEvents:UIControlEventTouchUpInside];
    btPlus.frame = CGRectMake(76+382+76+50+100-80, 44+85+40+50+80+40+10, 20, 20);
    [detailView addSubview:btPlus];
    
    textField = [[UITextField alloc]initWithFrame:CGRectMake(76+382+76+50+30-80, 44+85+40+50+80+40+5, 60, 30)];
    textField.text = @"0";
    textField.font = [UIFont systemFontOfSize:24];
    textField.textColor = [UIColor colorWithRed:0.224 green:0.463 blue:1 alpha:1];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.enabled = NO;
    [detailView addSubview:textField];
    
    btBuy = [UIButton buttonWithType:UIButtonTypeCustom];
    btBuy.frame = CGRectMake(76+382+76-80, 44+85+359-52, 175, 50);
    [btBuy setImage:[UIImage imageNamed:@"shopping"] forState:UIControlStateNormal];
    [btBuy addTarget:self action:@selector(shopping:) forControlEvents:UIControlEventTouchUpInside];
    [detailView addSubview:btBuy];

    webView = [[UIWebView alloc]initWithFrame:CGRectMake(650, 20+88, 1024-750, 400)];
    webView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//    webView.scalesPageToFit=YES;
    [detailView addSubview:webView];
    [(UIScrollView *)[[webView subviews] objectAtIndex:0]    setBounces:NO];
//    NSLog(@"%@",[webView subviews]);
    
    
    
//    btShopping = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btShopping setImage:[UIImage imageNamed:@"shopping"] forState:UIControlStateNormal];
//    btShopping.frame = CGRectMake(1024-8-178+(179-136)/2, 44+8+20, 136, 25);
//    [btShopping addTarget:self action:@selector(shopping:) forControlEvents:UIControlEventTouchUpInside];
//    //    [detailView addSubview:btShopping];
    
//    shareView = [[UIImageView alloc]initWithFrame:CGRectMake(1024-8-178, 44+8, 179, 97/2)];
//    shareView.layer.cornerRadius = 12;
//    shareView.layer.masksToBounds = YES;
//    shareView.backgroundColor = [UIColor blackColor];
//    [detailView addSubview:shareView];

//    btWeibo = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btWeibo setImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
//    btWeibo.frame = CGRectMake(1024-190, 44+8+20-20, 62, 48);
//    [btWeibo addTarget:self action:@selector(weibo:) forControlEvents:UIControlEventTouchUpInside];
//    [detailView addSubview:btWeibo];
    
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    sinaweibo.delegate = self;
    m_serviceGetProductlist = [[serviceGetProductlist alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
    [m_serviceGetProductlist sendRequestWithData:[NSString stringWithFormat:@"device=pad&type=%@",[dicTypeData objectForKey:@"tid"]] addr:@"getproductlist?"];
    
    
    [self.activity stopAnimating];
    self.activity.alpha = 0;
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
    UIButton *btWeibo = [UIButton buttonWithType:UIButtonTypeCustom];
    btWeibo.frame = CGRectMake(0, 0, 60, 30);
    [btWeibo setBackgroundImage:[UIImage imageNamed:@"btWeibo"] forState:UIControlStateNormal];
    [btWeibo addTarget:self action:@selector(weibo:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:btWeibo];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    m_serviceGetProductdetail = [[serviceGetProductdetail alloc]initWithDelegate:self requestMode:TRequestMode_Asynchronous];

  
}

- (void)setMyLayout
{

}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration NS_AVAILABLE_IOS(3_0)//当发送旋屏事件后，就会掉用该方法
{
    [self setMyLayout];
}

- (void)shopping:(id)sender
{
//    UIButton *bt = sender;
    NSInteger num = [textField.text integerValue];
    if (num<1 || num > [stock integerValue]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"数量不可为0或大于库存"
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
        [alert show];
    }else{
        m_serviceAddproduct = [[serviceAddproduct alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
        NSString *pid = [dicProductDetail objectForKey:@"pid"];
        NSString *num = textField.text;
        NSString *price = [dicProductDetail objectForKey:@"price"];
        NSString *oid = [[NSUserDefaults standardUserDefaults] objectForKey:@"oid"];
        NSString *str;
        if (oid == nil) {
            str = [NSString stringWithFormat:@"pid=%@&num=%@￼￼&price=%@",pid,num,price];
        }else{
            str = [NSString stringWithFormat:@"pid=%@&num=%@￼￼&price=%@&oid=%@",pid,num,price,oid];
        }
        
        [m_serviceAddproduct sendRequestWithData:str addr:@"addproduct?"];
    }
}

- (void)weibo:(id)sender
{
//    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dicProductDetail objectForKey:@"bpic"]]]];
    SinaWeibo *sinaweibo = [self sinaweibo];
    if ([sinaweibo isAuthValid]) {
        
        [sinaweibo requestWithURL:@"statuses/upload.json"
                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   imageProduct.image,@"pic",[dicProductDetail objectForKey:@"pname"], @"status",nil]
                       httpMethod:@"POST"
                         delegate:self];

    }else{
        [sinaweibo logIn];
    }

}

- (void)buy
{
    PayView *payView = [[PayView alloc]initWithFrame:CGRectMake(1024/2-470/2, 768/2-610/2, 470, 520)];
    [self.view addSubview:payView];
    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"目前版本还无法购买"
//                                                   message:@"请等待下一版本发布"
//                                                  delegate:nil
//                                         cancelButtonTitle:@"确认"
//                                         otherButtonTitles:nil];
//    [alert show];
}

- (void)subtraction
{
    NSInteger num = [textField.text integerValue] - 1;
    if (num < 0) {
        num = 0;
    }
    textField.text = [NSString stringWithFormat:@"%i", num];
}

- (void)plus
{
    NSInteger num = [textField.text integerValue] + 1;
    textField.text = [NSString stringWithFormat:@"%i", num];

}

- (void)share
{
    isShareView = YES;
    [detailView addSubview:shareView];
    [detailView addSubview:btShopping];
//    [detailView addSubview:btWeibo];


}

- (void)closeDetail
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    detailView.frame = CGRectMake(0, -602, 1024, self.view.frame.size.height-166);
    btHide.frame = CGRectMake(453.5, self.view.frame.size.height-166-43+1, 150, 43);
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    isDetail = NO;

}


- (void)browseDetail:(id)sender
{
    btShare.enabled = NO;
    UIButton *bt = sender;
    NSUInteger i = bt.tag;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    triangle.frame = CGRectMake(200*i+50+64, 5.5, 22, 12);
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    if (isDetail) {
        NSString *str = [[arrProductlist objectAtIndex:i] objectForKey:@"pid"];
        imageProduct.image = nil;
        [imageProduct addSubview: activit1];
        activit1.hidden = NO;
        [activit1 startAnimating];
        textField.text = @"0";
        btShopping.tag = i;
//        btWeibo.tag = i;
        isDetail = YES;
//        label1.text = @"";
        label3.text = @"";
        label4.text = @"";
//        m_serviceGetProductdetail = [[serviceGetProductdetail alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
        [m_serviceGetProductdetail clearDelegates];
        [m_serviceGetProductdetail sendRequestWithData:[NSString stringWithFormat:@"device=pad&pid=%@",str] addr:@"getproductdetail?"];

        
    }else{
        [imageProduct addSubview: activit1];
        activit1.hidden = NO;
        [activit1 startAnimating];
        textField.text = @"0";
        btShopping.tag = i;
//        btWeibo.tag = i;
        tagi = i;
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        detailView.frame = CGRectMake(0, 0, 1024, self.view.frame.size.height-166);
        btHide.frame = CGRectMake(453.5, self.view.frame.size.height-43+1, 150, 43);
        [UIView setAnimationDidStopSelector: @selector(loadDetail)];
        [UIView setAnimationDelegate:self];
        [UIView commitAnimations];
        
       
       
    }
}

- (void)loadDetail
{
    NSString *str = [[arrProductlist objectAtIndex:tagi] objectForKey:@"pid"];
    isDetail = YES;

//    m_serviceGetProductdetail = [[serviceGetProductdetail alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
    [m_serviceGetProductdetail clearDelegates];
    [m_serviceGetProductdetail sendRequestWithData:[NSString stringWithFormat:@"device=pad&pid=%@",str] addr:@"getproductdetail?"];
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
        btHide.frame = CGRectMake(453.5, self.view.frame.size.height-5.5-43+1, 150, 43);
        thumbnailView.frame = CGRectMake(0,self.view.frame.size.height-5.5, 1024, 166);
        btHide.tag = 0;
    }else{
        [btHide setImage:[UIImage imageNamed:@"btHide"] forState:UIControlStateNormal];
        btHide.frame = CGRectMake(453.5, self.view.frame.size.height-43-166+1, 150, 43);
        thumbnailView.frame = CGRectMake(0, self.view.frame.size.height-166, 1024, 166);
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
   
//    if (isShareView) {
//        [shareView removeFromSuperview];
//        [btShopping removeFromSuperview];
//        [btWeibo removeFromSuperview];
//        isShareView = NO;
//    }else{
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
//    }
    //    [super.navigationController setToolbarHidden:isflage animated:TRUE];
}


#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{

//    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dicProductDetail objectForKey:@"bpic"]]]];
    if ([sinaweibo isAuthValid]) {
        
        [sinaweibo requestWithURL:@"statuses/upload.json"
                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   imageProduct.image,@"pic",[dicProductDetail objectForKey:@"pname"], @"status",nil]
                       httpMethod:@"POST"
                         delegate:self];
//        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage im]]
//        UIImage *image = [UIImage imageWithData:<#(NSData *)#>:path];
        
//        [sinaweibo requestWithURL:@"statuses/upload.json"
//                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                   textView.text, @"status",
//                                   image, @"pic", nil]
//                       httpMethod:@"POST"
//                         delegate:self];

    }
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    //    NSLog(@"sinaweiboDidLogOut");
    //    [self removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    //    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    //    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    //    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    //    [self removeAuthData];
}

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
//    [MobClick event:@"shareFail" attributes:error.userInfo];
    //    NSLog(@"sinaweibo logInDidFailWithError %@", error.userInfo);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"分享失败!" message:[error.userInfo objectForKey:NSLocalizedDescriptionKey] delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [alert show];
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
//    [MobClick event:@"shareSucceed"];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"分享到微博成功!" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [alert show];
}


- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}


#pragma mark -
#pragma mark serviceCallBack
- (void)serviceGetProductlistCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
{
    
    if (arrCallBack == nil || [arrCallBack count] == 0) {
        NSLog(@"GetProductlist nil");
    }else{
        
        arrProductlist = [[NSArray alloc]initWithArray:arrCallBack];
        m_ScrollView.contentSize = CGSizeMake(50+200*[arrProductlist count],119);//170*158
        NSUInteger i = 0;
        
        for (NSDictionary *dic in arrProductlist) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            [bt setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"pic"]]]] forState:UIControlStateNormal];
            [bt addTarget:self action:@selector(browseDetail:) forControlEvents:UIControlEventTouchUpInside];
            bt.frame = CGRectMake(50+i*200, 28, 128, 119);
            bt.tag = i;
            [m_ScrollView addSubview:bt];
            i++;
        }
        triangle.frame = CGRectMake(50+64, 5.5, 22, 12);
        [m_ScrollView addSubview:triangle];


    }
}

- (void)serviceGetProductdetailCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
{
    
    if (arrCallBack == nil || [arrCallBack count] == 0) {
        NSLog(@"GetProductdetail nil");
    }else{
        
        dicProductDetail = [[NSDictionary alloc]initWithDictionary:[arrCallBack objectAtIndex:0]];
        btShare.enabled = YES;
        imageProduct.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dicProductDetail objectForKey:@"bpic"]]]];
        [activit1 stopAnimating];
        [activit1 removeFromSuperview];
//        label1.text = [dicProductDetail objectForKey:@"pname"];
//        label2.text = [dicProductDetail objectForKey:@""];

        [label3 setText:[NSString stringWithFormat:@"%@元",[dicProductDetail objectForKey:@"price"]]];
        stock = [dicProductDetail objectForKey:@"stock"];
        NSLog(@"%@",[dicProductDetail objectForKey:@"stock"]);
        label4.text = [NSString stringWithFormat:@"库存:   %@",stock];
        NSLog(@"%@",label4.text);
        NSString *html = [arrCallBack objectAtIndex:1];
//        NSURL *baseURL = [NSURL URLWithString:[NSString stringWithContentsOfURL:<#(NSURL *)#> encoding:<#(NSStringEncoding)#> error:<#(NSError *__autoreleasing *)#>]]
        NSURL *baseURL = [NSURL URLWithString:@"http://www.nongfafd.com/Public/detail.css"];
//        [webView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
        [webView loadHTMLString:html baseURL:baseURL];

    }
}

- (void)serviceAddproductCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
{
    
    if (arrCallBack == nil || [arrCallBack count] == 0) {
        NSLog(@"Addproduct nil");
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"成功加入购物车"
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles: nil];
        [alert show];
               
    }
}


@end
