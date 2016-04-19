//
//  InvestigationDefaultCell.m
//  BabyApp
//
//  Created by Vishal Kolhe on 02/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "InvestigationDefaultCell.h"

@implementation InvestigationDefaultCell
-(void)populateData:(InvestigationOptionsData *)aData
{
    [self.lblTitle setText:aData.testName];
    [self.txtFldResultValue setPlaceholder:aData.placeHolderText];
    [self.txtFldResultValue setText:aData.title];
    [self.txtFldDate setText:aData.date];
}

@end
