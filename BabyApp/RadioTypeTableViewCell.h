//
//  RadioTypeTableViewCell.h
//  BabyApp
//
//  Created by Charan Giri on 20/02/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioTypeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UILabel *contentNamelabel;
- (IBAction)ChangeImage:(id)sender;

@end
