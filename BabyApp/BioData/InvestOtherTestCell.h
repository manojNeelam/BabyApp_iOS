//
//  InvestOtherTestCell.h
//  BabyApp
//
//  Created by Vishal Kolhe on 02/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvestigationOptionsData.h"

@interface InvestOtherTestCell : UITableViewCell
-(void)populateData:(InvestigationOptionsData *)aData;
@property (weak, nonatomic) IBOutlet UITextField *txtFldOtherTest;
@property (weak, nonatomic) IBOutlet UITextField *txtFldDate;

@end
