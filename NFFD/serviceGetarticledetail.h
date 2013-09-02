//
//  serviceGetarticledetail.h
//  NFFD
//
//  Created by Myth on 13-8-28.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "serviceInterface.h"



@protocol serviceGetarticledetailCallBackDelegate;
@interface serviceGetarticledetail:serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceGetarticledetailCallBackDelegate<NSObject>;

- (void)serviceGetarticledetailCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
@end