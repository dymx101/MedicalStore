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
        product.name = @"Aomana噢吗哪奶蓟浓缩复合软胶囊";
        product.subName = @"源自新西兰野生奶蓟草";
        product.imageUrl = @"http://img.360kxr.com/product/2013/05/865328c84fa74adaab8fa7a80c204430.JPG";
        product.briefDescription = @"通用名称： 奶蓟浓缩复合软胶囊 \
        商品编号：B04003385 \
        商品规格：735mg*90粒 \
        商品重量：110g \
        商品单位：瓶 \
        批准文号：进口 \
        生产企业：新西兰Manuka公司，厦门喜之源生物工程有限公司";
        
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
