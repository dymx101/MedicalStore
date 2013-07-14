//
//  ThirdViewController.m
//  AKTabBar Example
//
//  Created by Ali KARAGOZ on 04/05/12.
//  Copyright (c) 2012 Ali Karagoz. All rights reserved.
//

#import "MSCartVC.h"
#import "MSProductCell.h"
#import "MSProductDetailVC.h"
#import "GGUtils.h"

@interface MSCartVC () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MSCartVC
{
    UITableView         *_tvProducts;
    UILabel             *_lblEmpty;
    int                 _rowCount;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"购物车";
        _rowCount = 10;
    }
    return self;
}

- (NSString *)tabImageName
{
	return @"tab_cart";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(modifyAction:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下单" style:UIBarButtonItemStylePlain target:self action:@selector(dealAction:)];
    
    [self _initLayout];
}

-(void)_initLayout
{
    CGRect viewportRc = [GGLayout pageRectWithLayoutElement:kLayoutElementAll];
    _tvProducts = [[UITableView alloc] initWithFrame:viewportRc style:UITableViewStylePlain];
    [self.view addSubview:_tvProducts];
    _tvProducts.delegate = self;
    _tvProducts.dataSource = self;
    _tvProducts.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tvProducts.backgroundColor = GGSharedColor.silver;
    
    _lblEmpty = [[UILabel alloc] init];
    _lblEmpty.text = @"您的购物车是空的";
    _lblEmpty.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    _lblEmpty.backgroundColor = [UIColor clearColor];
    _lblEmpty.font = [UIFont fontWithName:@"Helvetica-Light" size:15];
    _lblEmpty.autoresizingMask = UIViewAutoresizingFlexibleBorder;
    [_lblEmpty sizeToFit];
    _lblEmpty.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    [self.view addSubview:_lblEmpty];
    _lblEmpty.shadowColor = GGSharedColor.white;
    _lblEmpty.shadowOffset = CGSizeMake(0, 1);
    _lblEmpty.hidden = YES;
}

#pragma mark -
-(void)modifyAction:(id)sender
{
    DLog(@"modifyAction");
    
    [_tvProducts setEditing:!_tvProducts.editing animated:YES];
    
    self.navigationItem.leftBarButtonItem.title = _tvProducts.editing ? @"完成" : @"修改";
}

-(void)dealAction:(id)sender
{
    DLog(@"deal");
}

#pragma mark - UITableViewDataSource
-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _lblEmpty.hidden = _rowCount;
    return _rowCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MSProductCell"];
    if (cell == nil)
    {
        cell = [MSProductCell viewFromNibWithOwner:self];
        cell.btnAddCart.hidden = YES;
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

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        _rowCount --;
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

//-(UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}

@end
