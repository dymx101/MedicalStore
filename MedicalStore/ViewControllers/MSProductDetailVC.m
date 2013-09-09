//
//  MSProductDetailVC.m
//  MedicalStore
//
//  Created by Dong Yiming on 7/14/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "MSProductDetailVC.h"
#import "GGDbManager.h"
#import "MSDepartMent.h"
#import "MSTelBook.h"
#import "GGDataStore.h"

#define ReloadTelBookList  @"ReloadTelBookList"


@interface MSProductDetailVC ()
{
    UIWebView * phoneCallWebView;
}
@property (weak, nonatomic) IBOutlet UIScrollView *svContent;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTelTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblOfficeTelTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblHomeTelTitle;
@property (weak, nonatomic) IBOutlet UIView *viewBrief;
@property (weak, nonatomic) IBOutlet UILabel *lblBrief;
@property (weak, nonatomic) IBOutlet UIView *viewHead;
@property (weak, nonatomic) IBOutlet UIButton *addfavorite;

@property (nonatomic, strong) NSString *departname;

@end

@implementation MSProductDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"联系人";
    
    for (MSDepartMent *department in [GGDataStore loadDepartments]) {
        if (department.ID == [_msTelbook.departmentId longLongValue]) {
            _departname = department.name;
            break;
        }
    }
    
    self.lblTitle.text = _msTelbook.name;
    self.lblSubTitle.text = [NSString stringWithFormat:@"%@ | %@",_departname,_msTelbook.post];
    self.lblTelTitle.text = _msTelbook.mobilePhone;
    

    
    self.lblOfficeTelTitle.text = _msTelbook.officePhone;
    self.lblHomeTelTitle.text = _msTelbook.homePhone;
    
    [_viewHead applyEffectShadowAndBorder];
    [_viewBrief applyEffectShadowAndBorder];
    [_ivLogo applyEffectRoundRectSilverBorder];
    if (_keep)
        [self.addfavorite setTitle:@"收藏" forState:UIControlStateNormal];
    else
        [self.addfavorite setTitle:@"取消收藏" forState:UIControlStateNormal];
}

-(IBAction)call1:(id)sender
{
    NSLog(@"method_1");
    
    NSString *number = _msTelbook.mobilePhone;// 此处读入电话号码
    
    if ([number isEqualToString:@""]) {
        [GGAlert alertWithMessage:@"暂无电话！"];
        return;
    }
    
    NSString *cleanedString = [[number componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", cleanedString]];
    
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

-(IBAction)call2:(id)sender
{
    NSLog(@"method_1");
    
    NSString *number = _msTelbook.officePhone;// 此处读入电话号码
    
    if ([number isEqualToString:@""]) {
        [GGAlert alertWithMessage:@"暂无电话！"];
        return;
    }
    
    NSString *cleanedString = [[number componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", cleanedString]];
    
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

-(IBAction)call3:(id)sender
{
    NSLog(@"method_1");
    
    NSString *number = _msTelbook.homePhone;// 此处读入电话号码
    
    if ([number isEqualToString:@""]) {
        [GGAlert alertWithMessage:@"暂无电话！"];
        return;
    }
    
    NSString *cleanedString = [[number componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", cleanedString]];
    
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}


-(IBAction)sendmessage:(id)sender
{
    NSLog(@"method_2");
    
    NSString *number = _msTelbook.mobilePhone;// 此处读入电话号码
    
    NSString *cleanedString = [[number componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", cleanedString]];
    
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

-(IBAction)addfavorite:(id)sender
{
    NSLog(@"method_3");
    
    if (_keep) {
        BOOL success = [[GGDbManager sharedInstance] insertTelbook:_msTelbook];
        if (success == YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showError:@"收藏成功"];
                [self.addfavorite setTitle:@"取消收藏" forState:UIControlStateNormal];
                self.keep = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:ReloadTelBookList object:nil];
            });
        }
        else
        {
            [self showError:@"您已经收藏，无需重复收藏"];
        }
    }
    else
    {
        BOOL success = [[GGDbManager sharedInstance] deleteTelbookByID:_msTelbook.ID];
        if (success == YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showError:@"取消成功"];
                [self.addfavorite setTitle:@"收藏" forState:UIControlStateNormal];
                self.keep = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:ReloadTelBookList object:nil];
            });
        }        
    }
}

-(void)showError:(NSString *)error
{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:error delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView setTag:110];
    [alertView show];
}


@end
