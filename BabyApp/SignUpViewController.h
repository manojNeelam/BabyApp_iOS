//
//  SignUpViewController.h
//  BabyApp
//
//  Created by Charan Giri on 21/02/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
- (IBAction)createAccount:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;

@end
