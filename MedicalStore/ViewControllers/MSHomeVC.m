//
//  FirstViewController.m
//  AKTabBar Example
//
//  Created by Ali KARAGOZ on 04/05/12.
//  Copyright (c) 2012 Ali Karagoz. All rights reserved.
//

#import "MSHomeVC.h"

#import "KASlideShow.h"



@interface MSHomeVC () <KASlideShowDelegate>

@end

@implementation MSHomeVC
{
    KASlideShow         *_viewSlideShow;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"首页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _initLayout];
}

-(void)_initLayout
{
    _viewSlideShow = [[KASlideShow alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [self.view addSubview:_viewSlideShow];
    
    _viewSlideShow.delegate = self;
    [_viewSlideShow setDelay:3]; 
    [_viewSlideShow setTransitionDuration:.5f]; 
    [_viewSlideShow setTransitionType:KASlideShowTransitionSlide];
    [_viewSlideShow setImagesContentMode:UIViewContentModeScaleAspectFill]; 
    [_viewSlideShow addImagesFromResources:@[@"sample_adv1.jpg",@"sample_adv2.jpg",@"sample_adv3.jpg"]];
    [_viewSlideShow start];
}


- (NSString *)tabImageName
{
	return @"tab_home";
}


#pragma mark - KASlideShow delegate

- (void)kaSlideShowDidNext
{
    //NSLog(@"kaSlideShowDidNext");
}

-(void)kaSlideShowDidPrevious
{
    //NSLog(@"kaSlideShowDidPrevious");
}

@end
