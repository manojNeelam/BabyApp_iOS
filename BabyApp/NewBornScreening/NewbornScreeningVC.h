//
//  NewbornScreeningVC.h
//  BabyApp
//
//  Created by Vishal Kolhe on 01/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewbornScreeningVC : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//G6PD
@property (weak, nonatomic) IBOutlet UIView *baseG6pdView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldG6PD;

//TSH
@property (weak, nonatomic) IBOutlet UIView *baseTSHView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldTSH;

//TF4
@property (weak, nonatomic) IBOutlet UIView *baseTF4View;
@property (weak, nonatomic) IBOutlet UITextField *txtFldTF4;

//DateTF4
@property (weak, nonatomic) IBOutlet UIView *baseDateTF4View;
@property (weak, nonatomic) IBOutlet UITextField *txtFldTF4Date;

//IEM Screeming
@property (weak, nonatomic) IBOutlet UIView *baseIEMScreemingView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldIEMScreeming;

//DATE IEM Screeming
@property (weak, nonatomic) IBOutlet UIView *baseDateIEMScreemingView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldDateIEMScreeming;

//OAE View
@property (weak, nonatomic) IBOutlet UIView *baseOAEView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldOAE;

//Base OAE View
@property (weak, nonatomic) IBOutlet UIView *baseDateOAEView;

@property (weak, nonatomic) IBOutlet UITextField *txtFldDateOAE;

@property (weak, nonatomic) IBOutlet UIView *baseLeftPassView;
@property (weak, nonatomic) IBOutlet UILabel *txtFldLeftPass;


@property (weak, nonatomic) IBOutlet UIView *baseRightPassView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldBaseRight;

@property (weak, nonatomic) IBOutlet UIView *baseNeedsFurthurView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldNeedFurthur;

@property (weak, nonatomic) IBOutlet UIView *baseRemarksView;
- (IBAction)onClickPreviousButton:(id)sender;

- (IBAction)onClickNextButton:(id)sender;

@end
