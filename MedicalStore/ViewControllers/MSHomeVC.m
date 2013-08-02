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

#import "MSDummyDataFactory.h"
#import "MSProduct.h"
#import "MSAppDelegate.h"

@interface MSHomeVC () <KASlideShowDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation MSHomeVC
{
    KASlideShow         *_viewSlideShow;
    UITableView         *_tvProducts;
    NSMutableArray      *_products;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"首页";
        _products = [NSMutableArray array];
        for (int i = 0; i < 10; i++)
        {
            [_products addObject:[MSDummyDataFactory sharedInstance].randomProduct];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"区直部门";
    
    [self _initLayout];
}

-(void)_initLayout
{
    CGRect viewportRect = [GGLayout pageRectWithLayoutElement:kLayoutElementAll];
    float offY = 0.f;
    
//    _viewSlideShow = [[KASlideShow alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
//    [self.view addSubview:_viewSlideShow];
//    
//    _viewSlideShow.delegate = self;
//    [_viewSlideShow setDelay:3]; 
//    [_viewSlideShow setTransitionDuration:.5f]; 
//    [_viewSlideShow setTransitionType:KASlideShowTransitionSlide];
//    [_viewSlideShow setImagesContentMode:UIViewContentModeScaleAspectFill]; 
//    [_viewSlideShow addImagesFromResources:@[@"sample_adv1.jpg",@"sample_adv2.jpg",@"sample_adv3.jpg"]];
//    [_viewSlideShow start];
//    
//    // add efect
//    UIView *shadowView = [[UIView alloc] initWithFrame:_viewSlideShow.frame];
//    shadowView.backgroundColor = GGSharedColor.orangeGageinDark;
//    [self.view insertSubview:shadowView belowSubview:_viewSlideShow];
//    
//    shadowView.layer.shadowOffset = CGSizeMake(0, 2);
//    shadowView.layer.shadowColor = GGSharedColor.black.CGColor;
//    shadowView.layer.shadowOpacity = .3f;
//    shadowView.layer.shadowRadius = 3.f;
//    shadowView.clipsToBounds = NO;
//    
//    // table view
//    offY = CGRectGetMaxY(_viewSlideShow.frame);
    
    CGRect tvRc = CGRectMake(0, offY, 320, viewportRect.size.height - offY);
    _tvProducts = [[UITableView alloc] initWithFrame:tvRc style:UITableViewStylePlain];
    //_tvProducts.autoresizingMask = UIViewAutoresizingFixLeftTop;

//    [self.view insertSubview:_tvProducts belowSubview:shadowView];
    [self.view addSubview:_tvProducts];
    _tvProducts.delegate = self;
    _tvProducts.dataSource = self;
    _tvProducts.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tvProducts.backgroundColor = GGSharedColor.silver;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[_tvProducts setHeight:self.view.bounds.size.height];
}


- (NSString *)tabImageName
{
	return @"tab_home";
}

#pragma mark - UITableViewDataSource
-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
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
