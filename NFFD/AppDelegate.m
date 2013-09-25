//
//  AppDelegate.m
//  NFFD
//
//  Created by Myth on 13-7-16.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "SinaWeibo.h"


#import "AlixPay.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import <sys/utsname.h>

@interface AppDelegate ()

- (BOOL)isSingleTask;
- (void)parseURL:(NSURL *)url application:(UIApplication *)application;

@end

@implementation AppDelegate

- (BOOL)isSingleTask{
	struct utsname name;
	uname(&name);
	float version = [[UIDevice currentDevice].systemVersion floatValue];//判定系统版本。
	if (version < 4.0 || strstr(name.machine, "iPod1,1") != 0 || strstr(name.machine, "iPod2,1") != 0) {
		return YES;
	}
	else {
		return NO;
	}
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
//    UIImageView *startLoge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
//    startLoge.frame = CGRectMake(0, 0, 1024, 768);
    
//    [self.window addSubview:startLoge];

    
    float device = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSLog(@"%f",device);
    if (device >= 7) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"iOS7"];
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"iOS7"];
    }
    /*
	 *单任务handleURL处理
	 */
	if ([self isSingleTask]) {
		NSURL *url = [launchOptions objectForKey:@"UIApplicationLaunchOptionsURLKey"];
		
		if (nil != url) {
			[self parseURL:url application:application];
		}
	}


    
    

    
    self.sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self.viewController];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        self.sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        self.sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        self.sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }

    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    if ([url.scheme isEqualToString:Key_weiXinAppID]) {
//        return [WXApi handleOpenURL:url delegate:self];
    [self parseURL:url application:application];
    return [self.sinaweibo handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [self parseURL:url application:application];
    return [self.sinaweibo handleOpenURL:url];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self.sinaweibo applicationDidBecomeActive];

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)parseURL:(NSURL *)url application:(UIApplication *)application {
	AlixPay *alixpay = [AlixPay shared];
	AlixPayResult *result = [alixpay handleOpenURL:url];
	if (result) {
		//是否支付成功
		if (9000 == result.statusCode) {
			/*
			 *用公钥验证签名
			 */
			id<DataVerifier> verifier = CreateRSADataVerifier([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA public key"]);
			if ([verifier verifyString:result.resultString withSign:result.signString]) {
                NSString *strMessage;
                if ([result.statusMessage length] == 0) {
                    strMessage = @"支付成功";
                }else{
                    strMessage = result.statusMessage;
                }
				UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
																	 message:strMessage
																	delegate:nil
														   cancelButtonTitle:@"确定"
														   otherButtonTitles:nil];
				[alertView show];
                m_serviceConfirmpay = [[serviceConfirmpay alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
                NSString *oid = [[NSUserDefaults standardUserDefaults]objectForKey:@"oid"];
                [m_serviceConfirmpay sendRequestWithData:[NSString stringWithFormat:@"oid=%@",oid] addr:@"confirmpay?"];
//				[alertView release];
			}//验签错误
			else {
				UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
																	 message:@"签名错误"
																	delegate:nil
														   cancelButtonTitle:@"确定"
														   otherButtonTitles:nil];
				[alertView show];
//				[alertView release];
			}
		}
		//如果支付失败,可以通过result.statusCode查询错误码
		else {
			UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
																 message:result.statusMessage
																delegate:nil
													   cancelButtonTitle:@"确定"
													   otherButtonTitles:nil];
			[alertView show];
//			[alertView release];
		}
		
	}
}

#pragma mark -
#pragma mark serviceCallBack
- (void)serviceConfirmpayCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
{
    
    if (arrCallBack == nil || [arrCallBack count] == 0) {
        NSLog(@"Confirmpay nil");
    }else{
        if ([[arrCallBack objectAtIndex:0]isEqualToString:@"1"]) {
                        
            
//            if (![[NSFileManager defaultManager] fileExistsAtPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"OrderedOid.plist"]]) {
//                NSLog(@"不存在");
//            }else{
//                NSLog(@"存在");
//            }
            NSURL *documentsDictoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
            NSURL *storeURL = [documentsDictoryURL URLByAppendingPathComponent:@"OrderedOid.plist"];
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfURL:storeURL];
            if (dic == nil) {
                dic = [[NSMutableDictionary alloc]initWithCapacity:0];
            }
            NSLog(@"old dic =%@",dic);
            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"oid"]];
            if (arr == nil) {
                arr = [[NSMutableArray alloc]initWithCapacity:0];
            }
            NSString *newOid = [[NSUserDefaults standardUserDefaults] objectForKey:@"oid"];
            
            [arr insertObject:newOid atIndex:0];
            [dic setObject:arr forKey:@"oid"];
            NSLog(@"now dic = %@",dic);
            BOOL isWrote = [dic writeToURL:storeURL atomically:YES];
            NSLog(@"is wrote = %d",isWrote);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            NSMutableDictionary *newDic = [[NSMutableDictionary alloc]initWithContentsOfURL:storeURL];
            NSLog(@"newDic = %@",newDic);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            [[NSNotificationCenter defaultCenter]postNotificationName:@"paySucceed" object:nil];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"oid"];
        }
    }
}

@end
