//
//  MSTelBook.h
//  MedicalStore
//
//  Created by towne on 13-8-18.
//  Copyright (c) 2013年 Dong Yiming. All rights reserved.
//

#import "GGDataModel.h"

@interface MSTelBook : GGDataModel <NSCoding>

@property (copy) NSString *departmentId;
@property (copy) NSString *moduleId;
@property (copy) NSString *name;
@property (copy) NSString *post;
@property (copy) NSString *officePhone;
@property (copy) NSString *mobilePhone;
@property (copy) NSString *homePhone;

@end
