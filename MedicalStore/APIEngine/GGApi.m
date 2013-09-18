//
//  GGNApiClient.m
//  WeiGongAnApp
//
//  Created by dong yiming on 13-3-22.
//  Copyright (c) 2013年 WeiGongAn. All rights reserved.
//

#import "GGApi.h"
#import "NSString+MD5Addition.h"
#import "UIDevice+IdentifierAddition.h"


@implementation GGApi

+(NSString *)apiBaseUrl
{
    return [NSString stringWithFormat:@"%@/", GGN_STR_PRODUCT_SERVER_URL];
}

+ (GGApi *)sharedApi
{
    
    static dispatch_once_t pred;
    static GGApi *_sharedApi = nil;
    
    dispatch_once(&pred, ^{ _sharedApi = [[self alloc] initWithBaseURL:[NSURL URLWithString:[self apiBaseUrl]]]; });
    return _sharedApi;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"text/html"];
    return self;
}

-(void)canceAllOperations
{
    [self.operationQueue cancelAllOperations];
}

#pragma mark - internal
-(void)_logRawResponse:(id)anOperation
{
    AFHTTPRequestOperation *httpOp = anOperation;
    
    DLog(@"\nRequest:\n%@\n\nRAW DATA:\n%@\n", httpOp.request.URL.absoluteString, httpOp.responseString);
}

-(void)_handleResult:(id)aResultObj
           operation:(id)anOperation
               error:(NSError *)anError
            callback:(GGApiBlock)aCallback
{
    [self _logRawResponse:anOperation];
    
    if (aCallback) {
        aCallback(anOperation, aResultObj, anError);
    }
}

-(void)_execGetWithPath:(NSString *)aPath params:(NSDictionary *)aParams callback:(GGApiBlock)aCallback
{
    [self getPath:aPath
       parameters:aParams
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              [self _handleResult:responseObject operation:operation error:nil callback:aCallback];
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              [self _handleResult:nil operation:operation error:error callback:aCallback];
    
          }];
}

-(void)_execPostWithPath:(NSString *)aPath params:(NSDictionary *)aParams callback:(GGApiBlock)aCallback
{
    [self postPath:aPath
        parameters:aParams
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
               [self _handleResult:responseObject operation:operation error:nil callback:aCallback];
               
           }
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               
               [self _handleResult:nil operation:operation error:error callback:aCallback];
               
           }];
}


#define REPORT_AREA_ID  2
-(NSString *)uniqueNumber
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateStr = [formatter stringFromDate:date];
    
    int randInt = arc4random() % 100000;
    
    return [NSString stringWithFormat:@"%@%d", dateStr, randInt];
}

//申请验证接口
//接口地址：http://rhtsoft.gnway.net:8889/tel/telBook-askChecking.rht
//参数：name  姓名
//phone 手机号
//code  机器码
//返回参数：(json格式)
//返回：flag 并把验证码发到邮箱
//0 申请成功 并把验证码发到邮箱
//1 申请失败

-(void)askChecking:(NSString*)aName Phone:(long long)aPhone Mail:(NSString*)aMail callback:(GGApiBlock)aCallback
{
//    NSLog(@">> %@",[self hexStringFromString:aName]);
    NSString *path = @"telBook-askChecking.rht";
    NSString *aCode = [UIDevice macaddress]; //机器码用mac地址
//    aCode = @"3C:07:54:17:EF:22";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:aName forKey:@"name"];
    [parameters setObject:__LONGLONG(aPhone) forKey:@"phone"];
    [parameters setObject:aMail forKey:@"mail"];
    [parameters setObject:aCode forKey:@"code"];
    [parameters setObject:__INT(2) forKey:@"phonePlatform"];
    [self _execGetWithPath:path params:parameters callback:aCallback];
}

//验证码验证接口
//
//接口地址：http://rhtsoft.gnway.net:8889/tel/telBook-checkCode.rht
//参数：code              机器码
//securityCode    验证码
//返回参数：(json格式)
//返回：flag
//0 验证成功
//1 验证失败
-(void)checkCode:(NSString *)aSecurityCode callback:(GGApiBlock)aCallback
{
    NSString *path = @"telBook-checkCode.rht";
    NSString *aCode = [UIDevice macaddress]; //机器码用mac地址
//    aCode = @"3C:07:54:17:EF:22";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:aCode forKey:@"code"];
    [parameters setObject:aSecurityCode forKey:@"securityCode"];
    [self _execGetWithPath:path params:parameters callback:aCallback];
}

//部门信息接口
//
//接口地址：http://rhtsoft.gnway.net:8889/tel/telBook-getDepartMent.rht
//返回参数：(json格式)
//返回：departmentId  部门id
//name            部门名称
//phone           部门电话
//fax              部门传真
//superId         模块id
-(void)getDepartMent:(GGApiBlock)aCallback
{
    [self getDepartMent:@"all" callback:aCallback];
}

