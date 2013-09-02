//
//  serviceAddproduct.h
//  NFFD
//
//  Created by Myth on 13-7-30.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "serviceInterface.h"

@protocol serviceAddproductCallBackDelegate;
@interface serviceAddproduct:serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceAddproductCallBackDelegate<NSObject>;

- (void)serviceAddproductCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
@end