//
//  ProfileTableViewCell.h
//  BabyApp
//
//  Created by Charan Giri on 20/02/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol resultToController <NSObject>

@optional
- (void)buttonClickedEvent;

@end

@interface ProfileTableViewCell : UITableViewCell
- (IBAction)babyDropdownAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *babyNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *babyPic;
@property (weak, nonatomic) IBOutlet UIButton *dropdown;

@property (weak) id<resultToController> delegate;

@end
