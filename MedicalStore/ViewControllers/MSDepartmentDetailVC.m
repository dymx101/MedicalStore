//
//  MSDepartmentDetailVC.m
//  MedicalStore
//
//  Created by towne on 13-9-8.
//  Copyright (c) 2013年 Dong Yiming. All rights reserved.
//

#import "MSDepartmentDetailVC.h"
#import "MSDepartMent.h"
#import "MSTelBook.h"
#import "GGDataStore.h"
#import "MSFavoritesListVC.h"
#import "GGPhoneMask.h"

@interface MSDepartmentDetailVC ()
{
    UIWebView        *phoneCallWebView;
}
@property (weak, nonatomic) IBOutlet UIScrollView *svContent;
@property (weak, nonatomic) IBOutlet UIImageView  *ivLogo;
@property (weak, nonatomic) IBOutlet UILabel      *lblTitle;

@property (weak, nonatomic) IBOutlet UIButton     *lblTelTitle;
@property (weak, nonatomic) IBOutlet UIButton     *lblOfficeTelTitle;
@property (weak, nonatomic) IBOutlet UIButton     *lblDepartmentTitle;

@property (weak, nonatomic) IBOutlet UIView       *viewBrief;
@property (weak, nonatomic) IBOutlet UIView       *viewHead;
@property (strong,nonatomic) NSMutableArray       *telboolInDeps;

@end

@implementation MSDepartmentDetailVC

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
    // Do any additional setup after loading the view from its nib.
        self.navigationItem.title = @"部门详情";
    self.lblTitle.text = _msDepartment.name;
    NSString *lbltelText = [_msDepartment.phone length] == 0?@"暂无办公电话":_msDepartment.phone;
    NSString *lblOfficeTelText = [_msDepartment.fax length] == 0?@"暂无办公传真":_msDepartment.fax;
    
    [self.lblTelTitle setTitle:lbltelText forState:UIControlStateNormal];

    [self.lblOfficeTelTitle setTitle:lblOfficeTelText forState:UIControlStateNormal];
    
    NSArray        *telbooks = [GGDataStore loadTelbooks];
     _telboolInDeps = [NSMutableArray new];
    for (MSTelBook *telbook in telbooks) {
        if ([telbook.departmentId intValue] == _msDepartment.ID) {
            [_telboolInDeps addObject:telbook];
        }
    }
    
    [self.lblDepartmentTitle setTitle:[NSString stringWithFormat:@"查看部门成员：%d人",[_telboolInDeps count]] forState:UIControlStateNormal];
  
    [_viewHead applyEffectShadowAndBorder];
    [_viewBrief applyEffectShadowAndBorder];
    [_ivLogo applyEffectRoundRectSilverBorder];
}

-(IBAction)call1:(id)sender
{
    NSLog(@"method_1");
    
    NSString *number = _msDepartment.phone;// 此处读入电话号码
    
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
    
    NSString *number = _msDepartment.fax;// 此处读入电话号码
    
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
    MSFavoritesListVC *favoritVc = [[MSFavoritesListVC alloc] initWithSectionIndexes:YES isFavorites:YES isDepartmentSearch:YES];
    favoritVc.title = [NSString stringWithFormat:@"%@部门",_msDepartment.name];
    favoritVc.favoriteArray = [NSMutableArray arrayWithArray:_telboolInDeps];
    UINavigationController *baseNC = [[UINavigationController alloc] initWithRootViewController:favoritVc];
    [[GGPhoneMask sharedInstance] addMaskVC:baseNC animated:YES alpha:1.0];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
