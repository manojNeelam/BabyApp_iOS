//
//  InvestigationDefaultCell.h
//  BabyApp
//
//  Created by Vishal Kolhe on 02/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvestigationOptionsData.h"

@interface InvestigationDefaultCell : UITableViewCell
-(void)populateData:(InvestigationOptionsData *)aData;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtFldResultValue;
@property (weak, nonatomic) IBOutlet UITextField *txtFldDate;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;


@end
