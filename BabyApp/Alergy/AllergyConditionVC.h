//
//  AllergyConditionVC.h
//  BabyApp
//
//  Created by Vishal Kolhe on 05/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "BaseViewController.h"
#import "ConditionData.h"

@interface AllergyConditionVC : BaseViewController
- (IBAction)saveAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtFldCondition;
@property (weak, nonatomic) IBOutlet UITextView *txtViewDesc;

@property (nonatomic, strong) ConditionData *coditionData;

@end
