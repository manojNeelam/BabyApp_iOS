//
//  SettingsViewController.h
//  BabyApp
//
//  Created by Syntel-Amargoal1 on 4/15/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import "BaseViewController.h"
#import "SlideNavigationController.h"


@interface SettingsViewController : BaseViewController<SlideNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtFldFullName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFldPassword;
@property (weak, nonatomic) IBOutlet UISwitch *notiSwitch;
- (IBAction)onClickSwitch:(id)sender;

@end
