//
//  serviceGetProductdetail.h
//  NFFD
//
//  Created by Myth on 13-7-29.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "serviceInterface.h"

@protocol serviceGetProductdetailCallBackDelegate;
@interface serviceGetProductdetail:serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceGetProductdetailCallBackDelegate<NSObject>;

- (void)serviceGetProductdetailCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
@end