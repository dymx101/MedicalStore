//
//  MSFavoritesListVC.m
//  MedicalStore
//
//  Created by towne on 13-8-11.
//  Copyright (c) 2013年 Dong Yiming. All rights reserved.
//

#import "MSFavoritesListVC.h"
#import "MSProductCell.h"
#import "MSProductDetailVC.h"
#import "MSTelBook.h"
#import "GGDbManager.h"

@interface MSFavoritesListVC ()
{
    BOOL _mayUsePrivateAPI;
}
@end

@implementation MSFavoritesListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"";
    }
    return self;
}

- (id)initWithSectionIndexes:(BOOL)showSectionIndexes isFavorites:(BOOL)isfavor
{
    
    self = [super initWithSectionIndexes:showSectionIndexes isFavorites:isfavor];
    if (self) {
        
    }
    
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setMenuButton];
	// Do any additional setup after loading the view.
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
//        [self.tableView addSubview:self.searchBar];
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
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
    UIBarButtonItem *leftDrawerButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    [self.navigationController.navigationBar setHidden:NO];
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

#pragma mark - UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MSProductCell"];
    MSTelBook * msTelbook = nil;
    if (cell == nil)
    {
        cell = [MSProductCell viewFromNibWithOwner:self];
    }
    
    
    if(self.isfavor)
    {
        msTelbook = self.favoriteArray[indexPath.row];
        cell.lblTitle.text = msTelbook.name;
        cell.lblSubTitle.text = msTelbook.post;
    }
    else
    {
        msTelbook = self.filteredMSTelName[indexPath.row];
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
    MSTelBook *msTelbook =[self.favoriteArray objectAtIndex:indexPath.row];
    vc.msTelbook = msTelbook;
    vc.keep = ![[GGDbManager sharedInstance] hasTelbookWithID:msTelbook.ID];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)leftDrawerButtonPress:(id)sender{
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
