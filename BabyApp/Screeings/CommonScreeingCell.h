//
//  CommonScreeingCell.h
//  BabyApp
//
//  Created by Vishal Kolhe on 06/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonScreeingData.h"

@interface CommonScreeingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIView *baseAgeView;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UIButton *btnRadio;

-(void)populateData:(CommonScreeingData *)aData;

@end
