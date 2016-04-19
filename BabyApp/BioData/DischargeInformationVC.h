//
//  DischargeInformationVC.h
//  BabyApp
//
//  Created by Vishal Kolhe on 02/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "BaseViewController.h"

@interface DischargeInformationVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *baseDateView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldDate;

@property (weak, nonatomic) IBOutlet UIView *baseWeightView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldWeight;

@property (weak, nonatomic) IBOutlet UIView *baseBreastFeed;
@property (weak, nonatomic) IBOutlet UITextField *txtFldBreastFeed;

@property (weak, nonatomic) IBOutlet UIView *baseSerumView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldSerum;

@end
