//
//  PayView.m
//  NFFD
//
//  Created by Myth on 13-9-6.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import "PayView.h"

@implementation PayView
@synthesize oid = _oid;
@synthesize cost = _cost;

- (id)initWithFrame:(CGRect)frame oid:(NSString *)m_oid cost:(NSString *)m_cost orderName:(NSString *)m_orderName
{
    self = [super initWithFrame:CGRectMake(0, 0, 1024, 768)];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        
        self.view = [[UIView alloc]initWithFrame:frame];
        self.view.backgroundColor = [UIColor colorWithRed:0.471 green:0.408 blue:0.349 alpha:1];
        self.view.layer.cornerRadius = 12;
        self.view.layer.masksToBounds = YES;
        [self addSubview:self.view];
//        UINavigationItem *bar = [[UINavigationItem alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 75)];
        UINavigationBar *bar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        bar.tintColor = [UIColor colorWithRed:0.573 green:0.498 blue:0.431 alpha:1];
        UINavigationItem *titleItem = [[UINavigationItem alloc]init];
//        UINavigationItem *bar = [UINavigationItem alloc];
        UIButton *btClose = [UIButton buttonWithType:UIButtonTypeCustom];
        btClose.frame = CGRectMake(0, 0, 60, 30);
        [btClose setTitle:@"关闭" forState:UIControlStateNormal];
        btClose.titleLabel.font = [UIFont systemFontOfSize:15];
        [btClose addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:btClose];
        [titleItem setRightBarButtonItem:rightButton];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        title.text = @"订单详情";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor colorWithRed:0.352 green:0.314 blue:0.267 alpha:1];
        title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        title.font = [UIFont boldSystemFontOfSize:25];
        titleItem.titleView = title;
        [bar setItems:[[NSArray alloc]initWithObjects:titleItem, nil]];

        


        
        [self.view addSubview:bar];
        self.orderName = m_orderName;
        self.oid = m_oid;
//        self.addr = @"太平门直街260号三新银座18楼城报传媒";
//        self.tel = @"057188888888";
        self.cost = m_cost;
//        self.man = @"朱浩洋";
//        self.mobile = @"18657103787";
//        self.remark = @"请送货之前电话确认";
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(9, 44+50, frame.size.width-18, 1)];
        line1.backgroundColor = [UIColor colorWithRed:0.541 green:0.494 blue:0.447 alpha:1];
        [self.view addSubview:line1];
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(9, 44+100, frame.size.width-18, 1)];
        line2.backgroundColor = [UIColor colorWithRed:0.541 green:0.494 blue:0.447 alpha:1];
        [self.view addSubview:line2];
        UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(9, 44+150, frame.size.width-18, 1)];
        line3.backgroundColor = [UIColor colorWithRed:0.541 green:0.494 blue:0.447 alpha:1];
        [self.view addSubview:line3];
        UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(9, 44+200, frame.size.width-18, 1)];
        line4.backgroundColor = [UIColor colorWithRed:0.541 green:0.494 blue:0.447 alpha:1];
        [self.view addSubview:line4];
        UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(9, 44+250, frame.size.width-18, 1)];
        line5.backgroundColor = [UIColor colorWithRed:0.541 green:0.494 blue:0.447 alpha:1];
        [self.view addSubview:line5];
        UIView *line6 = [[UIView alloc]initWithFrame:CGRectMake(9, 44+300, frame.size.width-18, 1)];
        line6.backgroundColor = [UIColor colorWithRed:0.541 green:0.494 blue:0.447 alpha:1];
        [self.view addSubview:line6];

        
        self.labOid = [[UILabel alloc]initWithFrame:CGRectMake(30, 44+15, frame.size.width-60, 20)];
        self.labOid.font = [UIFont systemFontOfSize:17];
        self.labOid.textAlignment = UITextAlignmentLeft;
        self.labOid.textColor = [UIColor colorWithRed:0.812 green:0.757 blue:0.651 alpha:1];
        self.labOid.text = [NSString stringWithFormat:@"订单号:%@",self.oid];
        self.labOid.backgroundColor = [UIColor clearColor];
