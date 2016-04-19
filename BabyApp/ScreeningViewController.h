//
//  ScreeningViewController.h
//  BabyApp
//
//  Created by Atul Awasthi on 07/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
@interface ScreeningViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SlideNavigationControllerDelegate>
@property (nonatomic) UITableView *screeningTable;

@end
