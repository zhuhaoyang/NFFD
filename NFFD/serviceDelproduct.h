//
//  serviceDelproduct.h
//  NFFD
//
//  Created by Myth on 13-7-30.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "serviceInterface.h"

@protocol serviceDelproductCallBackDelegate;
@interface serviceDelproduct:serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceDelproductCallBackDelegate<NSObject>;

- (void)serviceDelproductCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
@end