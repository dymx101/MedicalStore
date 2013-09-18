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

#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"

#import "GGDataStore.h"
#import "NSObject+BeeNotification.h"
#import "Reachability.h"
#import "GGProfileVC.h"
#import "GGPhoneMask.h"
 

@implementation MSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // If the device is an iPad, we make it taller.
    //_tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 70 : 50];
    //[_tabBarController setMinimumHeightToDisplayTitle:40.0];
    
    _tabBarController = [[RDVTabBarController alloc] init];
    
    
    NSMutableArray *vcs = [NSMutableArray array];
    
    MSHomeVC * homeVc1 = [[MSHomeVC alloc] initWithSectionIndexes:YES TypeId:1];
    homeVc1.navigationItem.title = @"区'四大家'领导";
    homeVc1.MSTabImageName = @"tab1";
    [homeVc1.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab1s"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab1"]];
    UINavigationController * nc1  = [[UINavigationController alloc] initWithRootViewController:homeVc1];
    
    MSHomeVC * homeVc2 = [[MSHomeVC alloc] initWithSectionIndexes:YES TypeId:2];
    homeVc2.navigationItem.title = @"区直部门";
    homeVc2.MSTabImageName = @"tab2";
    UINavigationController * nc2  = [[UINavigationController alloc] initWithRootViewController:homeVc2];
    
    MSHomeVC * homeVc3 = [[MSHomeVC alloc] initWithSectionIndexes:YES TypeId:3];
    homeVc3.navigationItem.title = @"乡镇开发区";
    homeVc3.MSTabImageName = @"tab3";
    UINavigationController * nc3  = [[UINavigationController alloc] initWithRootViewController:homeVc3];
    
    MSHomeVC * homeVc4 = [[MSHomeVC alloc] initWithSectionIndexes:YES TypeId:4];
    homeVc4.navigationItem.title = @"学校医院";
    homeVc4.MSTabImageName = @"tab4";
    UINavigationController * nc4  = [[UINavigationController alloc] initWithRootViewController:homeVc4];
    
    [vcs addObjectsFromArray:@[nc1,nc2,nc3,nc4]];
    
    _tabBarController.viewControllers = vcs;
    //0,161,225
    //_tabBarController.tabBar.tintColor = [UIColor colorWithRed:0 green:161.f / 255 blue:225.f / 255 alpha:1];
    
    //71,142,200
    UIColor *tintColor = [UIColor colorWithRed:71.f / 255 green:142.f / 255 blue:200.f / 255 alpha:1];
    [[UINavigationBar appearance] setTintColor:tintColor];
    
    UINavigationController * root = [[UINavigationController alloc] initWithRootViewController:_tabBarController
                                     ];
    [root.navigationBar setHidden:YES];
    
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
    //_tabBarController.selectedIndex = 1;
    _tabBarController.selectedIndex = 0;
    
    [self customizeTabBarForController:_tabBarController];
    
    //    [self refreshData];
    if([self isExistenceNetwork])
    {
       [GGSharedAPI userCheck:^(id operation, id aResultObject, NSError *anError) {
           GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
           long flag = [[[parser apiData] objectForKey:@"flag"] longValue];
           if (flag != 0) {
               GGProfileVC *vc = [GGProfileVC new];
               UINavigationController *baseNC = [[UINavigationController alloc] initWithRootViewController:vc];
               [[GGPhoneMask sharedInstance] addMaskVC:baseNC animated:YES alpha:1.0];
           }
       }];
    }
    
    return YES;
}

-(BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork;
    Reachability *r = [Reachability reachabilityWithHostname:GGN_STR_TEST_SERVER_URL];
    
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork=FALSE;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=TRUE;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=TRUE;
            break;
    }
    
    return isExistenceNetwork;
}

-(void)refreshData
{
    if ([GGDataStore loadDepartments].count <= 0 && [GGDataStore loadTelbooks].count <= 0)
    {
        return;
    }
    
    [GGSharedAPI getDepartMent:^(id operation, id aResultObject, NSError *anError) {
        
        GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
        NSMutableArray *departments = [parser parseMSDepartMent];
        [GGDataStore saveDepartments:departments];
        
        [GGSharedAPI getTel:^(id operation, id aResultObject, NSError *anError) {
            GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
            NSMutableArray *telbooks =[parser parseMSTelBook];
            [GGDataStore saveTelbooks:telbooks];
            [self postNotification:MS_NOTIFY_DATA_REFRESHED];
        }];
        
    }];
    
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    //UIImage *finishedImage = [[UIImage imageNamed:@"tabbar_selected_background"]
    //                        resizableImageWithCapInsets:UIEdgeInsetsMake(0, 1, 0, 0)];
    //UIImage *unfinishedImage = [[UIImage imageNamed:@"tabbar_unselected_background"]
    //                          resizableImageWithCapInsets:UIEdgeInsetsMake(0, 1, 0, 0)];
    
    RDVTabBar *tabBar = [tabBarController tabBar];
    tabBar.edgeContentInset = 0.f;
    
    // 67,140,202
    UIColor *tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabBg"]];
    tabBar.backgroundColor = tintColor;//[UIColor colorWithRed:67.f / 255 green:140.f / 255 blue:202.f / 255 alpha:1];
    
    CGRect rc = CGRectMake(CGRectGetMinX(tabBar.frame), CGRectGetMinY(tabBar.frame), 320, 60);
    [tabBar setFrame:rc];
    
    for (int i = 0; i < 4; i++)
    {
        RDVTabBarItem *item = tabBarController.tabBar.items[i];

        UIImage *finishedImg, *unfinishedImg;
        switch (i)
        {
            case 0:
            {
                finishedImg = [UIImage imageNamed:@"tab1s"];
                unfinishedImg = [UIImage imageNamed:@"tab1"];
            }
                break;
                
            case 1:
            {
                finishedImg = [UIImage imageNamed:@"tab2s"];
                unfinishedImg = [UIImage imageNamed:@"tab2"];
            }
                break;
                
            case 2:
            {
                finishedImg = [UIImage imageNamed:@"tab3s"];
                unfinishedImg = [UIImage imageNamed:@"tab3"];
            }
                break;
                
            case 3:
            {
                finishedImg = [UIImage imageNamed:@"tab4s"];
                unfinishedImg = [UIImage imageNamed:@"tab4"];
            }
                break;
                
            default:
                break;
        }
        
        [item setBackgroundSelectedImage:finishedImg withUnselectedImage:unfinishedImg];
    }
    
    
    
    //    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
    //        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
    //        UIImage *image = [UIImage imageNamed:@"first"];
    //        [item setFinishedSelectedImage:image withFinishedUnselectedImage:image];
    //    }
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
