//
//  DrugAlergyListVC.h
//  BabyApp
//
//  Created by Vishal Kolhe on 04/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "BaseViewController.h"
#import "ConnectionsManager.h"


@interface DrugAlergyListVC : BaseViewController <UITableViewDataSource,UITableViewDelegate, ServerResponseDelegate>
- (IBAction)addDrug:(id)sender;
@property (nonatomic, strong) NSMutableArray *listOfObjects;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
