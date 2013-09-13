//
//  PayedorderViewController.m
//  NFFD
//
//  Created by Myth on 13-9-9.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "PayedorderViewController.h"

@interface PayedorderViewController ()

@end

@implementation PayedorderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UINavigationBar *bar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
//        bar.tintColor = [UIColor colorWithRed:0.573 green:0.498 blue:0.431 alpha:1];
        [bar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
        UINavigationItem *titleItem = [[UINavigationItem alloc]init];
        //        UINavigationItem *bar = [UINavigationItem alloc];
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 60, 30);
        [backButton setBackgroundImage:[UIImage imageNamed:@"btBack"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        [titleItem setLeftBarButtonItem:rightButton];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        title.text = @"我的订单";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor colorWithRed:0.808 green:0.757 blue:0.647 alpha:1];
        title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        title.font = [UIFont boldSystemFontOfSize:25];
        titleItem.titleView = title;
        [bar setItems:[[NSArray alloc]initWithObjects:titleItem, nil]];
        [self.view addSubview:bar];
//        oid = @"1234567890";
        
        //        if (arrOid == nil) {
//            arrOid = [[NSMutableArray alloc]initWithCapacity:0];
//        }
//        arrOid = [[NSArray alloc]initWithObjects:@"E5ED42F35597BE35E040007F01004E0E",@"E5ED42F35597BE35E040007F01004E0E",@"E5ED42F35597BE35E040007F01004E0E",@"E5ED42F35597BE35E040007F01004E0E",@"E5ED42F35597BE35E040007F01004E0E",@"E5ED42F35597BE35E040007F01004E0E",@"E5ED42F35597BE35E040007F01004E0E",@"E5ED42F35597BE35E040007F01004E0E",@"E5ED42F35597BE35E040007F01004E0E",@"E5ED42F35597BE35E040007F01004E0E",@"E5ED42F35597BE35E040007F01004E0E", nil];
        
        m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 1024, 768-20-44) style:UITableViewStylePlain];
        m_tableView.delegate = self;
        m_tableView.dataSource = self;
        m_tableView.backgroundColor = [UIColor colorWithRed:0.984 green:0.984 blue:0.984 alpha:1];
        [self.view addSubview:m_tableView];

    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSURL *documentsDictoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsDictoryURL URLByAppendingPathComponent:@"OrderedOid.plist"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfURL:storeURL];
    if (dic == nil) {
        dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
//    NSLog(@"old dic =%@",dic);
    arrOid = [[NSArray alloc]initWithArray:[dic objectForKey:@"oid"]];

    NSString *str;
    arrOrder = [[NSMutableArray alloc]initWithCapacity:0];
    if (arrOid != nil) {
        m_serviceGetorderdetail = [[serviceGetorderdetail alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
        for (NSString * oid in arrOid) {
            str = [NSString stringWithFormat:@"oid=%@",oid];
            [m_serviceGetorderdetail sendRequestWithData:str addr:@"getorderdetai?"];
        }
    }


}

- (void)back
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(1024, 0, 1024, 768);
    [UIView setAnimationDidStopSelector: @selector(remove)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];

}

- (void)remove
{
    [self.view removeFromSuperview];
}

#pragma mark -
#pragma mark tableview delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 61)];
    headerView.backgroundColor = [UIColor colorWithRed:0.980 green:0.965 blue:0.925 alpha:1];
    //    [headerView setTitle:[NSString stringWithFormat:@"您在%@附近",placemark.name] forState:UIControlStateNormal];
    UIImageView *line1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line.jpg"]];
    line1.frame = CGRectMake(0, 60, 1024, 1);
    [headerView addSubview:line1];
    UIImageView *line2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line.jpg"]];
    line2.frame = CGRectMake(0, 0, 1024, 1);
    [headerView addSubview:line2];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(25, 22, 1000, 20)];
    label1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    label1.text = [NSString stringWithFormat:@"订单号:%@",[arrOid objectAtIndex:section]];
    label1.font = [UIFont systemFontOfSize:20];
    label1.textColor = [UIColor colorWithRed:0.4667 green:0.408 blue:0.349 alpha:1];
    [headerView addSubview:label1];
    
       return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 61;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma mark tableview datasource


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.backgroundColor = [UIColor colorWithRed:0.984 green:0.984 blue:0.984 alpha:1];
    
    NSUInteger row = [indexPath row];
    NSUInteger sections = [indexPath section];
    EGOImageView *image = [[EGOImageView alloc]initWithFrame:CGRectMake(23, 13, 84, 79)];
    image.imageURL = [NSURL URLWithString:[[[arrOrder objectAtIndex:sections] objectAtIndex:row] objectForKey:@"pic"]];
    //    image.backgroundColor = [UIColor blackColor];
    [cell addSubview:image];
    
    UILabel *labName = [[UILabel alloc]initWithFrame:CGRectMake(155, 30, 500, 50)];
    labName.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    labName.text = [[[arrOrder objectAtIndex:sections] objectAtIndex:row] objectForKey:@"pname"];
    labName.font = [UIFont systemFontOfSize:18];
    labName.textColor = [UIColor colorWithRed:0.4667 green:0.408 blue:0.349 alpha:1];
    [cell addSubview:labName];
    
    UILabel *labNum = [[UILabel alloc]initWithFrame:CGRectMake(568, 30, 68, 50)];
    NSUInteger num = [[[[arrOrder objectAtIndex:sections] objectAtIndex:row] objectForKey:@"num"] integerValue];
    labNum.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    labNum.text = [NSString stringWithFormat:@"数量:%d",num];
    labNum.textAlignment = NSTextAlignmentCenter;
    labNum.font = [UIFont systemFontOfSize:18];
    labNum.textColor = [UIColor colorWithRed:0.4667 green:0.408 blue:0.349 alpha:1];
    [cell addSubview:labNum];
    
   
    
    UILabel *labPrice = [[UILabel alloc]initWithFrame:CGRectMake(730, 39, 300, 30)];
    float price = [[[[arrOrder objectAtIndex:sections] objectAtIndex:row] objectForKey:@"price"] floatValue] * num;
    labPrice.text = [NSString  stringWithFormat:@"价格: %.2f 元",price];
    labPrice.font = [UIFont systemFontOfSize:24];
    labPrice.textColor = [UIColor colorWithRed:0.224 green:0.463 blue:1 alpha:1];
    labPrice.backgroundColor = [UIColor clearColor];
    labPrice.textAlignment = NSTextAlignmentLeft;
    [cell addSubview:labPrice];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[arrOrder objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrOrder count];
}

#pragma mark -
#pragma mark serviceCallBack
- (void)serviceGetorderdetailCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
{
    
    if (arrCallBack == nil || [arrCallBack count] == 0) {
        NSLog(@"GetOrderdetail nil");
    }else{
        
//        arrOrderdetail = [[NSMutableArray alloc]initWithArray:arrCallBack];
        [arrOrder addObject:arrCallBack];
        [m_tableView reloadData];
    }
}

@end
