//
//  MSProductCell.m
//  MedicalStore
//
//  Created by Dong Yiming on 7/13/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "MSProductCell.h"

@implementation MSProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    _ivLog.image = [[UIImage imageNamed:@"shadowedBgWhite"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self addSubview:_viewContent];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    [UIView animateWithDuration:.2f animations:^{
        
        if (editing)
        {
            _viewContent.frame = CGRectMake(35, 5, 280, 70);
        }
        else
        {
            _viewContent.frame = CGRectMake(5, 5, 310, 70);
        }
    }];
}

@end
