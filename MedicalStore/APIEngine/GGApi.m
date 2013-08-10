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
    return [NSString stringWithFormat:@"%@/", GGN_STR_PRODUCTION_SERVER_URL];
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


@end
