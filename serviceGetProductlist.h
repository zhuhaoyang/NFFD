//
//  serviceGetProductlist.h
//  NFFD
//
//  Created by Myth on 13-7-29.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "serviceInterface.h"

@protocol serviceGetProductlistCallBackDelegate;
@interface serviceGetProductlist:serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceGetProductlistCallBackDelegate<NSObject>;

- (void)serviceGetProductlistCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
@end