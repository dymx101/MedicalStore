//
//  FKRSearchBarVC.h
//  MedicalStore
//
//  Created by towne on 13-8-6.
//  Copyright (c) 2013年 Dong Yiming. All rights reserved.
//

#import "MSBaseVC.h"

static NSString * const kFKRSearchBarTableViewControllerDefaultTableViewCellIdentifier = @"kFKRSearchBarTableViewControllerDefaultTableViewCellIdentifier";

@interface MSSearchBarVC : MSBaseVC<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

- (id)initWithSectionIndexes:(BOOL)                   showSectionIndexes;

- (void)scrollTableViewToSearchBarAnimated:(BOOL)     animated; // Implemented by the subclasses

@property(nonatomic, assign, readonly) BOOL           showSectionIndexes;

@property(nonatomic, strong, readwrite) UITableView   *tableView;
@property(nonatomic, strong, readwrite) UISearchBar   *searchBar;

@property(nonatomic, strong) NSArray *sections;

@property(nonatomic,assign) int     typeId;

@property(nonatomic, strong) NSMutableArray           *filteredMSTelName;
@property(nonatomic, strong) NSMutableArray           *primevalMSTelName;
@property(nonatomic, strong) NSMutableDictionary      *filteredMSTelMSG;
@property(nonatomic, strong) NSString                 *currentSearchString;

@property(nonatomic, strong) UISearchDisplayController *strongSearchDisplayController; // UIViewController doesn't retain the search display controller if it's created programmatically: http://openradar.appspot.com/10254897

- (id)initWithSectionIndexes:(BOOL)showSectionIndexes isFavorites:(BOOL)isfavor;

@end
