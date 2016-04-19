//
//  GrowthSummary.h
//  BabyApp
//
//  Created by Atul Awasthi on 17/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
@interface GrowthSummary : UIViewController<UITableViewDataSource,UITableViewDelegate,SlideNavigationControllerDelegate>
@property (nonatomic) UITableView *growthSummaryTable;

@end
