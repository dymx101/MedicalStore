//
//  MSUserInfo.m
//  MedicalStore
//
//  Created by towne on 13-8-18.
//  Copyright (c) 2013年 Dong Yiming. All rights reserved.
//

#import "MSUserInfo.h"

@implementation MSUserInfo

-(void)parseWithData:(NSDictionary *)aData
{
    [super parseWithData:aData];
    
    self.phone = [aData objectForKey:@"phone"];
    self.name = [aData objectForKey:@"name"];
}

@end
