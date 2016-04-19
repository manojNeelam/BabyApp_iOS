//
//  DrugAlergyCell.h
//  BabyApp
//
//  Created by Vishal Kolhe on 04/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugAlergyData.h"

@interface DrugAlergyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblReaction;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblConfirmed;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;


-(void)populateData:(DrugAlergyData *)drugData;
@end
