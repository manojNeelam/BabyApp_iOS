//
//  MedicationCategory.h
//  BabyApp
//
//  Created by Atul Awasthi on 17/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicationCategory : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic) UITableView *medicationCategoryTable;
@property NSArray *labelArraymedicationCategory;

@end
