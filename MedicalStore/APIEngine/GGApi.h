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
-(void)askChecking:(NSString*)aName Phone:(long long)aPhone Mail:(NSString*)aMail callback:(GGApiBlock)aCallback;
//验证码验证接口
-(void)checkCode:(NSString *)aSecurityCode callback:(GGApiBlock)aCallback;
//部门信息接口
-(void)getDepartMent:(GGApiBlock)aCallback;
-(void)getDepartMent:(NSString *)superId callback:(GGApiBlock)aCallback;
//人员信息接口
-(void)getTel:(GGApiBlock)aCallback;
-(void)getTel:(NSString *)aDepartment callback:(GGApiBlock)aCallback;
//手机变更接口
-(void)changePhone:(long long)aPhone callback:(GGApiBlock)aCallback;
//用户信息接口
-(void)getUserInfo:(GGApiBlock)aCallback;
//检查用户
-(void)userCheck:(GGApiBlock)aCallback;
//数据更新接口
-(void)checkUpdate:(GGApiBlock)aCallback;
//版本更新接口
-(void)checkUpdateWithCurrentVersion:(NSString *)aCurrentVersion  callback:(GGApiBlock)aCallback;

@end

#define GGSharedAPI [GGApi sharedApi]

