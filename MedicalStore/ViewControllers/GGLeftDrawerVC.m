//
//  GGLeftDrawerVC.m
//  policeOnline
//
//  Created by Dong Yiming on 6/22/13.
//  Copyright (c) 2013 tmd. All rights reserved.
//

#import "GGLeftDrawerVC.h"
#import "MSAppDelegate.h"
#import "GGSettingCenterVC.h"
#import "AKTabBarController.h"

@interface GGLeftDrawerVC ()

@end

@implementation GGLeftDrawerVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - 收藏功能
-(IBAction)reportCLue:(id)sender
{
    [SharedAppDelegate.drawerVC closeDrawerAnimated:YES completion:nil];
    
    UINavigationController *centerVC = (UINavigationController *)[SharedAppDelegate.drawerVC centerViewController];
    
//    GGClueReportVC *vc = [GGClueReportVC new];
//    GGCluesVC *vc = [GGCluesVC new];
//    [centerVC pushViewController:vc animated:YES];
}

#pragma mark - 设置中心
-(IBAction)settingCenter:(id)sender
{
    [SharedAppDelegate.drawerVC closeDrawerAnimated:YES completion:^(BOOL completed){
        
        UINavigationController *centerVC = (UINavigationController *)[SharedAppDelegate.drawerVC centerViewController];
        
        [centerVC.navigationBar setHidden:NO];
        
        GGSettingCenterVC *vc = [GGSettingCenterVC new];

        [centerVC pushViewController:vc animated:YES];
        
    }];
    
}

@end
