//
//  ProfileTableViewCell.m
//  BabyApp
//
//  Created by Charan Giri on 20/02/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "ProfileTableViewCell.h"

@implementation ProfileTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)babyDropdownAction:(id)sender {
    
    [_delegate buttonClickedEvent];

//    UIButton *button = (UIButton*)sender;
//
//    if (button.selected) {
//        
//        [self.dropdown setSelected:NO];
//    }
//    else
//    {
//        [self.dropdown setSelected:YES];
//    }
    
}
@end
