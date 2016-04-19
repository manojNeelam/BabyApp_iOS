//
//  BirthRecordTableViewController.h
//  BabyApp
//
//  Created by Charan Giri on 22/02/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BioDataObj.h"

@interface BirthRecordTableViewController : UIViewController

@property (nonatomic, strong) BioDataObj *selectedBioData;

@property (weak, nonatomic) IBOutlet UIView *baseBirthCertificateNoView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldBirthCertificateNo;

@property (weak, nonatomic) IBOutlet UIView *basePlaceOfDeliveryView;
@property (weak, nonatomic) IBOutlet UITextField *txtfldPlaceOfDelivery;

@property (weak, nonatomic) IBOutlet UIView *baseSexView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldSex;


@property (weak, nonatomic) IBOutlet UIView *baseEthnicGroupView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldEthnicGroup;


@property (weak, nonatomic) IBOutlet UIView *baseDurationGestationView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldDurationGestation;

@property (weak, nonatomic) IBOutlet UIView *baseModeOfDeliveryView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldModeofDelivery;

@property (weak, nonatomic) IBOutlet UIView *baseWeightAtBirth;
@property (weak, nonatomic) IBOutlet UITextField *txtFldWeightAtBirth;

@property (weak, nonatomic) IBOutlet UIView *baseLenghtAtBirthView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldLengthAtBirth;

@property (weak, nonatomic) IBOutlet UIView *baseHeadCircumferenceView;
@property (weak, nonatomic) IBOutlet UITextField *txtFldHeadCircunference;



- (IBAction)onClickPreviousButton:(id)sender;
- (IBAction)onClickNextButton:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *baseApgarScoreView;
@property (weak, nonatomic) IBOutlet UIView *minDurationView;
@property (weak, nonatomic) IBOutlet UIView *maxDurationView;

@property (weak, nonatomic) IBOutlet UILabel *lblMinDuration;
@property (weak, nonatomic) IBOutlet UILabel *lblMaxDuration;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)onClickDone:(id)sender;

@end
