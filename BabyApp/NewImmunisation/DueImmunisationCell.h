//
//  DueImmunisationCell.h
//  BabyApp
//
//  Created by Jiten on 09/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DueImmunisationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDose;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@property (weak, nonatomic) IBOutlet UIView *baseView;
@end
