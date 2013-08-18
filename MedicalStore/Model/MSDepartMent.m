//
//  MSDepartMent.m
//  MedicalStore
//
//  Created by towne on 13-8-18.
//  Copyright (c) 2013年 Dong Yiming. All rights reserved.
//

#import "MSDepartMent.h"

@implementation MSDepartMent

-(void)parseWithData:(NSDictionary *)aData
{
    [super parseWithData:aData];
    
    self.ID = [[aData objectForKey:@"departmentId"] longLongValue];
    self.phone = [aData objectForKey:@"phone"];
    self.fax = [aData objectForKey:@"fax"];
    self.name = [aData objectForKey:@"name"];
    self.superid = [aData objectForKey:@"superId"];
}

@end
