//
//  AdultViewController.m
//  BabyApp
//
//  Created by Pai, Ankeet on 08/05/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "AdultTeethViewController.h"

@interface AdultTeethViewController ()
{
    BOOL isShowInfo;
}
@end

@implementation AdultTeethViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.baseInfoView setHidden:YES];
    [self.btnAdult setBackgroundColor:[UIColor lightGrayColor]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onClickAdultButton:(id)sender
{
    
}

- (IBAction)onClickBabyButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
    [self.btnAdult setBackgroundColor:[UIColor clearColor]];
}

- (IBAction)onClickInfoButton:(id)sender
{
    [self.btnInfoButton setHidden:YES];
    [self.baseInfoView setHidden:NO];
}
@end
