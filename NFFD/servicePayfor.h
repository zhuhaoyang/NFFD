//
//  servicePayfor.h
//  NFFD
//
//  Created by Myth on 13-9-10.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "serviceInterface.h"

@protocol servicePayforCallBackDelegate;
@interface servicePayfor:serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;
-(void)sendRequestWithData:(NSDictionary*)dic addr:(NSString *)addr;
@end
@protocol servicePayforCallBackDelegate<NSObject>;

- (void)servicePayforCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
@end