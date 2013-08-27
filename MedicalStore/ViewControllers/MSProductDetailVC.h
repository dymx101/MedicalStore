//
//  MSProductDetailVC.h
//  MedicalStore
//
//  Created by Dong Yiming on 7/14/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTelBook.h"

@interface MSProductDetailVC : MSBaseVC

@property(nonatomic,strong) MSTelBook *msTelbook;
@property (nonatomic)BOOL keep;   // 收藏 1 or 取消收藏 0


-(IBAction)call:(id)sender;
-(IBAction)sendmessage:(id)sender;
-(IBAction)addfavorite:(id)sender;

@end
