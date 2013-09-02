//
//  serviceGetarticle.h
//  NFFD
//
//  Created by Myth on 13-7-30.
//  Copyright (c) 2013年 Myth. All rights reserved.
//


#import "serviceInterface.h"


@protocol serviceGetarticleCallBackDelegate;
@interface serviceGetarticle:serviceInterface{
    id m_delegate;
}

- (id)initWithDelegate:(id)aDelegate requestMode:(TRequestMode)mode;

@end
@protocol serviceGetarticleCallBackDelegate<NSObject>;

- (void)serviceGetarticleCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
@end