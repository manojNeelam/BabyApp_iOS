//
//  MedicalConditionVC.h
//  BabyApp
//
//  Created by Vishal Kolhe on 05/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "BaseViewController.h"

@interface MedicalConditionVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)AddButtonAction:(id)sender;


@property (nonatomic, strong) NSMutableArray *listOfObjects;
@end
