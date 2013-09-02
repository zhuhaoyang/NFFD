//
//  AppDelegate.h
//  NFFD
//
//  Created by Myth on 13-7-16.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kAppKey             @"1466866354"
#define kAppSecret          @"f51b6b77ab8ed80b4ba2a6aeea866829"
#define kAppRedirectURI     @"http://www.sina.com"
#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif

@class SinaWeibo;
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) SinaWeibo *sinaweibo;

@end
