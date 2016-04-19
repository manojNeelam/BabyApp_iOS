//
//  MedicalConditionCell.h
//  BabyApp
//
//  Created by Vishal Kolhe on 05/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConditionData.h"

@interface MedicalConditionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblCondition;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

-(void)populateData:(ConditionData *)conditionData;

@end
