//
//  serviceInterface.h
//  StarBucks
//
//  Created by 浩洋 朱 on 12-5-24.
//  Copyright (c) 2012年 首正. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "ASIFormDataRequest.h"
#import "PublicDefine.h"
//#import "GDataXMLNode.h"
#import <QuartzCore/QuartzCore.h>
#import "Error.h"
//#import "SBJson.h"
#import "JSONKit.h"
//@class Error;
#import "DDXML.h"

typedef enum  requestMode
{
	TRequestMode_Synchronous = 1,
	TRequestMode_Asynchronous = 2,
}TRequestMode;

@protocol serviceCallBackDelegate;


@class ASIFormDataRequest;
@interface serviceInterface : NSObject 
<ASIHTTPRequestDelegate>
{
	ASIFormDataRequest *m_request;
	TRequestMode m_requestMode;
	
	// delegate
	id delegate;
	
	// callBack data
	NSMutableArray *m_arrReceiveData;
	
	// Error
	Error *m_error;
}

//@property (nonatomic, strong) ASIHTTPRequest *m_request;
//@property (nonatomic) TRequestMode m_requestMode;
//@property (nonatomic, strong) Error *m_error;
//@property (nonatomic,weak) id<serviceCallBackDelegate> delegate;
//@property (nonatomic,strong)NSMutableDictionary *m_dicReceiveData;
//-(id)initWithDelegate:(id<serviceCallBackDelegate>)aDelegate
//		  requestMode:(TRequestMode)mode;
-(void)sendRequestWithData:(NSString *)str addr:(NSString *)addr;
//- (NSString *)encodeToPercentEscapeString: (NSString *) input;
//- (NSString *)decodeFromPercentEscapeString: (NSString *) input;
- (void)clearDelegates;
@end

@protocol serviceCallBackDelegate<NSObject>
-(void)serviceCallBack:(NSArray*)arrCallBack withErrorMessage:(Error*)error;
@end
