//
//  CommonSelectionListVC.h
//  BabyApp
//
//  Created by Vishal Kolhe on 02/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "BaseViewController.h"

@protocol CommonSelectionListVCDelegate <NSObject>

-(void)selectedValue:(NSString *)aSelected;

@end

@interface CommonSelectionListVC : BaseViewController

@property (nonatomic, strong) NSString *keyString;

@property (nonatomic, assign) id<CommonSelectionListVCDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
