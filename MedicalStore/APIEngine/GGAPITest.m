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
#import "MSUserInfo.h"
#import "MSTelBook.h"
#import "GTMBase64.h"


@implementation GGAPITest
{
}
DEF_SINGLETON(GGAPITest)

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

-(void)run   
{
//    [self _TestgetTel2];
//    [self _TestaskChecking];
//    [self _TestcheckCode];
    [self _TestgetDep1];
//    [self _TestchangePhone];
//    [self _TestgetUserInfo];
}

-(void)_TestgetTel
{
    [GGSharedAPI getTel:^(id operation, id aResultObject, NSError *anError) {

    }];
}

-(void) _TestgetTel2
{
    [GGSharedAPI getTel:@"18" callback:^(id operation, id aResultObject, NSError *anError) {
        GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
        NSMutableArray *array = [parser parseMSTelBook];
        NSLog(@">>>>> %@",array);
    }];
}

-(void)_TestaskChecking
{
    [GGSharedAPI askChecking:@"towne" Phone:13397186156 callback:^(id operation, id aResultObject, NSError *anError) {
        GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
        long flag = [[[parser apiData] objectForKey:@"flag"] longValue];
        DLog(@">>>> %ld",flag);
    }];
}

-(void)_TestcheckCode
{
    [GGSharedAPI checkCode:@"QXDWUO" callback:^(id operation, id aResultObject, NSError *anError) {
        GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
        long flag = [[[parser apiData] objectForKey:@"flag"] longValue];
        DLog(@">>>> %ld",flag);
    }];
}

-(void)_TestgetDep
{
    [GGSharedAPI getDepartMent:^(id operation, id aResultObject, NSError *anError) {
        GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
        NSMutableArray *array = [parser parseMSDepartMent];
        NSLog(@">>>>> %@",array);
    }];
}

-(void)_TestgetDep1
{
    [GGSharedAPI getDepartMent:@"4" callback:^(id operation, id aResultObject, NSError *anError) {

        NSString *string = [[NSString alloc] initWithData:aResultObject encoding:NSUTF8StringEncoding];
        NSLog(@"decoded:%@", string);
        NSData *decoded = [GTMBase64 decodeString:string];
        decoded =[GTMBase64 decodeString:@"e25hbWU6InRvd25lIixxcToiMTIzNDU2In0="];
        
        NSString *s2 = [[NSString alloc] initWithData:decoded encoding:NSUTF8StringEncoding];
         NSLog(@"decoded1:%@", s2);
        
        
        GGApiParser *parser = [GGApiParser parserWithRawData:decoded];
        NSMutableArray *array = [parser parseMSDepartMent];
        NSLog(@">>>>> %@",array);
    }];
}

-(void)_TestchangePhone
{
    [GGSharedAPI getDepartMent:^(id operation, id aResultObject, NSError *anError) {
        GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
        NSMutableArray *array = [parser parseMSDepartMent];
        NSLog(@">>>>> %@",array);
    }];
}

-(void)_TestgetUserInfo
{
    [GGSharedAPI getUserInfo:^(id operation, id aResultObject, NSError *anError) {
        GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
        MSUserInfo *user = [parser parseMSUserInfo];
        NSLog(@">>>>> %@",user);
    }];
}



@end
