//
//  MedicalConditionCell.m
//  BabyApp
//
//  Created by Vishal Kolhe on 05/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "MedicalConditionCell.h"

@implementation MedicalConditionCell
-(void)populateData:(ConditionData *)conditionData
{
    [self.lblCondition setText:conditionData.condition];
    [self.lblDesc setText:conditionData.desc];
}
@end
