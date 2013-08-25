//
//  MSProductDetailVC.m
//  MedicalStore
//
//  Created by Dong Yiming on 7/14/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "MSProductDetailVC.h"


@interface MSProductDetailVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *svContent;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTelTitle;
@property (weak, nonatomic) IBOutlet UIView *viewBrief;
@property (weak, nonatomic) IBOutlet UILabel *lblBrief;
@property (weak, nonatomic) IBOutlet UIView *viewHead;
@end

@implementation MSProductDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"联系人";
    
    self.lblTitle.text = _msTelbook.name;
    self.lblSubTitle.text = _msTelbook.post;
    self.lblTelTitle.text = _msTelbook.mobilePhone;
    
    [_viewHead applyEffectShadowAndBorder];
    [_viewBrief applyEffectShadowAndBorder];
    [_ivLogo applyEffectRoundRectSilverBorder];
}

-(IBAction)m1:(id)sender
{
    NSLog(@"method_1");
}


-(IBAction)m2:(id)sender
{
    NSLog(@"method_2");
}

-(IBAction)m3:(id)sender
{
    NSLog(@"method_3");
}

-(IBAction)m4:(id)sender
{
    NSLog(@"method_4");
}
@end