-(void)getDepartMent:(NSString *)superId callback:(GGApiBlock)aCallback;
{
    NSString *path = @"telBook-getDepartMent.rht";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (![superId isEqualToString:@"all"]) {
        [parameters setObject:superId forKey:@"superId"];
    }

    [self _execGetWithPath:path params:parameters callback:aCallback];
}
//人员信息接口
//接口地址：http://rhtsoft.gnway.net:8889/tel/telBook-getTel.rht
//参数： code   机器码
//返回参数：(json格式)
//返回：telId         人员id
//departmentId部门id
//moduleId     模块id
//name          姓名
//post          职务
//officePhone  办公电话
//mobilePhone  移动电话
//homePhone    住宅电话
-(void)getTel:(NSString *)aDepartment callback:(GGApiBlock)aCallback
{
    NSString *path = @"telBook-getTel.rht";
    NSString *aCode = [UIDevice macaddress]; //机器码用mac地址
//    aCode = @"3C:07:54:17:EF:22";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:aCode forKey:@"code"];
    if (![aDepartment isEqualToString:@"all"]) {
        [parameters setObject:aDepartment forKey:@"departmentId"];
    }
    [self _execGetWithPath:path params:parameters callback:aCallback];
}

-(void)getTel:(GGApiBlock)aCallback
{
    [self getTel:@"all" callback:aCallback];
}

//手机变更接口
//
//接口地址：http://rhtsoft.gnway.net:8889/tel/telBook-changePhone.rht
//参数：code    机器码
//phone   手机号
//返回参数：(json格式)
//返回：flag
//0 变更成功
//1 变更失败
-(void)changePhone:(long long)aPhone callback:(GGApiBlock)aCallback
{
    NSString *path = @"telBook-changePhone.rht";
    NSString *aCode = [UIDevice macaddress]; //机器码用mac地址
//    aCode = @"3C:07:54:17:EF:22";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:aCode forKey:@"code"];
    [parameters setObject:__LONGLONG(aPhone) forKey:@"phone"];
    [self _execGetWithPath:path params:parameters callback:aCallback];
}

//用户信息接口
//
//接口地址：http://rhtsoft.gnway.net:8889/tel/telBook-getUserInfo.rht
//返回参数：(json格式)
//返回：name 姓名
//phone 手机号
-(void)getUserInfo:(GGApiBlock)aCallback
{
    NSString *path = @"telBook-getUserInfo.rht";
    NSString *aCode = [UIDevice macaddress]; //机器码用mac地址
//    aCode = @"3C:07:54:17:EF:22";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:aCode forKey:@"code"];
    [self _execGetWithPath:path params:parameters callback:aCallback];
}

//检查用户
//接口地址：http://rhtsoft.gnway.net:8889/tel/telBook-userCheck.rht
//返回参数：(json格式)
//返回：flag   0 验证成功   1 验证失败
-(void)userCheck:(GGApiBlock)aCallback
{
    NSString *path = @"telBook-userCheck.rht";
    NSString *aCode = [UIDevice macaddress]; //机器码用mac地址
    //    aCode = @"3C:07:54:17:EF:22";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:aCode forKey:@"code"];
    [self _execGetWithPath:path params:parameters callback:aCallback];
}

//检查更新接口
//
//接口地址：http://rhtsoft.gnway.net:8889/tel/telBook-checkUpdate.rht
//返回参数：(json格式)
//返回：state 更新标识
//客户端检查自己的更新标识是否与服务器端一样，一样无需进行更新，不一样需要更新
//举例：state 值为2，客户端自己的值为1，表示有数据更新
-(void)checkUpdate:(GGApiBlock)aCallback
{
    NSString *path = @"telBook-checkUpdate.rht";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [self _execGetWithPath:path params:parameters callback:aCallback];
}

//在线升级接口（Ios）

//接口地址：http://rhtsoft.gnway.net:8889/tel/telBook-versionInfoIos.rht
//参数：cltVerion  客户端版本
//返回参数：(json格式)
//返回：verName当前服务器端版本号 如：1.2  可以理解为：小版本
//verCode 当前服务器端版本号 如：2  可以理解为；大版本
//Updates 更新内容，其中#号为分隔符，代表换行
//客户端检查自己版本是否与服务器端版本一样，一样无需进行升级，不一样需要升级
//举例：verName值为1.3，客户端自己的版本号为1.2，表示有更新文件 调用文件下载接口进行下载。
-(void)checkUpdateWithCurrentVersion:(NSString *)aCurrentVersion  callback:(GGApiBlock)aCallback
{
    NSString *path = @"telBook-versionInfoIos.rht";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:aCurrentVersion forKey:@"cltVerion"];
    
    [self _execPostWithPath:path params:parameters callback:aCallback];
}

-(NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr]; 
    } 
    return hexStr; 
}

@end
