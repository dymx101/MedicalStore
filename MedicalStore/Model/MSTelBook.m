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

@end
