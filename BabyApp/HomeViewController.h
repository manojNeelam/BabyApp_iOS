//
//  HomeViewController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "ConnectionsManager.h"

@interface HomeViewController : UIViewController <SlideNavigationControllerDelegate, ServerResponseDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *addBioButton;

@property (weak, nonatomic) IBOutlet UIImageView *childPic;

@property (weak, nonatomic) IBOutlet UIButton *btnEncyclopedia;
@property (weak, nonatomic) IBOutlet UIButton *btnHealthbooklet;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrHBWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrEncWidth;

@property (weak, nonatomic) IBOutlet UIView *baseBHView;
@property (weak, nonatomic) IBOutlet UIView *baseEncycloView;

@end
