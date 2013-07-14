//
//  MSDummyDataFactory.h
//  MedicalStore
//
//  Created by Dong Yiming on 7/14/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSProduct;

@interface MSDummyDataFactory : NSObject
AS_SINGLETON(MSDummyDataFactory)

-(NSArray *)productStore;
-(MSProduct *)randomProduct;
@end
