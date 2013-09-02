//
//  MagazineViewController.h
//  NFFD
//
//  Created by Myth on 13-8-28.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "serviceGetarticledetail.h"
#import "EGOImageView.h"
#import "EGOImageLoader.h"
@interface MagazineViewController : UIViewController<UIScrollViewDelegate,EGOImageViewDelegate>{
    UIScrollView *m_scrollView;
    serviceGetarticledetail *m_serviceGetarticledetail;
    UIActivityIndicatorView *activity;
    NSString *m_aid;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil aid:(NSString *)aid title:(NSString *)title;

@end
