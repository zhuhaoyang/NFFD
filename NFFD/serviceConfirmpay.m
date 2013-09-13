//
//  serviceConfirmpay.m
//  NFFD
//
//  Created by Myth on 13-9-10.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "serviceConfirmpay.h"

@implementation serviceConfirmpay
-(id)initWithDelegate:(id)aDelegate
		  requestMode:(TRequestMode)mode
{
	self = [self init];
	if (self)
	{
		m_delegate = aDelegate;
		m_requestMode = mode;
	}
	return self;
}

- (void)parseResponseData:(NSString *)xml
{
    if (xml == nil || [xml isEqualToString:@""])
	{
		NSString *sMsg = [[NSString alloc] initWithFormat:@"Empty response json file!"];
		m_error.m_Message = sMsg;
        //		SAFE_RELEASE(sMsg);
		return;
    }
    NSLog(@"%@",xml);
    
    
    //        NSString*result = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)xml,NULL,CFSTR("!*'();:@&=+$,/?%#[]"),kCFStringEncodingUTF8));
    
    
    //    NSData *data = [NSData dataWith]
    //    NSString *str = [[NSString stringWithFormat:@"%@",xml ] URLEncodedString];
    //    xml = @"<?xml version=\"1.0\" encoding=\"utf-8\"?><efence><nffd><res>xx</res ><types><type><tid>xx</tid></type</types></nffd > </efence>";
    //    SBJsonParser * parser = [[SBJsonParser alloc] init];
    //    NSError * error = nil;
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc]initWithXMLString:xml options:0 error:nil];
	
	/////解析
	NSArray *items = nil;
    m_arrReceiveData = [[NSMutableArray alloc]initWithCapacity:0];
    
    items = [xmlDoc nodesForXPath:@"//res" error:nil];
    if ([items count] == 0 || items == nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认支付结果失败!"
                                                       message:@"抱歉!您已经支付完成,但是确认失败,请记录订单号,并与客服联系:400-8866-007 (您可以同时按下电源键和home键截屏)"
                                                      delegate:nil
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
        [alert show];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"oid"];
        
    }else{
        if ([[[items objectAtIndex:0] stringValue] isEqualToString:@"1"]) {
            [m_arrReceiveData addObject:@"1"];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认支付结果失败!"
                                                           message:@"抱歉!您已经支付完成,但是确认失败,请记录订单号,并与客服联系:400-8866-007 (您可以同时按下电源键和home键截屏)"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确认"
                                                 otherButtonTitles:nil];
            [alert show];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"oid"];

        }
        
    }
    
    
    //    m_dicReceiveData = [[NSMutableDictionary alloc] initWithDictionary:[json objectFromJSONString]];
    
}

- (void)passDataOutWithError:(Error*)error
{
	if (nil != m_delegate
		&& [m_delegate respondsToSelector:@selector(serviceConfirmpayCallBack:withErrorMessage:)])
	{
		[m_delegate serviceConfirmpayCallBack:m_arrReceiveData withErrorMessage:error];
	}
}



@end
