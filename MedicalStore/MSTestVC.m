//
//  MSTestVC.m
//  MedicalStore
//
//  Created by towne on 13-8-16.
//  Copyright (c) 2013年 Dong Yiming. All rights reserved.
//

#import "MSTestVC.h"
#import "GGAPITest.h"

@interface MSTestVC ()

@end

@implementation MSTestVC

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

-(IBAction)testAction:(id)sender
{
    [[GGAPITest sharedInstance] run];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
