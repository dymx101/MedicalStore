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

@interface GGProfileVC ()
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
//        self.title = @"个人资料";
        [self setTitle:@"身份验证"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tfName.text = [GGUserDefault myName];
    _tfPhone.text = [GGUserDefault myPhone];
    
    //UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(save:)];
    //self.navigationItem.rightBarButtonItem = barBtn;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)]];
    
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
    DLog(@"save profile");
    [GGUserDefault saveMyName:self.tfName.text];
    [GGUserDefault saveMyPhone:self.tfPhone.text];
    NSArray * profile = [NSArray arrayWithObjects:self.tfName.text,self.tfPhone.text,nil];
    [GGArchive archiveData:profile withFileName:@"profile.plist"];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)getValidateCodeAction:(id)sender
{
    DLog(@"getValidateCodeAction");
}

-(IBAction)validateAction:(id)sender
{
    DLog(@"validateAction");
}

@end
