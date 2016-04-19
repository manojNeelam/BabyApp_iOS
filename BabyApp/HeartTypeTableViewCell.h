//
//  HeartTypeTableViewCell.h
//  BabyApp
//
//  Created by Charan Giri on 20/02/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeartTypeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
- (IBAction)changeImage:(id)sender;

@end
