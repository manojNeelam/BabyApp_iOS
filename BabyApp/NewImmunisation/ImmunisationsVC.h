//
//  ImmunisationsVC.h
//  BabyApp
//
//  Created by Jiten on 09/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import "BaseViewController.h"

@interface ImmunisationsVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *baseSegmentView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentImu;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)onClickSwitch:(id)sender;
@property (strong, nonatomic) IBOutlet UINavigationItem *imuNavigationItem;

@end
