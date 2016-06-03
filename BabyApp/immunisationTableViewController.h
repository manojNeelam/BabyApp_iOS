//
//  immunisationTableViewController.h
//  BabyApp
//
//  Created by Charan Giri on 28/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
@interface immunisationTableViewController : UIViewController <SlideNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *baseSegmentView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentDateType;
- (IBAction)onSwitchDateType:(id)sender;

@end
