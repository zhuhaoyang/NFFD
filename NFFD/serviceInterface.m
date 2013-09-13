//
//  serviceInterface.m
//  StarBucks
//
//  Created by 浩洋 朱 on 12-5-24.
//  Copyright (c) 2012年 首正. All rights reserved.
//

#import "serviceInterface.h"


@interface serviceInterface(private)
//- (GDataXMLElement *)creatRequestBody:(NSDictionary*)aDic key:(NSString *)key;
- (void)parseResponseData:(NSString *)xml;
- (void)passDataOutWithError:(Error*)error;
- (void)start;
@end


@implementation serviceInterface
//@synthesize m_request = _m_request;
//@synthesize m_requestMode;
//@synthesize m_error = _m_error;
//@synthesize m_dicReceiveData = _m_dicReceiveData;
#pragma mark -
#pragma mark Initialization & Deallocation

-(id)init
{
	self = [super init];
	if (self)
	{
		m_request = nil;
		m_arrReceiveData = nil;
		m_error = [[Error alloc] init];
		m_requestMode = TRequestMode_Asynchronous;// set default
	}
	return self;
}

- (void)clearDelegates
{
    [m_request clearDelegatesAndCancel];
}

//-(id)initWithDelegate:(id<serviceCallBackDelegate>)aDelegate 
//		  requestMode:(TRequestMode)mode
//{
//	self = [self init];
//	if (self)
//	{
//		m_delegate = aDelegate;
//		m_requestMode = mode;
//	}
//	return self;
//}

//-(void)dealloc
//{
//	[super dealloc];
//	if (nil != m_request) [m_request cancel];
//	[m_request release];
//	[m_dicReceiveData release];
//	[m_error release];
//}

#pragma mark -
#pragma mark RequestCreation and Request sending
//- (NSString *)encodeToPercentEscapeString: (NSString *) input
//{
//    // Encode all the reserved characters, per RFC 3986
//    // (<http://www.ietf.org/rfc/rfc3986.txt>)
//    NSString *outputStr = (__bridge NSString *)
//    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                            (CFStringRef)input,
//                                            NULL,
//                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
//                                            kCFStringEncodingUTF8);
//    NSString *str = [NSString stringWithString:outputStr];
//    return str;
//}
//
//- (NSString *)decodeFromPercentEscapeString: (NSString *) input
//{
//    NSMutableString *outputStr = [NSMutableString stringWithString:input];
//    [outputStr replaceOccurrencesOfString:@"+"
//                               withString:@" "
//                                  options:NSLiteralSearch
//                                    range:NSMakeRange(0, [outputStr length])];
//    
//    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//}
-(void)sendRequestForPOSTWithData:(NSDictionary*)dic addr:(NSString *)addr
{
    NSString *theServerAddr	= @"http://119.37.199.212/api/";
    //拼凑请求地址
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",theServerAddr,addr]];
    m_request = [[ASIFormDataRequest alloc] initWithURL:url];
    [m_request addRequestHeader:@"Content-type" value:@"application/octet-stream"];
    NSArray *arrKeys = [dic allKeys];
    
    for (NSString *key in arrKeys) {
        [m_request setPostValue:[dic objectForKey:key] forKey:key];
    }
    [m_request setRequestMethod:@"POST"]; // set post method
    [m_request setTimeOutSeconds:kTimeOutDuration]; // set time out duration
    [m_request setDelegate:self];
    [self start];
    //    [request setPostValue:[[[AppDelegate App].orderDetalArray objectAtIndex:0] objectForKey:@"oid"] forKey:@"oid"];
    //    [request setPostValue:[NSString stringWithFormat:@"%0.2f",value] forKey:@"cost"];
    //    [request setPostValue:addressField.text forKey:@"addr"];
    //    [request setPostValue:telField.text forKey:@"tel"];
    //    [request setPostValue:nameField.text forKey:@"man"];
    //    [request setPostValue:mobileField.text forKey:@"mobile"];
    //    [request setPostValue:[NSString stringWithFormat:@"%d",selectAct] forKey:@"type"];
    //    [request setPostValue:MarkField.text forKey:@"mark"];
    //    [request setShouldStreamPostDataFromDisk:YES];
    //    [request setDelegate:self];
    //    [request setRequestMethod:@"POST"];
    //    [request setTimeOutSeconds:100];
    //    [request setDidFinishSelector:@selector(uploadFinished:)];
    //    [request setDidFailSelector:@selector(uploadFailed:)];
    //    [request startAsynchronous];
    
    
  }



