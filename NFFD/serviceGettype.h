//
//  serviceGettype.h
//  NFFD
//
//  Created by Myth on 13-7-26.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "serviceInterface.h"


@protocol serviceGettypeCallBackDelegate;
@interface serviceGettype:serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceGettypeCallBackDelegate<NSObject>;

- (void)serviceGettypeCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
@end