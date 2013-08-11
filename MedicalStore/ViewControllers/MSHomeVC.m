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

#import <QuartzCore/QuartzCore.h>
#import <objc/message.h>

@interface MSHomeVC ()
{
    BOOL _mayUsePrivateAPI;
}

@end

@implementation MSHomeVC

- (id)initWithSectionIndexes:(BOOL)showSectionIndexes
{
    if ((self = [super initWithSectionIndexes:showSectionIndexes])) {
        self.title = @"";
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
    if (cell == nil)
    {
        cell = [MSProductCell viewFromNibWithOwner:self];
    }
    
    if (tableView == self.tableView) {
        if (self.showSectionIndexes) {
            cell.lblTitle.text = [[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            cell.lblSubTitle.text = [self.posts objectAtIndex:[self.famousPersons indexOfObject:cell.lblTitle.text]];
        } else {
            cell.lblTitle.text = [self.famousPersons objectAtIndex:indexPath.row];
            cell.lblSubTitle.text = [self.posts objectAtIndex:indexPath.row];
        }
    } else {
        cell.lblTitle.text = [self.filteredPersons objectAtIndex:indexPath.row];
        cell.lblSubTitle.text = [self.posts objectAtIndex:indexPath.row];
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
    
    vc.lblTString = [[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    vc.lblSTString = [self.posts objectAtIndex:[self.famousPersons indexOfObject:vc.lblTString]];

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

@end
