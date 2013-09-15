//
//  FirstViewController.h
//  AKTabBar Example
//
//  Created by Ali KARAGOZ on 04/05/12.
//  Copyright (c) 2012 Ali Karagoz. All rights reserved.
//
#import "MSSearchBarVC.h"

@interface MSHomeVC : MSSearchBarVC

@property(nonatomic,strong) NSString *MSTabImageName;
@property(nonatomic,strong) NSMutableDictionary *tempdictionary;


- (id)initWithSectionIndexes:(BOOL)showSectionIndexes TypeId:(int)typeId;

@end
