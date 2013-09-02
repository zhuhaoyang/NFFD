//
//  serviceGetorderdetail.m
//  NFFD
//
//  Created by Myth on 13-7-30.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "serviceGetorderdetail.h"

@implementation serviceGetorderdetail
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
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"获取购物车数据失败!"
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
        [alert show];
        
    }else{
        if ([[[items objectAtIndex:0] stringValue] isEqualToString:@"1"] ) {
            items = [xmlDoc nodesForXPath:@"//product" error:nil];
            for (DDXMLNode *element in items) {
                
                NSArray *arr = [element children];
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
                for (DDXMLElement *node in arr) {
                    [dic setObject:[node stringValue] forKey:[node name]];
                }
                [m_arrReceiveData addObject:dic];
            }
            
        }else if([[[items objectAtIndex:0] stringValue] isEqualToString:@"2"]){
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"获取购物车数据失败!"
                                                           message:nil
                                                          delegate:nil
                                                 cancelButtonTitle:@"确认"
                                                 otherButtonTitles:nil];
            [alert show];
        }
        
    }
    
    
    //    m_dicReceiveData = [[NSMutableDictionary alloc] initWithDictionary:[json objectFromJSONString]];
    
}

- (void)passDataOutWithError:(Error*)error
{
	if (nil != m_delegate
		&& [m_delegate respondsToSelector:@selector(serviceGetorderdetailCallBack:withErrorMessage:)])
	{
		[m_delegate serviceGetorderdetailCallBack:m_arrReceiveData withErrorMessage:error];
	}
}


@end
