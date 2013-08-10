//
//  GGAPITest.m
//  WeiGongAn
//
//  Created by dong yiming on 13-4-8.
//  Copyright (c) 2013年 WeiGongAn. All rights reserved.
//

#import "GGAPITest.h"
#import "SBJson.h"
#import "UIDevice+IdentifierAddition.h"


@implementation GGAPITest
{
    NSMutableArray  *_policemans;
}
DEF_SINGLETON(GGAPITest)

- (id)init
{
    self = [super init];
    if (self) {
        _policemans = [NSMutableArray array];
    }
    return self;
}

-(void)run
{
//    [self _testGetWantedRootCategory];
//    [self testInsertWanted];
//    [self _testchooseAreaIos];
//    [self _testgetCluesRootCategory];
//    [self _testgetFunctionsAll];
}

@end
