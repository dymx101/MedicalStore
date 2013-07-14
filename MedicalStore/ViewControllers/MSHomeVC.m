//
//  FirstViewController.m
//  AKTabBar Example
//
//  Created by Ali KARAGOZ on 04/05/12.
//  Copyright (c) 2012 Ali Karagoz. All rights reserved.
//

#import "MSHomeVC.h"

#import "KASlideShow.h"
#import "MSProductCell.h"
#import "MSProductDetailVC.h"

@interface MSHomeVC () <KASlideShowDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation MSHomeVC
{
    KASlideShow         *_viewSlideShow;
    UITableView         *_tvProducts;
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
    self.navigationItem.title = @"开心药房";
    
    [self _initLayout];
}

-(void)_initLayout
{
    CGSize viewportSize = self.view.bounds.size;
    float offY = 0.f;
    
    _viewSlideShow = [[KASlideShow alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [self.view addSubview:_viewSlideShow];
    
    _viewSlideShow.delegate = self;
    [_viewSlideShow setDelay:3]; 
    [_viewSlideShow setTransitionDuration:.5f]; 
    [_viewSlideShow setTransitionType:KASlideShowTransitionSlide];
    [_viewSlideShow setImagesContentMode:UIViewContentModeScaleAspectFill]; 
    [_viewSlideShow addImagesFromResources:@[@"sample_adv1.jpg",@"sample_adv2.jpg",@"sample_adv3.jpg"]];
    [_viewSlideShow start];
    
    // add efect
    UIView *shadowView = [[UIView alloc] initWithFrame:_viewSlideShow.frame];
    shadowView.backgroundColor = GGSharedColor.orangeGageinDark;
    [self.view insertSubview:shadowView belowSubview:_viewSlideShow];
    //[self.view addSubview:shadowView];
    shadowView.layer.shadowOffset = CGSizeMake(0, 2);
    shadowView.layer.shadowColor = GGSharedColor.black.CGColor;
    shadowView.layer.shadowOpacity = .3f;
    shadowView.layer.shadowRadius = 3.f;
    shadowView.clipsToBounds = NO;
    
    // table view
    offY = CGRectGetMaxY(_viewSlideShow.frame);
    _tvProducts = [[UITableView alloc] initWithFrame:CGRectMake(0, offY, 320, viewportSize.height - offY) style:UITableViewStylePlain];
    [self.view insertSubview:_tvProducts belowSubview:shadowView];
    _tvProducts.delegate = self;
    _tvProducts.dataSource = self;
    _tvProducts.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tvProducts.backgroundColor = GGSharedColor.silver;
}


- (NSString *)tabImageName
{
	return @"tab_home";
}

#pragma mark - UITableViewDataSource
-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MSProductCell"];
    if (cell == nil)
    {
        cell = [MSProductCell viewFromNibWithOwner:self];
    }
    
    return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSProductDetailVC *vc = [MSProductDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
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
