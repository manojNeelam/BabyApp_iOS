//
//  CommonScreeingListVC.h
//  BabyApp
//
//  Created by Vishal Kolhe on 06/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonScreeingListVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *listOfObjects;
@property (nonatomic, strong) NSString *navTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UINavigationItem *commonVCNavigationItem;

@end
