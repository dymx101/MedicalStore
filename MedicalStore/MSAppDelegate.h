//
//  MSAppDelegate.h
//  MedicalStore
//
//  Created by Dong Yiming on 7/13/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"

@class AKTabBarController;
@class RDVTabBarController;

@interface MSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) RDVTabBarController *tabBarController;
@property (strong, nonatomic) MMDrawerController *drawerVC;
@end

#define SharedAppDelegate      ((MSAppDelegate *)[UIApplication sharedApplication].delegate)
