//
//  AddAllergyVC.h
//  BabyApp
//
//  Created by Vishal Kolhe on 05/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "BaseViewController.h"
#import "DrugAlergyData.h"

@interface AddAllergyVC : BaseViewController
- (IBAction)saveAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtFldDrugName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldAllergyReaction;
@property (weak, nonatomic) IBOutlet UITextField *txtFldDate;
@property (weak, nonatomic) IBOutlet UILabel *lblConfirmed;
@property (weak, nonatomic) IBOutlet UILabel *lblSuspect;
@property (weak, nonatomic) IBOutlet UIButton *btnDate;
- (IBAction)onClickOpenDate:(id)sender;

@property (nonatomic, strong) DrugAlergyData *drugAlergyData;
@end
