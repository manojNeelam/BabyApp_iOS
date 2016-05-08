//
//  AdultViewController.h
//  BabyApp
//
//  Created by Pai, Ankeet on 08/05/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "BaseViewController.h"

@interface AdultTeethViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *btnAdult;
@property (weak, nonatomic) IBOutlet UIButton *btnBaby;
- (IBAction)onClickAdultButton:(id)sender;
- (IBAction)onClickBabyButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *baseInfoView;
- (IBAction)onClickInfoButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnInfoButton;

@end
