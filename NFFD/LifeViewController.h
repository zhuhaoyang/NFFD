//
//  LifeViewController.h
//  NFFD
//
//  Created by Myth on 13-7-16.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "serviceGetarticle.h"
#import "EGOImageView.h"
#import "EGOImageButton.h"
#import "MagazineViewController.h"
@interface LifeViewController : UIViewController<UIScrollViewDelegate>{
    UIScrollView *m_scrollView;
    serviceGetarticle *m_serviceGetarticle;
    UIActivityIndicatorView *activity;
    BOOL isLoaded;
    NSArray *arrArticles;
}

@end
