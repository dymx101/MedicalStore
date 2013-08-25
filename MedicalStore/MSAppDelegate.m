//
//  MSAppDelegate.m
//  MedicalStore
//
//  Created by Dong Yiming on 7/13/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "MSAppDelegate.h"

#import "AKTabBarController.h"
#import "MSHomeVC.h"
#import "MSNavigationController.h"
#import "GGLeftDrawerVC.h"
#import "MSTestVC.h"

@implementation MSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // If the device is an iPad, we make it taller.
    _tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 70 : 50];
    [_tabBarController setMinimumHeightToDisplayTitle:40.0];

    NSMutableArray *vcs = [NSMutableArray array];

    MSHomeVC * homeVc1 = [[MSHomeVC alloc] initWithSectionIndexes:YES TypeId:1];
    homeVc1.navigationItem.title = @"区'四大家'领导";
    homeVc1.MSTabImageName = @"tab_account";
    UINavigationController * nc1  = [[UINavigationController alloc] initWithRootViewController:homeVc1];
    
    MSHomeVC * homeVc2 = [[MSHomeVC alloc] initWithSectionIndexes:YES TypeId:2];
    homeVc2.navigationItem.title = @"区直部门";
    homeVc2.MSTabImageName = @"tab_cart";
    UINavigationController * nc2  = [[UINavigationController alloc] initWithRootViewController:homeVc2];
    
    MSHomeVC * homeVc3 = [[MSHomeVC alloc] initWithSectionIndexes:YES TypeId:3];
    homeVc3.navigationItem.title = @"乡镇开发区";
    homeVc3.MSTabImageName = @"tab_home";
    UINavigationController * nc3  = [[UINavigationController alloc] initWithRootViewController:homeVc3];
    
    MSHomeVC * homeVc4 = [[MSHomeVC alloc] initWithSectionIndexes:YES TypeId:4];
    homeVc4.navigationItem.title = @"学校医院";
    homeVc4.MSTabImageName = @"tab_home";
    UINavigationController * nc4  = [[UINavigationController alloc] initWithRootViewController:homeVc4];
    
    [vcs addObjectsFromArray:@[nc1,nc2,nc3,nc4]];
    
    _tabBarController.viewControllers = vcs;
    
    //71,142,200
    UIColor *tintColor = [UIColor colorWithRed:71.f / 255 green:142.f / 255 blue:200.f / 255 alpha:1];
    [[UINavigationBar appearance] setTintColor:tintColor];
    
    UINavigationController * root = [[UINavigationController alloc] initWithRootViewController:_tabBarController
                                     ];
    //[root.navigationBar setHidden:YES];
    
    UIViewController *leftDrawerVC = [[GGLeftDrawerVC alloc] init];
    
    _drawerVC = [[MMDrawerController alloc] initWithCenterViewController:root rightDrawerViewController:leftDrawerVC];
    
    [_drawerVC setMaximumLeftDrawerWidth:100];
    [_drawerVC setMaximumRightDrawerWidth:200];
    [_drawerVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [_drawerVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
#if 0       // for test
    self.window.rootViewController = [[MSTestVC alloc] initWithNibName:@"MSTestVC" bundle:nil];
#else       // for real
    self.window.rootViewController = _drawerVC;
#endif

    
    [_window makeKeyAndVisible];
    
    // to correct the layout problem of naivigation controller in tab 1  -- Dong
    _tabBarController.selectedIndex = 1;
    _tabBarController.selectedIndex = 0;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
