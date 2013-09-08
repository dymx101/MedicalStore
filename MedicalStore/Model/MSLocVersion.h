//
//  MSLocVersion.h
//  MedicalStore
//
//  Created by towne on 13-9-8.
//  Copyright (c) 2013年 Dong Yiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSLocVersion : NSObject <NSCoding>

@property (copy) NSString *versionCode;
@property (copy) NSString *dataVersionCode;

@end
