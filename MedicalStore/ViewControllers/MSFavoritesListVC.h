//
//  MSFavoritesListVC.h
//  MedicalStore
//
//  Created by towne on 13-8-11.
//  Copyright (c) 2013年 Dong Yiming. All rights reserved.
//

#import "MSBaseVC.h"

#import "MSSearchBarVC.h"

@interface MSFavoritesListVC : MSSearchBarVC

@property BOOL departmentSearch;

- (id)initWithSectionIndexes:(BOOL)showSectionIndexes isFavorites:(BOOL)isfavor;
- (id)initWithSectionIndexes:(BOOL)showSectionIndexes isFavorites:(BOOL)isfavor isDepartmentSearch:(BOOL)isDepartmentSearch;

@end
