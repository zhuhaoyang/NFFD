//
//  PayView.h
//  NFFD
//
//  Created by Myth on 13-9-6.
//  Copyright (c) 2013年 Myth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MCSegmentedControl.h"
#import "AlixPayOrder.h"
#import "AlixPayResult.h"
#import "AlixPay.h"
#import "DataSigner.h"
#import "servicePayfor.h"

@interface PayView : UIView<UITextViewDelegate,UITextFieldDelegate>{
    BOOL isKeyboardWillShow;
    servicePayfor *m_servicePayfor;
}

@property (nonatomic,retain) UIView *view;

@property (nonatomic,retain) NSString *oid;
@property (nonatomic,retain) NSString *addr;
@property (nonatomic,retain) NSString *tel;
@property (nonatomic,retain) NSString *cost;
@property (nonatomic,retain) NSString *man;
@property (nonatomic,retain) NSString*mobile;
@property (nonatomic,retain) NSString *remark;
@property (nonatomic,assign) NSUInteger type;
@property (nonatomic,retain) NSString *orderName;

@property (nonatomic,retain) UILabel *labOid;
@property (nonatomic,retain) UILabel *labCost;
@property (nonatomic,retain) UITextField *textAddr;
@property (nonatomic,retain) UITextField *textTel;
@property (nonatomic,retain) UITextField *textMan;
@property (nonatomic,retain) UITextField *textMobile;
@property (nonatomic,retain) UISegmentedControl *segType;
@property (nonatomic,retain) UITextView *textRemark;
//@property (nonatomic,retain) UIButton *btSubmit;


- (id)initWithFrame:(CGRect)frame oid:(NSString *)m_oid cost:(NSString *)m_cost orderName:(NSString *)m_orderName;
@end
