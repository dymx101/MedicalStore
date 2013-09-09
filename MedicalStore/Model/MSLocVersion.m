//
//  MSLocVersion.m
//  MedicalStore
//
//  Created by towne on 13-9-8.
//  Copyright (c) 2013年 Dong Yiming. All rights reserved.
//

#import "MSLocVersion.h"

@implementation MSLocVersion

#define VERSION_CODE            @"VERSION_CODE"
#define DATA_VERSION_CODE       @"DATA_VERSION_CODE"


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.versionCode forKey:VERSION_CODE];
    [aCoder encodeObject:self.dataVersionCode forKey:DATA_VERSION_CODE];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    MSLocVersion *instance = [MSLocVersion new];
    instance.versionCode = [aDecoder decodeObjectForKey:VERSION_CODE];
    instance.dataVersionCode = [aDecoder decodeObjectForKey:DATA_VERSION_CODE];
    return instance;
}

@end
