//
//  EveryMomentViewController.h
//  NFFD
//
//  Created by Myth on 13-7-16.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityViewController.h"
#import "serviceGettype.h"
#import "ShoppingViewController.h"

@interface EveryMomentViewController : UIViewController<UIScrollViewDelegate>{
    UIScrollView *m_scrollView;
    serviceGettype *m_serviceGettype;
    NSArray *arrTypeData;
    ShoppingViewController *m_ShoppingViewController;
    UIView *activity;
    UIActivityIndicatorView *activityIndicatorView;
}


- (void)load;

@end
