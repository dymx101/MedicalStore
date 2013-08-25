//
//  FKRSearchBarVC.m
//  MedicalStore
//
//  Created by towne on 13-8-6.
//  Copyright (c) 2013年 Dong Yiming. All rights reserved.
//

#import "MSSearchBarVC.h"
#import "MSDepartMent.h"
#import "MSTelBook.h"

@interface MSSearchBarVC ()

@property(nonatomic,strong) NSMutableArray       *departArray;

@property(nonatomic,strong) NSMutableDictionary  *departTelDict;

@end



@implementation MSSearchBarVC

- (id)initWithSectionIndexes:(BOOL)showSectionIndexes
{
    if ((self = [super initWithNibName:nil bundle:nil])) {
        self.title = @"Search Bar";
        _showSectionIndexes = showSectionIndexes;
    }
    
    return self;
}

- (void) getTelData
{
    [GGSharedAPI getTel:^(id operation, id aResultObject, NSError *anError) {
        GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
        NSMutableArray *array =[parser parseMSTelBook];
        NSLog(@"%@",array);
        
        self.filteredMSTelName =  [NSMutableArray new];
        self.primevalMSTelName =  [NSMutableArray new];
        self.filteredMSTelMSG  =  [NSMutableDictionary new];
        for (MSTelBook *book in array) {
            [_filteredMSTelName addObject:book.name];
            [_filteredMSTelMSG setObject:book forKey:book.name];
        }
        self.primevalMSTelName = [NSMutableArray arrayWithArray:_filteredMSTelName];
        NSMutableArray *dep_tel = [NSMutableArray new];
        
        for (MSDepartMent *dep in _departArray) {
            for (MSTelBook *telbook in array) {
                if ([telbook.departmentId intValue] == dep.ID) {
                    [dep_tel addObject:telbook];
                }
            }
            if ([dep_tel count] > 0) {
                [_departTelDict setObject:[NSArray arrayWithArray:dep_tel] forKey:[NSString stringWithFormat:@"%lld",dep.ID]];
                [dep_tel removeAllObjects];
            }
            
        }
        [self initUseInterface];
    }];
}

- (void) initUseInterface
{
    [self.view hideLoadingHUD];
    
    if (_showSectionIndexes) {
//        UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
//        
        NSMutableArray *unsortedSections = [[NSMutableArray alloc] initWithCapacity:[_departArray count]];
        
        for (NSUInteger i = 0; i < [_departArray count]; i++) {
            MSDepartMent *dep = _departArray[i];
            NSArray * telbooks = [_departTelDict objectForKey:[NSString stringWithFormat:@"%lld",dep.ID]];
            [unsortedSections addObjectIfNotNil:telbooks];
        }
        self.sections = unsortedSections;
        [self.tableView reloadData];
    }
}

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
	// Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate = self;
    
    [self.searchBar sizeToFit];
    
    self.strongSearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.delegate = self;
    
    _departArray    = [NSMutableArray new];
    _departTelDict  = [NSMutableDictionary new];
    
    NSLog(@">>> %d",self.typeId);
    
    [self.view showLoadingHUDWithText:@"数据加载中..."];
    
    [GGSharedAPI getDepartMent:^(id operation, id aResultObject, NSError *anError) {
        GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
        NSMutableArray *array = [parser parseMSDepartMent];
        NSLog(@"%@",array);
        for (MSDepartMent *department in array) {
            if (self.typeId == [department.superid intValue] ) {
                [_departArray addObject:department];
            }
        }
        [self getTelData];
        
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (animated) {
        [self.tableView flashScrollIndicators];
    }
}

- (void)scrollTableViewToSearchBarAnimated:(BOOL)animated
{
    NSAssert(YES, @"This method should be handled by a subclass!");
}

#pragma mark - TableView Delegate and DataSource

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.tableView && self.showSectionIndexes) {
        return [[NSArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:[[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
        return nil;
    } else {
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView && self.showSectionIndexes) {
        if ([[self.sections objectAtIndex:section] count] > 0) {
            MSDepartMent *_depart = _departArray[section];
            return _depart.name;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if ([title isEqualToString:UITableViewIndexSearch]) {
        [self scrollTableViewToSearchBarAnimated:NO];
        return NSNotFound;
    } else {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index] - 1; // -1 because we add the search symbol
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
        if (self.showSectionIndexes) {
            return self.sections.count;
        } else {
            return 1;
        }
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        if (self.showSectionIndexes) {
            return [[self.sections objectAtIndex:section] count];
        } else {
            return [_sections[section] count];
        }
    } else {
        return self.filteredMSTelName.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFKRSearchBarTableViewControllerDefaultTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kFKRSearchBarTableViewControllerDefaultTableViewCellIdentifier];
    }
    
    if (tableView == self.tableView) {
        if (self.showSectionIndexes) {
            cell.textLabel.text = [[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        } else {
            cell.textLabel.text = [_sections[indexPath.section] objectAtIndex:indexPath.row];
        }
    } else {
        cell.textLabel.text = [self.filteredMSTelName objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Search Delegate

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    self.filteredMSTelName = nil;
    self.currentSearchString = @"";
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    self.filteredMSTelName = nil;
    self.currentSearchString = nil;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    if (searchString.length > 0) { // Should always be the case
        NSMutableArray *personsToSearch = [NSMutableArray arrayWithArray:self.primevalMSTelName];
        if (self.currentSearchString.length > 0 && [searchString rangeOfString:self.currentSearchString].location == 0) { // If the new search string starts with the last search string, reuse the already filtered array so searching is faster
            personsToSearch = self.filteredMSTelName;
        }
        
        self.filteredMSTelName = [NSMutableArray arrayWithArray:[personsToSearch filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(SELF CONTAINS[cd] %@) OR (SELF BEGINSWITH[cd] %@) OR (SELF ENDSWITH[cd] %@)", searchString,searchString,searchString]]];
    }
    
    self.currentSearchString = searchString;
    
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
