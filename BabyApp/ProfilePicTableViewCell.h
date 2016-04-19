//
//  ProfilePicTableViewCell.h
//  BabyApp
//
//  Created by Charan Giri on 20/02/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfilePicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userProflePic;
@property (weak, nonatomic) IBOutlet UITextField *txtFldName;
@property (weak, nonatomic) IBOutlet UIButton *btnDateOfBirth;
@end
