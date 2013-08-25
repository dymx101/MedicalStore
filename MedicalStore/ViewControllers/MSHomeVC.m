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
#import "MSTelBook.h"

#import <QuartzCore/QuartzCore.h>
#import <objc/message.h>

@interface MSHomeVC ()
{
    BOOL _mayUsePrivateAPI;
}

@end

@implementation MSHomeVC

- (id)initWithSectionIndexes:(BOOL)showSectionIndexes TypeId:(int)typeId
{
    self.typeId = typeId;
    
    if ((self = [super initWithSectionIndexes:showSectionIndexes])) {
        self.title = @"";
        [self setMenuButton];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self.navigationController.view printViewsTree];
    
    self.navigationController.view.backgroundColor = GGSharedColor.random;
    self.view.backgroundColor = GGSharedColor.random;
    //self.navigationController.navigationBar.tintColor = GGSharedColor.random;
    //[self.navigationController.navigationBar setPos:CGPointZero];
    //[self.view.superview setPos:CGPointMake(0, 100)];
    //[self.navigationController.view setPos:CGPointMake(0, -20)];
    
    [self _Layout];
}

-(void)_Layout
{
    if (_mayUsePrivateAPI) {
        self.tableView.tableHeaderView = self.searchBar;
        
        SEL setPinsTableHeaderViewSelector = NSSelectorFromString(@"_setPinsTableHeaderView:");
        if ([self.tableView respondsToSelector:setPinsTableHeaderViewSelector]) {
            objc_msgSend(self.tableView, setPinsTableHeaderViewSelector, YES);
        }
    } else {
        [self.tableView addSubview:self.searchBar];
        
        self.tableView.contentInset = UIEdgeInsetsMake(CGRectGetHeight(self.searchBar.bounds), 0, 0, 0);
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(CGRectGetHeight(self.searchBar.bounds), 0, 0, 0);
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = GGSharedColor.silverLight;
}

/**
 * 功能:左键设菜单
 */
-(void)setMenuButton
{
    UIBarButtonItem *leftDrawerButton = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setRightBarButtonItem:leftDrawerButton animated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[_tvProducts setHeight:self.view.bounds.size.height];
}


- (void)scrollTableViewToSearchBarAnimated:(BOOL)animated
{
    // The search bar is always visible, so just scroll to the first section
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:animated];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) { // Don't do anything if the search table view get's scrolled
        if (!_mayUsePrivateAPI) {
            if (scrollView.contentOffset.y < -CGRectGetHeight(self.searchBar.bounds)) {
                self.searchBar.layer.zPosition = 0; // Make sure the search bar is below the section index titles control when scrolling up
            } else {
                self.searchBar.layer.zPosition = 1; // Make sure the search bar is above the section headers when scrolling down
            }
            
            CGRect searchBarFrame = self.searchBar.frame;
            searchBarFrame.origin.y = MAX(scrollView.contentOffset.y, -CGRectGetHeight(searchBarFrame));
            
            self.searchBar.frame = searchBarFrame;
        }
    }
}

#pragma mark - Overrides

/*
 Override these methods so that the search symbol isn't shown in the section index titles control.
 */

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.tableView && self.showSectionIndexes) {
        return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]; // Don't show the search symbol
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (NSString *)tabImageName
{
	return _MSTabImageName;
}

#pragma mark - UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MSProductCell"];
    MSTelBook * msTelbook = nil;
    if (cell == nil)
    {
        cell = [MSProductCell viewFromNibWithOwner:self];
    }
    
    if (tableView == self.tableView) {
        if (self.showSectionIndexes) {
            msTelbook = self.sections[indexPath.section][indexPath.row];
            cell.lblTitle.text = msTelbook.name;
            cell.lblSubTitle.text = msTelbook.post;
  
        } 
    } else {
        msTelbook = [self.filteredMSTelMSG objectForKey:self.filteredMSTelName[indexPath.row]];
        cell.lblTitle.text = msTelbook.name;
        cell.lblSubTitle.text = msTelbook.post;
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
    MSTelBook *msTelbook;
    if (tableView == self.tableView) 
        msTelbook = self.sections[indexPath.section][indexPath.row];
    else
        msTelbook = [self.filteredMSTelMSG objectForKey:self.filteredMSTelName[indexPath.row]];
    vc.msTelbook = msTelbook;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - KASlideShow delegate

//- (void)kaSlideShowDidNext
//{
//    //NSLog(@"kaSlideShowDidNext");
//}
//
//-(void)kaSlideShowDidPrevious
//{
//    //NSLog(@"kaSlideShowDidPrevious");
//}


#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [SharedAppDelegate.drawerVC toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

@end
