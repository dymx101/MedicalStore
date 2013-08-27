//
//  MSProductDetailVC.m
//  MedicalStore
//
//  Created by Dong Yiming on 7/14/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "MSProductDetailVC.h"
#import "GGDbManager.h"

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
@property (weak, nonatomic) IBOutlet UIView *viewBrief;
@property (weak, nonatomic) IBOutlet UILabel *lblBrief;
@property (weak, nonatomic) IBOutlet UIView *viewHead;
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
    
    self.lblTitle.text = _msTelbook.name;
    self.lblSubTitle.text = _msTelbook.post;
    self.lblTelTitle.text = _msTelbook.mobilePhone;
    
    [_viewHead applyEffectShadowAndBorder];
    [_viewBrief applyEffectShadowAndBorder];
    [_ivLogo applyEffectRoundRectSilverBorder];
}

-(IBAction)call:(id)sender
{
    NSLog(@"method_1");
    
    NSString *number = _msTelbook.mobilePhone;// 此处读入电话号码
    
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
            [self showError:@"收藏成功"];
            dispatch_async(dispatch_get_main_queue(), ^{
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
            [self showError:@"取消成功"];
            dispatch_async(dispatch_get_main_queue(), ^{
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
