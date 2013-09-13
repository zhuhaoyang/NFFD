//
//  ShoppingViewController.m
//  NFFD
//
//  Created by Myth on 13-7-25.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "ShoppingViewController.h"

@interface ShoppingViewController ()

@end

@implementation ShoppingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.view.frame = CGRectMake(0, -768, 1024, 768-20);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySucceed) name:@"paySucceed" object:nil];
        m_serviceAddproduct = [[serviceAddproduct alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
        m_serviceDelproduct = [[serviceDelproduct alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];

        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        title.text = @"购物车";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor colorWithRed:0.808 green:0.757 blue:0.647 alpha:1];
        title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        title.font = [UIFont boldSystemFontOfSize:23];
        self.navigationItem.titleView = title;

        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 60, 30);
        [backButton setBackgroundImage:[UIImage imageNamed:@"btBack"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *liftButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:liftButton];

        m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768-20-44-49) style:UITableViewStylePlain];
        m_tableView.delegate = self;
        m_tableView.dataSource = self;
        m_tableView.backgroundColor = [UIColor colorWithRed:0.984 green:0.984 blue:0.984 alpha:1];
        [self.view addSubview:m_tableView];
           }
    return self;
}

- (void)paySucceed
{
    arrOrderdetail = nil;
    [payView removeFromSuperview];
    payView = nil;
    [m_tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSString *oid = [[NSUserDefaults standardUserDefaults]objectForKey:@"oid"];
    NSString *str;
    if (oid == nil) {
        str = [NSString stringWithFormat:@"oid="];
    }else{
        str = [NSString stringWithFormat:@"oid=%@",oid];
    }
    m_serviceGetorderdetail = [[serviceGetorderdetail alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
    [m_serviceGetorderdetail sendRequestWithData:str addr:@"getorderdetai?"];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reCompute:(NSString *)num row:(NSUInteger)row
{
    NSDictionary *dic = [arrOrderdetail objectAtIndex:row];
    [dic setValue:num forKey:@"num"];
    [arrOrderdetail replaceObjectAtIndex:row withObject:dic];
    NSUInteger totalNum = 0;
    totalPrice = 0;
    for (NSDictionary *obj in arrOrderdetail) {
        NSUInteger n = [[obj objectForKey:@"num"] integerValue];
        totalNum = totalNum + n;
        totalPrice = totalPrice + [[obj objectForKey:@"price"] floatValue]* n;
    }
    
    labTotalNum.text = [NSString stringWithFormat:@"共有%i项商品  |  合计金额:",totalNum];
    labTotalPrice.text = [NSString stringWithFormat:@"%.2f",totalPrice];

}

- (void)buy
{
    if (arrOrderdetail == nil || [arrOrderdetail count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您的购物车是空的"
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
        [alert show];
    }else{
        
//        if (isOver) {
        orderName = [[NSMutableString alloc]initWithCapacity:0];
        for (NSDictionary *dic in arrOrderdetail) {
            NSUInteger length = [orderName length];
            if (length > 0) {
                [orderName insertString:@"  "atIndex:length];
            }
            NSString *str = [NSString stringWithFormat:@"%@*%@",[dic objectForKey:@"pname"],[dic objectForKey:@"num"]];
            [orderName insertString:str atIndex:length];
        }
        
        NSString *oid = [[NSUserDefaults standardUserDefaults] objectForKey:@"oid"];
        NSString *cost = [NSString stringWithFormat:@"%.2f",totalPrice];
        payView = [[PayView alloc]initWithFrame:CGRectMake(1024/2-470/2, 768/2-610/2-50, 470, 570) oid:oid cost:cost orderName:orderName];
        [self.view addSubview:payView];
            
//        }

        
        
        
           
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        editNum= alertView.tag;
        NSString *oid = [[NSUserDefaults standardUserDefaults] objectForKey:@"oid"];
        NSString *pid = [[arrOrderdetail objectAtIndex:editNum] objectForKey:@"pid"];
        NSString *str = [NSString stringWithFormat:@"oid=%@&pid=%@",oid,pid];
        [m_serviceDelproduct sendRequestWithData:str addr:@"delproduct?"];
       
    }
}

- (void)subtraction:(id)sender
{
    UIButton *bt = sender;
    UITableViewCell *cell = [m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:bt.tag inSection:0]];
    UITextField *textField = (UITextField *)[cell viewWithTag:100+bt.tag];
    NSInteger num = [textField.text integerValue] - 1;
    if (num < 1) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否删除该商品?"
                                                       message:nil
                                                      delegate:self
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"确认",@"取消", nil];
        alert.tag = bt.tag;
        [alert show];
    }else{
        NSString *oid = [[NSUserDefaults standardUserDefaults] objectForKey:@"oid"];

        NSDictionary *dic = [arrOrderdetail objectAtIndex:bt.tag];
        NSString *pid = [dic objectForKey:@"pid"];
        NSString *price = [dic objectForKey:@"price"];
        NSString *str;
        
        
        if (oid == nil) {
            str = [NSString stringWithFormat:@"pid=%@&num=%d￼￼&price=%@",pid,num,price];
        }else{
            str = [NSString stringWithFormat:@"pid=%@&num=%d￼￼&price=%@&oid=%@",pid,num,price,oid];
        }
    
        [m_serviceAddproduct sendRequestWithData:str addr:@"addproduct?"];
    }

//        textField.text = [NSString stringWithFormat:@"%i", num];
//        [self reCompute:textField.text row:bt.tag];
}

- (void)plus:(id)sender
{
    UIButton *bt = sender;
    UITableViewCell *cell = [m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:bt.tag inSection:0]];
    UITextField *textField = (UITextField *)[cell viewWithTag:100+bt.tag];
    NSInteger num = [textField.text integerValue] + 1;
    NSString *oid = [[NSUserDefaults standardUserDefaults] objectForKey:@"oid"];
    
    NSDictionary *dic = [arrOrderdetail objectAtIndex:bt.tag];
    NSString *pid = [dic objectForKey:@"pid"];
    NSString *price = [dic objectForKey:@"price"];
    NSString *str;
    
    
    if (oid == nil) {
        str = [NSString stringWithFormat:@"pid=%@&num=%d￼￼&price=%@",pid,num,price];
    }else{
        str = [NSString stringWithFormat:@"pid=%@&num=%d￼￼&price=%@&oid=%@",pid,num,price,oid];
    }
    
    [m_serviceAddproduct sendRequestWithData:str addr:@"addproduct?"];
//    textField.text = [NSString stringWithFormat:@"%i", num];
//    [[arrOrderdetail objectAtIndex:bt.tag] setObject:textField.text forKey:@"num"];
//    [self reCompute:textField.text row:bt.tag];
}

#pragma mark -
#pragma mark tableview delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 61)];
    headerView.backgroundColor = [UIColor colorWithRed:0.984 green:0.984 blue:0.984 alpha:1];
    //    [headerView setTitle:[NSString stringWithFormat:@"您在%@附近",placemark.name] forState:UIControlStateNormal];
    UIImageView *line1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line.jpg"]];
    line1.frame = CGRectMake(0, 60, 1024, 1);
    [headerView addSubview:line1];
    UIImageView *line2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line.jpg"]];
    line2.frame = CGRectMake(0, 0, 1024, 1);
    [headerView addSubview:line2];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(155, 24, 100, 20)];
    label1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    label1.text = @"物品";
    label1.font = [UIFont systemFontOfSize:18];
    label1.textColor = [UIColor colorWithRed:0.4667 green:0.408 blue:0.349 alpha:1];
    [headerView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(668, 24, 100, 20)];
    label2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    label2.text = @"单价(元)";
    label2.font = [UIFont systemFontOfSize:18];
    label2.textColor = [UIColor colorWithRed:0.4667 green:0.408 blue:0.349 alpha:1];
    [headerView addSubview:label2];

    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(838, 24, 50, 20)];
    label3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    label3.text = @"数量";
    label3.font = [UIFont systemFontOfSize:18];
    label3.textColor = [UIColor colorWithRed:0.4667 green:0.408 blue:0.349 alpha:1];
    [headerView addSubview:label3];
    return headerView;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 100)];
    footerView.backgroundColor = [UIColor colorWithRed:0.984 green:0.984 blue:0.984 alpha:1];
    UIImageView *line1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line.jpg"]];
    line1.frame = CGRectMake(0, 0, 1024, 1);
    [footerView addSubview:line1];
    UIImageView *line2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line.jpg"]];
    line2.frame = CGRectMake(0, 161, 1024, 1);
    [footerView addSubview:line2];

    labTotalNum = [[UILabel alloc]initWithFrame:CGRectMake(589, 20, 232, 33)];
    labTotalNum.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//    totalNum.text = [NSString stringWithFormat:@"共有10项商品  |  合计金额"];
    labTotalNum.font = [UIFont systemFontOfSize:18];
    labTotalNum.textColor = [UIColor colorWithRed:0.4667 green:0.408 blue:0.349 alpha:1];
    [footerView addSubview:labTotalNum];
    
    labTotalPrice = [[UILabel alloc]initWithFrame:CGRectMake(824, 20, 200, 30)];
    labTotalPrice.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//    totalPrice.text = [NSString stringWithFormat:@"300.00"];
    labTotalPrice.font = [UIFont systemFontOfSize:24];
    labTotalPrice.textColor = [UIColor colorWithRed:1 green:0.369 blue:0.369 alpha:1];
    [footerView addSubview:labTotalPrice];

    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(767, 77, 146, 52);
    [bt setImage:[UIImage imageNamed:@"buy"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:bt];
    NSUInteger totalNum = 0;
    totalPrice = 0;
    for (NSDictionary *obj in arrOrderdetail) {
        NSUInteger n = [[obj objectForKey:@"num"] integerValue];
        totalNum = totalNum + n;
        totalPrice = totalPrice + [[obj objectForKey:@"price"] floatValue]* n;
    }
    
    labTotalNum.text = [NSString stringWithFormat:@"共有%i项商品  |  合计金额:",totalNum];
    labTotalPrice.text = [NSString stringWithFormat:@"%.2f",totalPrice];

    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 61;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 162;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath


{
    
    
    editNum = [indexPath row];
    NSString *oid = [[NSUserDefaults standardUserDefaults]objectForKey:@"oid"];
    NSString *pid = [[arrOrderdetail objectAtIndex:editNum] objectForKey:@"pid"];
    if (oid != nil) {
        NSString *str = [NSString stringWithFormat:@"oid=%@&pid=%@",oid,pid];
        [m_serviceDelproduct sendRequestWithData:str addr:@"delproduct?"];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return @"删除";
    
    
}

#pragma mark -
#pragma mark tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor colorWithRed:0.984 green:0.984 blue:0.984 alpha:1];
    
    NSUInteger row = [indexPath row];
    
    EGOImageView *image = [[EGOImageView alloc]initWithFrame:CGRectMake(23, 13, 84, 79)];
    image.imageURL = [NSURL URLWithString:[[arrOrderdetail objectAtIndex:row] objectForKey:@"pic"]];
//    image.backgroundColor = [UIColor blackColor];
    [cell addSubview:image];
    
    UILabel *labName = [[UILabel alloc]initWithFrame:CGRectMake(155, 30, 500, 50)];
    labName.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    labName.text = [[arrOrderdetail objectAtIndex:row] objectForKey:@"pname"];
    labName.font = [UIFont systemFontOfSize:18];
    labName.textColor = [UIColor colorWithRed:0.4667 green:0.408 blue:0.349 alpha:1];
    [cell addSubview:labName];
    
    UILabel *labPrice = [[UILabel alloc]initWithFrame:CGRectMake(668, 30, 68, 50)];
    labPrice.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    labPrice.text = [[arrOrderdetail objectAtIndex:row] objectForKey:@"price"];
    labPrice.textAlignment = NSTextAlignmentCenter;
    labPrice.font = [UIFont systemFontOfSize:18];
    labPrice.textColor = [UIColor colorWithRed:0.4667 green:0.408 blue:0.349 alpha:1];
    labPrice.tag = row+200;
    [cell addSubview:labPrice];
    
    UIButton *btSubtraction = [UIButton buttonWithType:UIButtonTypeCustom];
    [btSubtraction setImage:[UIImage imageNamed:@"subtraction"] forState:UIControlStateNormal];
    [btSubtraction addTarget:self action:@selector(subtraction:) forControlEvents:UIControlEventTouchUpInside];
    btSubtraction.frame = CGRectMake(804, 44, 20, 20);
    btSubtraction.tag = row;
    [cell addSubview:btSubtraction];
    
    UIButton *btPlus = [UIButton buttonWithType:UIButtonTypeCustom];
    [btPlus setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [btPlus addTarget:self action:@selector(plus:) forControlEvents:UIControlEventTouchUpInside];
    btPlus.frame = CGRectMake(891, 44, 20, 20);
    btPlus.tag = row;
    [cell addSubview:btPlus];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(830, 39, 57, 30)];
    textField.tag = row+100;
    textField.text = [[arrOrderdetail objectAtIndex:row] objectForKey:@"num"];
    textField.font = [UIFont systemFontOfSize:24];
    textField.textColor = [UIColor colorWithRed:0.224 green:0.463 blue:1 alpha:1];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.enabled = NO;
    [cell addSubview:textField];


    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrOrderdetail count];
}

#pragma mark -
#pragma mark serviceCallBack
- (void)serviceGetorderdetailCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
{
    
    if (arrCallBack == nil || [arrCallBack count] == 0) {
        NSLog(@"GetOrderdetail nil");
    }else{
        arrOrderdetail = nil;
        arrOrderdetail = [[NSMutableArray alloc]initWithArray:arrCallBack];
        
        [m_tableView reloadData];   
    }
}

- (void)serviceDelproductCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
{
    
    if (arrCallBack == nil) {
        NSLog(@"Delproduct nil");
    }else{
        
        [arrOrderdetail removeObjectAtIndex:editNum];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:editNum inSection:0];
        
//        [m_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationLeft];
        [m_tableView reloadData];
//        arrOrderdetail = nil;
    }
}

- (void)serviceAddproductCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
{
    
    if (arrCallBack == nil || [arrCallBack count] == 0) {
        NSLog(@"Addproduct nil");
    }else{
        arrOrderdetail = [[NSMutableArray alloc]initWithArray:arrCallBack];
        [m_tableView reloadData];
    }
}


@end
