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

//-(void)_TestaskChecking
//{
//    [GGSharedAPI getCheckCode:@"towne" Phone:13397186156 Mail:@"tangqii@163.com" callback:^(id operation, id aResultObject, NSError *anError) {
//        GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
//        long flag = [[[parser apiData] objectForKey:@"flag"] longValue];
//        DLog(@">>>> %ld",flag);
//    }];
//}
//
//-(void)_TestcheckCode
//{
//    [GGSharedAPI checkCode:@"QXDWUO" callback:^(id operation, id aResultObject, NSError *anError) {
//        GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
//        long flag = [[[parser apiData] objectForKey:@"flag"] longValue];
//        DLog(@">>>> %ld",flag);
//    }];
//}

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

//        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//        NSString *pageSource = [[NSString alloc] initWithData:aResultObject encoding:gbkEncoding];
//        
////        NSString *string = [[NSString alloc] initWithData:aResultObject encoding:NSUTF8StringEncoding];
//        NSLog(@"decoded:%@", pageSource);
//        NSData *decoded = [GTMBase64 decodeString:pageSource];
////        decoded =[GTMBase64 decodeString:@"eyJuYW1lIjoidG93bmUiLCJxcSI6IjEyMzQ1NiJ9"];
//        
//        NSString *s2 = [[NSString alloc] initWithData:decoded encoding:gbkEncoding];
//         NSLog(@"decoded1:%@", s2);
//        NSData* data1=[s2 dataUsingEncoding:NSUTF8StringEncoding];
        
        GGApiParser *parser = [GGApiParser parserWithRawData:aResultObject];
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