//        self.labOid.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.view addSubview:self.labOid];
        
        self.labCost = [[UILabel alloc]initWithFrame:CGRectMake(30, 44+50+15, frame.size.width-60, 20)];
        self.labCost.font = [UIFont systemFontOfSize:17];
        self.labCost.textAlignment = UITextAlignmentLeft;
        self.labCost.textColor = [UIColor colorWithRed:0.812 green:0.757 blue:0.615 alpha:1];
        self.labCost.text = [NSString stringWithFormat:@"需支付:%@元",self.cost];
        self.labCost.backgroundColor = [UIColor clearColor];
//        self.labCost.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.view addSubview:self.labCost];
        
        self.textAddr = [[UITextField alloc]initWithFrame:CGRectMake(30, 44+100+10, frame.size.width-60, 30)];
        self.textAddr.delegate = self;
        self.textAddr.borderStyle = UITextBorderStyleRoundedRect;
        self.textAddr.font = [UIFont systemFontOfSize:17];
        self.textAddr.textAlignment = UITextAlignmentLeft;
        self.textAddr.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.textAddr.placeholder = @"收货地址";
        self.textAddr.autocapitalizationType = NO;
        self.textAddr.autocorrectionType = NO;
        self.textAddr.backgroundColor = [UIColor colorWithRed:0.843 green:0.831 blue:0.812 alpha:1];
        [self.view addSubview:self.textAddr];

        self.textTel = [[UITextField alloc]initWithFrame:CGRectMake(30, 44+150+10, frame.size.width-60, 30)];
        self.textTel.delegate = self;
        self.textTel.borderStyle = UITextBorderStyleRoundedRect;
        self.textTel.font = [UIFont systemFontOfSize:17];
        self.textTel.textAlignment = UITextAlignmentLeft;
        self.textTel.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.textTel.placeholder = @"收货电话";
        self.textTel.autocapitalizationType = NO;
        self.textTel.autocorrectionType = NO;
        self.textTel.backgroundColor = [UIColor colorWithRed:0.843 green:0.831 blue:0.812 alpha:1];
        [self.view addSubview:self.textTel];

        self.textMan = [[UITextField alloc]initWithFrame:CGRectMake(30, 44+200+10, frame.size.width-60, 30)];
        self.textMan.delegate = self;
        self.textMan.borderStyle = UITextBorderStyleRoundedRect;
        self.textMan.font = [UIFont systemFontOfSize:17];
        self.textMan.textAlignment = UITextAlignmentLeft;
        self.textMan.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.textMan.placeholder = @"收货人姓名";
        self.textMan.autocapitalizationType = NO;
        self.textMan.autocorrectionType = NO;
        self.textMan.backgroundColor = [UIColor colorWithRed:0.843 green:0.831 blue:0.812 alpha:1];
        [self.view addSubview:self.textMan];

        self.textMobile = [[UITextField alloc]initWithFrame:CGRectMake(30, 44+250+10, frame.size.width-60, 30)];
        self.textMobile.delegate = self;
        self.textMobile.borderStyle = UITextBorderStyleRoundedRect;
        self.textMobile.font = [UIFont systemFontOfSize:17];
        self.textMobile.textAlignment = UITextAlignmentLeft;
        self.textMobile.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.textMobile.placeholder = @"收货人手机";
        self.textMobile.autocapitalizationType = NO;
        self.textMobile.autocorrectionType = NO;
        self.textMobile.backgroundColor = [UIColor colorWithRed:0.843 green:0.831 blue:0.812 alpha:1];
        [self.view addSubview:self.textMobile];
        
        self.segType = [[UISegmentedControl alloc]initWithItems:[[NSArray alloc]initWithObjects:@"无需求",@"仅工作日",@"仅节假日", nil]];
        self.segType.segmentedControlStyle = UISegmentedControlStyleBar;
        [self.segType setFrame:CGRectMake(30, 44+300+10, frame.size.width-60, 39)];
        self.segType.selectedSegmentIndex = 0;
        [self.segType addTarget:self action:@selector(segmentedControlDidChange:) forControlEvents:UIControlEventValueChanged];
        self.segType.tintColor = [UIColor colorWithRed:0.572 green:0.498 blue:0.431 alpha:1];
        [self.view addSubview:self.segType];
        
        self.textRemark = [[UITextView alloc]initWithFrame:CGRectMake(30, 44+300+49+15, frame.size.width-60, 75)];
        self.textRemark.backgroundColor = [UIColor colorWithRed:0.843 green:0.831 blue:0.812 alpha:1];
        self.textRemark.textAlignment = UITextAlignmentLeft;
        self.textRemark.text = @"备注:";
        self.textRemark.delegate = self;
        self.textRemark.font = [UIFont systemFontOfSize:15];
        self.textRemark.textColor = [UIColor lightGrayColor];
        self.textRemark.autocapitalizationType = NO;
        self.textRemark.autocorrectionType = NO;
        self.textRemark.spellCheckingType = UITextSpellCheckingTypeNo;
        [self.view addSubview:self.textRemark];
        
        UIButton *btPay = [UIButton buttonWithType:UIButtonTypeCustom];
        btPay.frame = CGRectMake(30, 44+300+155, frame.size.width-60, 50);
        [btPay setBackgroundImage:[UIImage imageNamed:@"btPay"] forState:UIControlStateNormal];
        [btPay setTitle:@"提交付款" forState:UIControlStateNormal];
        [btPay setTitleColor:[UIColor colorWithRed:0.988 green:0.925 blue:0.863 alpha:1] forState:UIControlStateNormal];
        [btPay addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btPay];

        
    }
    return self;
}

