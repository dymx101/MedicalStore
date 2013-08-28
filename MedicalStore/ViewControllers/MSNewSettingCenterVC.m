//
//  MSNewSettingCenterVC.m
//  MedicalStore
//
//  Created by Dong Yiming on 8/24/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "MSNewSettingCenterVC.h"
#import "MSAppDelegate.h"
#import "GGProfileVC.h"
#import "MSUserInfo.h"
@interface MSNewSettingCenterVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MSNewSettingCenterVC
{
    NSArray         *_dataSource;
    UITableView     *_tv;
    MSUserInfo      *_user;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _dataSource = @[
                        @[@"查看绑定", @"号码变更", @"数据更新"]
                        , @[@"版本更新", @"新手引导", @"关于"]
                        ];
        _user = [MSUserInfo new];
        self.navigationItem.title = @"设置中心";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMenuButton];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonSystemItemCancel target:self action:@selector(naviBackAction)];
	
    _tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tv.dataSource = self;
    _tv.delegate = self;
    _tv.backgroundColor = GGSharedColor.silver;
    UIView *bgView = [[UIView alloc] initWithFrame:_tv.bounds];
    bgView.backgroundColor = GGSharedColor.silver;
    _tv.backgroundView = bgView;
    [self.view addSubview:_tv];
    
    [GGSharedAPI getUserInfo:^(id operation, id aResultObject, NSError *anError) {
        GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
        _user = [parser parseMSUserInfo];
        [_tv reloadData];
    }];
}

/**
 * 功能:左键设菜单
 */
-(void)setMenuButton
{
    UIBarButtonItem *leftDrawerButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)leftDrawerButtonPress:(id)sender{
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)naviBackAction
{
    [self.navigationController popViewControllerAnimated:NO];
    //[self.navigationController.view.layer addAnimation:[GGAnimation animationFlipFromTop] forKey:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [SharedAppDelegate.drawerVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    //[_drawerVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark -
-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSArray *)dataSourceWithSection:(int)aSection
{
    return (NSArray *)(_dataSource[aSection]);
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self dataSourceWithSection:section].count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"账号";
    }
    
    return @"常规";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    int section = indexPath.section;
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    UIFont  *font = [UIFont fontWithName:@"Futura-Medium" size:15.0f];
    NSArray *dataSource = [self dataSourceWithSection:section];
    cell.textLabel.text = dataSource[row];
    cell.textLabel.font = font;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int row = indexPath.row;
    int section = indexPath.section;
    
    if (section == 0)
    {
        if (row == 0)
        {
            if (nil != _user.name && nil != _user.phone) {
                [GGAlert alertWithMessage:[NSString stringWithFormat:@"姓名:%@\n手机号:%@",_user.name,_user.phone] title:@"查看"];
            }
            else
            {
                GGProfileVC *vc = [[GGProfileVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
 
        }
        else if (row == 1)
        {
            [self showAlertWithTextField];
        }
        else if (row == 2)
        {
            [GGAlert alertWithMessage:@"通讯录数据暂无更新!"];
        }
    }
    else if (section == 1)
    {
        if (row == 0) {
            [self checkVersionUpdate:@"1"];
        }
        
    }
}

-(void)checkVersionUpdate:(NSString *) currentVersion
{
    [GGSharedAPI checkUpdate:^(id operation, id aResultObject, NSError *anError) {
        GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
        long state = [[[parser apiData] objectForKey:@"state"] longValue];
        DLog(@">>>> %ld",state);
        if (state > [currentVersion intValue]) {
            NSMutableString * updateString = [[NSMutableString alloc]initWithString:@"版本更新版本更新版本更新版本更新版本更新版本更新版本更新版本更新版本"] ;
            NSRange range = NSMakeRange(0, [updateString length]);
            [updateString replaceOccurrencesOfString:@"#" withString:@"\r" options:NSCaseInsensitiveSearch range:range];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新提示" message:updateString delegate:self cancelButtonTitle:@"稍后" otherButtonTitles:@"更新", nil];
            [alert show];
            alert.tag = 7789;
        }
        else
        {
            [self alertNetError];
        }
    }];
}

- (void)alertNetError{
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:@"网络繁忙，请稍后重试..." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView setTag:110];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 7788 && buttonIndex == 0)
    {
        [self enterITunesToUpdate];
    }
    else if (alertView.tag == 7789 && buttonIndex == 1)
    {
        [self enterITunesToUpdate];
    }
    else if (alertView.tag == 1101)
    {
        if (buttonIndex == 1)
        {
            NSString *fstPhoneNum = [[alertView textFieldAtIndex:0]text];
            NSString *secPhoneNum = [[alertView textFieldAtIndex:1]text];
            if ([fstPhoneNum longLongValue] == [secPhoneNum longLongValue]) {
                [GGSharedAPI changePhone:[fstPhoneNum longLongValue] callback:^(id operation, id aResultObject, NSError *anError) {
                    GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
                    long flag = [[[parser apiData] objectForKey:@"flag"] longValue];
                    if (flag == 0) {
                        [GGAlert alertWithMessage:@"变更成功"];
                    }
                    else
                    {
                        [GGAlert alertWithMessage:@"变更失败"];
                    }
                }];
            }
            
        }
    }
}


-(void)enterITunesToUpdate
{
    NSURL * iTunesUrl = [NSURL URLWithString:@"http://itunes.apple.com/cn/app/id427457043?mt=8&ls=1"];
    [[UIApplication	sharedApplication] openURL:iTunesUrl];
}


-(void)showAlertWithTextField{
    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@"变更" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"提交", nil];
    [dialog setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    
    // Change keyboard type
    [[dialog textFieldAtIndex:0] setPlaceholder:@"请输入您的手机号码！"];
    [[dialog textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [[dialog textFieldAtIndex:1] setPlaceholder:@"请再次输入您的手机号码！"];
    [[dialog textFieldAtIndex:1] setKeyboardType:UIKeyboardTypeNumberPad];
    
     dialog.tag = 1101;
    [dialog show];
}

// Change keyboard type


@end
