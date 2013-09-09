//
//  MSDepartmentDetailVC.h
//  MedicalStore
//
//  Created by towne on 13-9-8.
//  Copyright (c) 2013年 Dong Yiming. All rights reserved.
//

#import "MSBaseVC.h"
@class MSDepartMent;

@interface MSDepartmentDetailVC : MSBaseVC

@property(nonatomic,strong) MSDepartMent *msDepartment;

-(IBAction)call1:(id)sender;
-(IBAction)call2:(id)sender;
-(IBAction)call3:(id)sender;

@end
