//
//  ParticularsOfParentsVC.h
//  BabyApp
//
//  Created by Vishal Kolhe on 01/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "BaseViewController.h"

@interface ParticularsOfParentsVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *txtFldName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldPassportNo;
@property (weak, nonatomic) IBOutlet UITextField *txtFldOccupation;
@property (weak, nonatomic) IBOutlet UITextField *txtFldTelRes;
@property (weak, nonatomic) IBOutlet UITextField *txtFldTlOFF;
@property (weak, nonatomic) IBOutlet UITextField *txtFldTelHP;
@property (weak, nonatomic) IBOutlet UITextField *txtFldFatherName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldFatherPassportNo;
@property (weak, nonatomic) IBOutlet UITextField *txtFldFatherOccupation;
@property (weak, nonatomic) IBOutlet UITextField *txtFldFatherTelRes;
@property (weak, nonatomic) IBOutlet UITextField *txtFldFatherTelOff;
@property (weak, nonatomic) IBOutlet UITextField *txtFldFatherTelHp;
- (IBAction)onClickPreviousButton:(id)sender;

- (IBAction)onClickNextButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *baseTelFatherHP;

@end
