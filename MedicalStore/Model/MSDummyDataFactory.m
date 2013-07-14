//
//  MSDummyDataFactory.m
//  MedicalStore
//
//  Created by Dong Yiming on 7/14/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "MSDummyDataFactory.h"
#import "MSProduct.h"

@implementation MSDummyDataFactory
DEF_SINGLETON(MSDummyDataFactory)

-(NSArray *)productStore
{
    static NSMutableArray * productStore = nil;
    if (productStore == nil)
    {
        productStore = [NSMutableArray array];
        int baseID = 100;
        
        MSProduct *product = [MSProduct new];
        product.ID = baseID++;
        product.name = @"Test";
        product.subName = @"sub name";
        product.imageUrl = @"";
        product.briefDescription = @"";
        
        [productStore addObject:product];
    }
    
    return productStore;
}

-(MSProduct *)randomProduct
{
    int count = self.productStore.count;
    int randIndex = arc4random() % count;
    
    return self.productStore[randIndex];
}

@end
