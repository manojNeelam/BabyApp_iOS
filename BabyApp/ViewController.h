//
//  ViewController.h
//  BabyApp
//
//  Created by Charan Giri on 19/02/16.
//  Copyright © 2016 Infinity. All rights reserved.
//https://docs.google.com/document/d/122v0cly77RSypixUOu4aZ3KQGM-kdEW0IXbsDfiKOQI/edit

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
- (IBAction)signinAction:(id)sender;
- (IBAction)facebookSigninAction:(id)sender;
- (IBAction)forgotPasswordAction:(id)sender;

- (IBAction)signupAction:(id)sender;

@end

