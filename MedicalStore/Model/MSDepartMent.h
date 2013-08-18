//
//  MSDepartMent.h
//  MedicalStore
//
//  Created by towne on 13-8-18.
//  Copyright (c) 2013年 Dong Yiming. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "GGDataModel.h"

@interface MSDepartMent : GGDataModel

@property(copy) NSString *phone;
@property(copy) NSString *fax;
@property(copy) NSString *name;
@property(copy) NSString *superid;

@end
