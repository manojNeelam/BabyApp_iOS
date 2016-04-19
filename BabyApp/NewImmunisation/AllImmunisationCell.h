//
//  AllImmunisationCell.h
//  BabyApp
//
//  Created by Jiten on 09/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllImmunisationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UIImageView *imgNotePad;
@property (weak, nonatomic) IBOutlet UILabel *lblLine;
@property (weak, nonatomic) IBOutlet UILabel *lblNext;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@end
