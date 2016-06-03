//
//  SelectScheduleVC.h
//  BabyApp
//
//  Created by Pai, Ankeet on 03/06/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectScheduleVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *baseOption1View;
@property (weak, nonatomic) IBOutlet UIView *baseOption2View;
@property (weak, nonatomic) IBOutlet UIView *baseOption3View;
@property (weak, nonatomic) IBOutlet UIButton *btnProceed;
- (IBAction)onClickProceedButon:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgOption1;
@property (weak, nonatomic) IBOutlet UIImageView *imgOption2;
@property (weak, nonatomic) IBOutlet UIImageView *imgOption3;

@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblDescOption1;
@property (weak, nonatomic) IBOutlet UILabel *lblDescOption2;


@property (nonatomic, assign) BOOL isFromImmunisation;

@end
