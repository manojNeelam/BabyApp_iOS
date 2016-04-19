//
//  ScreeningSummaryViewController.h
//  BabyApp
//
//  Created by Sarvajeet Singh on 3/20/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScreeningSummaryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *screeningSummaryTable;

@end
