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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonSystemItemCancel target:self action:@selector(naviBackAction)];
	
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

            [GGAlert alertWithMessage:[NSString stringWithFormat:@"姓名:%@\n手机号:%@",_user.name,_user.phone] title:@"查看"];
        }
        else if (row == 1)
        {
            GGProfileVC *vc = [[GGProfileVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (section == 1)
    {
        
    }
}


@end
