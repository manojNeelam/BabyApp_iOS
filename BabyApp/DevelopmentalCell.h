//
//  DevelopmentalCell.h
//  BabyApp
//
//  Created by Sandeep Dave on 24/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DevelopmentalCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *lblMonth;
@property (weak, nonatomic) IBOutlet UILabel *lblnumber1;
@property (weak, nonatomic) IBOutlet UILabel *lblnumber2;
@property (weak, nonatomic) IBOutlet UILabel *lblnumber3;
@property (weak, nonatomic) IBOutlet UIImageView *imgSelected;

@property (weak, nonatomic) IBOutlet UILabel *lblimmunsation;
@end
