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
#import "MSHomeVC.h"
#import "MSFavoritesListVC.h"

#import "MSNewSettingCenterVC.h"

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
    
    [centerVC.navigationBar setHidden:NO];
    
    MSFavoritesListVC *FavoritVc = [[MSFavoritesListVC alloc] initWithSectionIndexes:YES];
 
    FavoritVc.navigationItem.title = @"收藏列表";
    
    [centerVC pushViewController:FavoritVc animated:YES];
}


#pragma mark - 设置中心
-(IBAction)settingCenter:(id)sender
{
    [SharedAppDelegate.drawerVC closeDrawerAnimated:YES completion:^(BOOL completed){
        
        UINavigationController *centerVC = (UINavigationController *)[SharedAppDelegate.drawerVC centerViewController];
        
        
        
        MSNewSettingCenterVC *vc = [MSNewSettingCenterVC new];
        //UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
        [centerVC pushViewController:vc animated:NO];
        [centerVC.view.layer addAnimation:[GGAnimation animationFade] forKey:nil];
        
    }];
    
}

@end
