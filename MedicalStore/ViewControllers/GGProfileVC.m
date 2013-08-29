//
//  GGProfileVC.m
//  policeOnline
//
//  Created by Dong Yiming on 6/23/13.
//  Copyright (c) 2013 tmd. All rights reserved.
//

#import "GGProfileVC.h"
#import "GGArchive.h"
#import "GGUserDefault.h"
#import "GGImagePool.h"
#import "MSAppDelegate.h"
#import "GGPhoneMask.h"


@interface GGProfileVC ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfValidate;

@property (weak, nonatomic) IBOutlet UIButton *btnGetValidCode;
@property (weak, nonatomic) IBOutlet UIButton *btnValiate;

@property (weak, nonatomic) IBOutlet UIView *viewTip;

@end

@implementation GGProfileVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"身份验证"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _tfName.text = [GGUserDefault myName];
    _tfPhone.text = [GGUserDefault myPhone];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStyleBordered target:self action:@selector(save:)];
    self.navigationItem.leftBarButtonItem = barBtn;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)]];
    
    [_btnValiate setBackgroundImage:GGSharedImagePool.bgBtnOrange forState:UIControlStateNormal];
    [self.btnGetValidCode addTarget:self action:@selector(getValidateCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnValiate addTarget:self action:@selector(validateAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidUnload {
    [self setTfName:nil];
    [self setTfPhone:nil];
    [self setViewTip:nil];
    [self setTfValidate:nil];
    [self setBtnGetValidCode:nil];
    [self setBtnValiate:nil];
    [super viewDidUnload];
}

-(void)endEditing
{
    [self.view endEditing:YES];
}

-(IBAction)save:(id)sender
{
    exit(0);
}

-(IBAction)getValidateCodeAction:(id)sender
{
    DLog(@"getValidateCodeAction");
    int tfnlength = [_tfName.text length];
    int tfplength = [_tfPhone.text length];
    
    if (tfnlength == 0 || tfplength == 0) {
        [GGAlert alertWithApiMessage:@"姓名和电话不能为空！"];
    }
    else
    {
        [GGSharedAPI askChecking:_tfName.text Phone:[_tfPhone.text longLongValue] callback:^(id operation, id aResultObject, NSError *anError) {
            GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
            long flag = [[[parser apiData] objectForKey:@"flag"] longValue];
            DLog(@">>>> %ld",flag);
            if (flag == 1) {
                [GGAlert alertWithApiMessage:@"申请验证码失败"];
            }
            else
            {
                [GGAlert alertWithMessage:[NSString stringWithFormat:@" 姓名:%@ 手机号:%@",_tfName,_tfPhone] title:@"请从手机上获取验证码"];
            }
            
        }];
    }
}

-(IBAction)validateAction:(id)sender
{
    DLog(@"validateAction");
    NSString *validatestring = _tfValidate.text;
    int tfvalidlength = [_tfValidate.text length];
    if (tfvalidlength == 0 ) {
        [GGAlert alertWithApiMessage:@"验证码不能为空！"];
    }
    else
    {
//        validatestring = @"aaabbb";
        [GGSharedAPI checkCode:validatestring callback:^(id operation, id aResultObject, NSError *anError) {
            GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
            long flag = [[[parser apiData] objectForKey:@"flag"] longValue];
            DLog(@">>>> %ld",flag);
            if (flag == 0) {
                [SharedAppDelegate refreshData];
                [GGAlert alert:@"用户验证通过,即将进入应用,请稍后！" tag:101 delegate:self];
            }
            else
            {
                [GGAlert alertWithMessage:@"验证失败!"];
            }
        }];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101) {
        [[GGPhoneMask sharedInstance] dismissMaskVCAnimated:YES];
    }
}


@end
