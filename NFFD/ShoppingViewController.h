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

@interface ShoppingViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>{
    UITableView *m_tableView;
    serviceGetorderdetail *m_serviceGetorderdetail;
    NSMutableArray *arrOrderdetail;
    serviceDelproduct *m_serviceDelproduct;
    UILabel *labTotalNum;
    UILabel *labTotalPrice;
}

- (void)reCompute:(NSString *)num row:(NSUInteger)row;

@end
