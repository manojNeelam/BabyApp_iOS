//
//  InvestOtherTestCell.m
//  BabyApp
//
//  Created by Vishal Kolhe on 02/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "InvestOtherTestCell.h"

@implementation InvestOtherTestCell
-(void)populateData:(InvestigationOptionsData *)aData
{
    [self.txtFldOtherTest setPlaceholder:aData.placeHolderText];
    [self.txtFldOtherTest setText:aData.title];
    [self.txtFldDate setText:aData.date];
}
@end
