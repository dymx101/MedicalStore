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

//申请验证接口
-(void)askChecking:(NSString*)aName Phone:(long long)aPhone Code:(NSString*)aCode callback:(GGApiBlock)aCallback;
//验证码验证接口
-(void)checkCode:(NSString *)aCode SecurityCode:(long long)aSecurityCode callback:(GGApiBlock)aCallback;
//部门信息接口
-(void)getDepartMent:(GGApiBlock)aCallback;
//人员信息接口
-(void)getTel:(NSString *)aCode callback:(GGApiBlock)aCallback;
//手机变更接口
-(void)changePhone:(NSString *)aCode Phone:(long long)aPhone callback:(GGApiBlock)aCallback;
//用户信息接口
-(void)getUserInfo:(GGApiBlock)aCallback;
//检查更新接口
-(void)checkUpdate:(GGApiBlock)aCallback;

@end

#define GGSharedAPI [GGApi sharedApi]

