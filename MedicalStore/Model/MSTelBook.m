//
//  MSTelBook.m
//  MedicalStore
//
//  Created by towne on 13-8-18.
//  Copyright (c) 2013年 Dong Yiming. All rights reserved.
//

#import "MSTelBook.h"

@implementation MSTelBook

-(void)parseWithData:(NSDictionary *)aData
{
    [super parseWithData:aData];
    
    self.ID = [[aData objectForKey:@"telId"] longLongValue];
    self.departmentId = [aData objectForKey:@"departmentId"];
    self.moduleId = [aData objectForKey:@"moduleId"];
    self.name = [aData objectForKey:@"name"];
    self.post = [aData objectForKey:@"post"];
    self.officePhone = [aData objectForKey:@"officePhone"];
    self.mobilePhone = [aData objectForKey:@"mobilePhone"];
    self.homePhone = [aData objectForKey:@"homePhone"];
}

#define DEP_ID                  @"DEP_ID"
#define DEP_DEPARTMENT_ID       @"DEP_DEPARTMENT_ID"
#define DEP_MODULE_ID           @"DEP_MODULE_ID"
#define DEP_NAME                @"DEP_NAME"
#define DEP_POST                @"DEP_POST"
#define DEP_OFFICE_PHONE        @"DEP_OFFICE_PHONE"
#define DEP_MOBILE_PHONE        @"DEP_MOBILE_PHONE"
#define DEP_HOME_PHONE          @"DEP_HOME_PHONE"

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt64:self.ID forKey:DEP_ID];
    [aCoder encodeObject:self.departmentId forKey:DEP_DEPARTMENT_ID];
    [aCoder encodeObject:self.moduleId forKey:DEP_MODULE_ID];
    [aCoder encodeObject:self.name forKey:DEP_NAME];
    [aCoder encodeObject:self.post forKey:DEP_POST];
    [aCoder encodeObject:self.officePhone forKey:DEP_OFFICE_PHONE];
    [aCoder encodeObject:self.mobilePhone forKey:DEP_MOBILE_PHONE];
    [aCoder encodeObject:self.homePhone forKey:DEP_HOME_PHONE];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    MSTelBook *instance = [MSTelBook model];
    instance.ID = [aDecoder decodeInt64ForKey:DEP_ID];
    instance.departmentId = [aDecoder decodeObjectForKey:DEP_DEPARTMENT_ID];
    instance.moduleId = [aDecoder decodeObjectForKey:DEP_MODULE_ID];
    instance.name = [aDecoder decodeObjectForKey:DEP_NAME];
    instance.post = [aDecoder decodeObjectForKey:DEP_POST];
    instance.officePhone = [aDecoder decodeObjectForKey:DEP_OFFICE_PHONE];
    instance.mobilePhone = [aDecoder decodeObjectForKey:DEP_MOBILE_PHONE];
    instance.homePhone = [aDecoder decodeObjectForKey:DEP_HOME_PHONE];
    
    return instance;
}

@end