- (void)close:(id)sender
{
    [self removeFromSuperview];
}

- (void)pay:(id)sender
{
    if (self.textAddr.text == nil || [self.textAddr.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"收货地址不能为空!"
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (self.textMan.text == nil || [self.textMan.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"收货人姓名不能为空!"
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
        [alert show];
        return;
    }
    if ((self.textTel.text == nil || [self.textTel.text isEqualToString:@""]) && (self.textMobile.text == nil || [self.textMobile.text isEqualToString:@""])) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"收货电话和收货人手机二者必须填写一项!"
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    [dic setValue:self.oid forKey:@"oid"];
    [dic setValue:self.cost forKey:@"cost"];
    [dic setValue:self.textAddr.text forKey:@"addr"];
    [dic setValue:self.textMan.text forKey:@"man"];
    [dic setValue:[NSString stringWithFormat:@"%d",self.segType.selectedSegmentIndex] forKey:@"type"];
    
    m_servicePayfor = [[servicePayfor alloc]initWithDelegate:self requestMode:TRequestMode_Synchronous];
//    NSMutableString *str = [NSMutableString stringWithFormat:@"oid=%@&cost=%@&addr=%@&man=%@&type=%d",self.oid,self.cost,self.textAddr.text,self.textMan.text,self.segType.selectedSegmentIndex];
    
    if ([self.textMobile.text length] > 0) {
        [dic setValue:self.textMobile.text forKey:@"mobile"];

    }
    if ([self.textTel.text length] > 0) {
        [dic setValue:self.textTel.text forKey:@"tel"];

    }
    if (![self.textRemark.text isEqualToString:@"备注:"]) {
        [dic setValue:self.textRemark.text forKey:@"remark"];

    }
    [m_servicePayfor sendRequestForPOSTWithData:dic addr:@"payfor"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.textAddr resignFirstResponder];
//    [self.textTel resignFirstResponder];
//    [self.textMan resignFirstResponder];
//    [self.textRemark resignFirstResponder];
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(1024/2-470/2, 768/2-610/2 -39 -15 -74-150, 470, 570);
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    isKeyboardWillShow = NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (!isKeyboardWillShow) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        self.view.frame = CGRectMake(1024/2-470/2, 768/2-610/2-50, 470, 570);
        [UIView setAnimationDelegate:self];
        [UIView commitAnimations];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    isKeyboardWillShow = YES;
    return YES;
}



-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"备注:"]) {
        textView.text = nil;
        textView.textColor = [UIColor blackColor];
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(1024/2-470/2, 768/2-610/2 -39 -15 -74-150, 470, 570);
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    isKeyboardWillShow = NO;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (!isKeyboardWillShow) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        self.view.frame = CGRectMake(1024/2-470/2, 768/2-610/2-50, 470, 570);
        [self.textRemark setContentOffset:CGPointMake(0, 0)];
        [UIView setAnimationDelegate:self];
        [UIView commitAnimations];
    }
    self.remark = textView.text;
    if (self.remark == nil || [self.remark isEqualToString:@""]) {
        textView.text = @"备注:";
        textView.textColor = [UIColor lightGrayColor];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    isKeyboardWillShow = YES;
    return YES;
}



- (void)segmentedControlDidChange:(id)sender
{

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


#pragma mark -
#pragma mark serviceCallBack
- (void)servicePayforCallBack:(NSArray *)arrCallBack withErrorMessage:(Error *)error;
{
    
    if (arrCallBack == nil || [arrCallBack count] == 0) {
        NSLog(@"Payfor nil");
    }else{
        NSInteger n = [[arrCallBack objectAtIndex:0] integerValue];
        
       if(n == 1){
            NSString *partner = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Partner"];
            NSString *seller = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Seller"];
            
            //partner和seller获取失败,提示
            if ([partner length] == 0 || [seller length] == 0)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"缺少partner或者seller。"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
                return;
            }
            
            //将商品信息赋予AlixPayOrder的成员变量
            AlixPayOrder *order = [[AlixPayOrder alloc] init];
            order.partner = partner;
            order.seller = seller;
            order.tradeNO = self.oid; //订单ID（由商家自行制定）
            order.productName = self.orderName; //商品标题
            order.productDescription = self.orderName; //商品描述
            order.amount = self.cost; //商品价格
            order.notifyURL =  @"http://www.xxx.com"; //回调URL
            
            //应用注册scheme,在AlixPayDemo-Info.plist定义URL types,用于快捷支付成功后重新唤起商户应用
            NSString *appScheme = @"NFFD";
            
            //将商品信息拼接成字符串
            NSString *orderSpec = [order description];
            NSLog(@"orderSpec = %@",orderSpec);
            
            //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
            id<DataSigner> signer = CreateRSADataSigner([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"]);
            NSString *signedString = [signer signString:orderSpec];
            
            //将签名成功字符串格式化为订单字符串,请严格按照该格式
            NSString *orderString = nil;
            if (signedString != nil) {
                orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                               orderSpec, signedString, @"RSA"];
                
                //获取快捷支付单例并调用快捷支付接口
                AlixPay * alixpay = [AlixPay shared];
                int ret = [alixpay pay:orderString applicationScheme:appScheme];
                
                if (ret == kSPErrorAlipayClientNotInstalled) {
                    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                         message:@"您还没有安装支付宝快捷支付，请先安装。"
                                                                        delegate:self
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                    [alertView setTag:123];
                    [alertView show];
                }
                else if (ret == kSPErrorSignError) {
                    NSLog(@"签名错误！");
                }
                
            }

        }else if(n == 2){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"库存不足!"
                                                           message:nil
                                                          delegate:nil
                                                 cancelButtonTitle:@"确认"
                                                 otherButtonTitles:nil];
            [alert show];
        }else if (n == 3){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"该订单已支付!"
                                                           message:nil
                                                          delegate:nil
                                                 cancelButtonTitle:@"确认"
                                                 otherButtonTitles:nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提交订单失败!"
                                                           message:nil
                                                          delegate:nil
                                                 cancelButtonTitle:@"确认"
                                                 otherButtonTitles:nil];
            [alert show];
        }
    }
}

@end
