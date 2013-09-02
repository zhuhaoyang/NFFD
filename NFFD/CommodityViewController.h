//
//  CommodityViewController.h
//  NFFD
//
//  Created by Myth on 13-7-18.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "AppDelegate.h"
#import "serviceGetProductlist.h"
#import "serviceGetProductdetail.h"
#import "EGOImageView.h"
#import "serviceAddproduct.h"

@interface CommodityViewController : UIViewController<SinaWeiboDelegate,SinaWeiboRequestDelegate
,UIScrollViewDelegate>{
    BOOL isHide;
    UIScrollView *thumbnailView;
    UIButton *btHide;
    UIScrollView *m_ScrollView;
    UIView *detailView;
    BOOL isDetail;
    
    UILabel *label1;
//    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UILabel *label5;
    UITextField *textField;
    UIButton *btBuy;
    
    UIImageView *shareView;
    UIButton *btShare;
    UIButton *btShopping;
    UIButton *btWeibo;
    
    BOOL isShareView;
    NSDictionary *dicTypeData;
    NSArray *arrProductlist;
    NSDictionary *dicProductDetail;
    UIImageView *imageProduct;
    serviceGetProductlist *m_serviceGetProductlist;
    serviceGetProductdetail *m_serviceGetProductdetail;
    serviceAddproduct *m_serviceAddproduct;
//    IBOutlet UIActivityIndicatorView *activity;
    UIActivityIndicatorView *activit1;
    NSUInteger tagi;
    UIImageView *triangle;
    UIWebView *webView;
}
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *activity;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil typeData:(NSDictionary *)dic;
- (void)setMyLayout;

@end
