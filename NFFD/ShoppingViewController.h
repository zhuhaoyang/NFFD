//
//  ShoppingViewController.h
//  NFFD
//
//  Created by Myth on 13-7-25.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "serviceGetorderdetail.h"
#import "EGOImageView.h"
#import "serviceDelproduct.h"
#import "serviceAddproduct.h"
#import "PayView.h"
@interface ShoppingViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    UITableView *m_tableView;
    serviceGetorderdetail *m_serviceGetorderdetail;
    NSMutableArray *arrOrderdetail;
    serviceDelproduct *m_serviceDelproduct;
    serviceAddproduct *m_serviceAddproduct;
    UILabel *labTotalNum;
    UILabel *labTotalPrice;
    float totalPrice;
    NSMutableString *orderName;
    PayView *payView;
    BOOL isOver;
    NSUInteger editNum;
}

- (void)reCompute:(NSString *)num row:(NSUInteger)row;

@end
