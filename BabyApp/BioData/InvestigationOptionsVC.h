//
//  InvestigationOptionsVC.h
//  BabyApp
//
//  Created by Vishal Kolhe on 02/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "BaseViewController.h"

@interface InvestigationOptionsVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *investTableView;
@property (weak, nonatomic) IBOutlet UIView *bottomHolderView;
- (IBAction)onClickPreviousButton:(id)sender;
- (IBAction)onClickNextButton:(id)sender;

@end
