//
//  servicePayfor.m
//  NFFD
//
//  Created by Myth on 13-9-10.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "servicePayfor.h"

@implementation servicePayfor
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
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提交订单失败!"
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
        [alert show];
        
    }else{
        [m_arrReceiveData addObject:[[items objectAtIndex:0] stringValue]];
    }
    
    
    //    m_dicReceiveData = [[NSMutableDictionary alloc] initWithDictionary:[json objectFromJSONString]];
    
}

- (void)passDataOutWithError:(Error*)error
{
	if (nil != m_delegate
		&& [m_delegate respondsToSelector:@selector(servicePayforCallBack:withErrorMessage:)])
	{
		[m_delegate servicePayforCallBack:m_arrReceiveData withErrorMessage:error];
	}
}


@end
