//
//  DrugAlergyCell.m
//  BabyApp
//
//  Created by Vishal Kolhe on 04/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "DrugAlergyCell.h"

@implementation DrugAlergyCell
-(void)populateData:(DrugAlergyData *)drugData
{
    [self.lblConfirmed setText:drugData.status];
    [self.lblDate setText:drugData.date];
    [self.lblReaction setText:drugData.reaction];
    [self.lblTitle setText:drugData.drugTitle];
}
@end