-(void)sendRequestWithData:(NSString*)str addr:(NSString *)addr
{
    NSString *theServerAddr	= @"http://119.37.199.212/api/";
    //拼凑请求地址
    NSString *httpStr;
    if (str == nil) {
        httpStr = [[[NSString alloc] initWithFormat:@"%@%@",theServerAddr,addr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else{
        httpStr = [[[NSString alloc] initWithFormat:@"%@%@%@",theServerAddr,addr,str] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }

    NSURL *url = [NSURL URLWithString:httpStr];


    // Initialization the http engine (required)
    m_request = [[ASIFormDataRequest alloc] initWithURL:url];
    [m_request setRequestMethod:@"GET"]; // set post method
    [m_request setTimeOutSeconds:kTimeOutDuration]; // set time out duration
    [m_request setDelegate:self];
    NSLog(@"required = %@",httpStr);
    [self start];
}

- (void)start
{
    
	switch (m_requestMode)
	{
		case TRequestMode_Synchronous:
		{
			[m_request startSynchronous];
            
			NSError *error = [m_request error];
			if (!error)
			{
                //				NSString *sReponse = [m_request responseString];
                //				[self parseResponseData:sReponse];
                //				[self passDataOutWithError:m_error];
			}
			else
			{
				if (nil != m_arrReceiveData)
				{
                    //					SAFE_RELEASE(m_dicReceiveData);
				}
                //				m_error.m_NSError = error;
                //				[self passDataOutWithError:m_error];
			}
			break;
		}
		case TRequestMode_Asynchronous:
		default:
		{
			[m_request startAsynchronous];
			break;
		}
	}

}

// Create the body
//- (GDataXMLElement *)creatRequestBody:(NSDictionary*)aDic key:(NSString *)key
//{
//	GDataXMLElement * rootElement = [GDataXMLNode elementWithName:key];
//	GDataXMLElement * oneElement;
//	NSArray * allKeys = [aDic allKeys];
//	NSUInteger i, count = [allKeys count];
//	for(i = 0; i < count; i++){
//		
//		if ([[aDic objectForKey:[allKeys objectAtIndex:i]] isKindOfClass:[NSDictionary class]]) {
//			oneElement = [self creatRequestBody:[aDic objectForKey:[allKeys objectAtIndex:i]] key:[allKeys objectAtIndex:i]];
//		}else {
//			oneElement = [GDataXMLNode elementWithName:[allKeys objectAtIndex:i]
//										   stringValue:[aDic objectForKey:[allKeys objectAtIndex:i]]];
//		}
//		[rootElement addChild:oneElement];
//	}	
//	return rootElement;
//}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [request clearDelegatesAndCancel];
	NSString *sReponse = [request responseString];
	[self parseResponseData:sReponse];
	[self passDataOutWithError:m_error];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [request clearDelegatesAndCancel];
	NSError *error = [request error];
	if (nil != m_arrReceiveData)
	{
//		SAFE_RELEASE(m_dicReceiveData);
	}
	m_error.m_NSError = error;
	[self passDataOutWithError:m_error];
}

#pragma mark -
#pragma mark ReponseParsing
- (void)parseResponseData:(NSString *)xml
{
//	if (xml == nil || [xml isEqualToString:@""])
//	{
//		NSString *sMsg = [[NSString alloc] initWithFormat:@"Empty response xml file!"];
//		m_error.m_Message = sMsg;
//		SAFE_RELEASE(sMsg);
//		return;
//	}
//    
//	LOGS(@"xml = %@",xml);
//	
//	// Prepare the callback data (required)
//	if (nil != m_dicReceiveData)
//	{
//		SAFE_RELEASE(m_dicReceiveData);
//	}
//	
//	
//	m_dicReceiveData = [[NSMutableDictionary alloc] init];
//	NSError *error = [[NSError alloc] init];
//    
//	GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:&error];
//    if (doc == nil) { return; }
//	
//	GDataXMLElement *rootElement = [doc rootElement];
//	GDataXMLElement *oneElement;
//	NSString *keyName;
//	NSArray *children;
//	NSArray *array = [rootElement nodesForXPath:@"//body/retcode" error:nil];
//	if ([[[array objectAtIndex:0] stringValue] isEqualToString:@"0"]) {
//		
//		NSMutableArray *arrData = [[[NSMutableArray alloc] init] autorelease];
//		
//		array = [rootElement nodesForXPath:@"//body/*" error:nil];
//        
//		NSUInteger i, count = [array count];
//		if (count > 1) {
//			keyName = [[array objectAtIndex:1] name];
//		}
//		for (i = 1; i < count; i++) {
//			oneElement = [array objectAtIndex:i];
//			NSMutableDictionary *dicData = [[NSMutableDictionary alloc]init];
//			children = [oneElement children];
//			for(GDataXMLElement * element in children){
//				[dicData setObject:[element stringValue] forKey:[element name]];
//			}
//			[arrData addObject:dicData];
//			[dicData release];
//		}
//		
//		[m_dicReceiveData setObject:@"0" forKey:@"retcode"];
//		if (arrData != nil && [arrData count] != 0) {
//			[m_dicReceiveData setObject:arrData forKey:keyName];
//		}
//		
//		
//	}else{
//		[m_dicReceiveData setObject:[[array objectAtIndex:0] stringValue] forKey:[[array objectAtIndex:0] name]];
//		array = [rootElement nodesForXPath:@"//body/message" error:nil];
//		[m_dicReceiveData setObject:[[array objectAtIndex:0] stringValue] forKey:[[array objectAtIndex:0] name]];
//	}
//	LOGS(@"m_dicReceiveData = %@",m_dicReceiveData);
//	[doc release];
}


#pragma mark -
#pragma mark serviceCallBackDelegateCallBack
- (void)passDataOutWithError:(Error*)error
{
    //	if (nil != m_delegate
    //		&& [m_delegate respondsToSelector:@selector(serviceCallBack: withErrorMessage:)])
    //	{
    //		[m_delegate serviceCallBack:m_dicReceiveData withErrorMessage:error];
    //	}
}

@end

