//
//  PercentialViewController.h
//  BabyApp
//
//  Created by Charan Giri on 15/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PercentialViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *graphView;
@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;

@property(nonatomic,strong) NSString *titleString;
@property(nonatomic,strong) NSString *suffix;
@property(nonatomic,strong) NSString *yaxisName;

@property(nonatomic,strong) NSString *titleLableString;
@property(nonatomic,strong) NSString *subTitleLableString;
@end
