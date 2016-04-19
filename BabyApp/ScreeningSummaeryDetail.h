//
//  ScreeningSummaeryDetail.h
//  BabyApp
//
//  Created by Sarvajeet Singh on 3/21/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScreeningSummaeryDetail : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *screeningSummaryDetailTable;

@end
