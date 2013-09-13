//
//  serviceConfirmpay.h
//  NFFD
//
//  Created by Myth on 13-9-10.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "serviceInterface.h"

@protocol serviceConfirmpayCallBackDelegate;
@interface serviceConfirmpay:serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceConfirmpayCallBackDelegate<NSObject>;

- (void)serviceConfirmpayCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
@end