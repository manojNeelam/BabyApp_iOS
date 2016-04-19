//
//  ScreeningParentalViewController.h
//  BabyApp
//
//  Created by Atul Awasthi on 08/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScreeningParentalViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic) UITableView *screeningConcernTable;
@property (nonatomic, strong) NSArray *listOfObjects;
@end
