//
//  GGNApi.h
//  WeiGongAnApp
//
//  Created by dong yiming on 13-3-22.
//  Copyright (c) 2013年 WeiGongAn. All rights reserved.
//

#import <Foundation/Foundation.h>  

typedef void(^GGApiBlock)(id operation, id aResultObject, NSError* anError);


@interface GGApi : AFHTTPClient

// singleton method to get a shared api all over the app
+ (GGApi *)sharedApi;
+ (NSString *)apiBaseUrl;

-(void)canceAllOperations;

-(void)_execPostWithPath:(NSString *)aPath params:(NSDictionary *)aParams callback:(GGApiBlock)aCallback;
-(void)_execGetWithPath:(NSString *)aPath params:(NSDictionary *)aParams callback:(GGApiBlock)aCallback;


#define REPORT_AREA_ID  2
-(NSString *)uniqueNumber;


@end

#define GGSharedAPI [GGApi sharedApi]

