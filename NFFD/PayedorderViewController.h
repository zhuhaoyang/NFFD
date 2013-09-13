//
//  PayedorderViewController.h
//  NFFD
//
//  Created by Myth on 13-9-9.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "serviceGetorderdetail.h"
@interface PayedorderViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>{
    UITableView *m_tableView;
//    NSString *oid;
    serviceGetorderdetail *m_serviceGetorderdetail;
    NSMutableArray *arrOrder;
    NSMutableArray *arrOrderdetail;
    NSArray *arrOid;
}

@end
