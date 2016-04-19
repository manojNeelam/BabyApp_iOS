//
//  CommonScreeingCell.m
//  BabyApp
//
//  Created by Vishal Kolhe on 06/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "CommonScreeingCell.h"

@implementation CommonScreeingCell

-(void)populateData:(CommonScreeingData *)aData
{
    [self.lblAge setText:aData.sAge];
    [self.lblDesc setText:aData.sDesc];
}
@end
