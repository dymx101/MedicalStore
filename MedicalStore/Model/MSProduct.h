//
//  MSProduct.h
//  MedicalStore
//
//  Created by Dong Yiming on 7/14/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSProduct : MSBaseModel
@property (copy)    NSString    *subName;
@property (copy)    NSString    *imageUrl;
@property (assign)  float       originalPrice;
@property (assign)  float       price;
@property (copy)    NSString    *briefDescription;
@end
