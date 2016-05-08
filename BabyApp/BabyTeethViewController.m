//
//  BabyTeethViewController.m
//  BabyApp
//
//  Created by Pai, Ankeet on 08/05/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "BabyTeethViewController.h"
#import "AdultTeethViewController.h"

@interface BabyTeethViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnAdultTeeth;
- (IBAction)onClickAdultTeeth:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnBabyTeeth;
- (IBAction)onClickBabyTeeth:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblUpperTeeth;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//Sub View
@property (weak, nonatomic) IBOutlet UIView *baseTeethView;

@property (weak, nonatomic) IBOutlet UIButton *btnTeeth10;
- (IBAction)onClickTeth10:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth1;
- (IBAction)onClickTeth1:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth2;
- (IBAction)onClickTeth2:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth3;
- (IBAction)onClickTeth3:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth4;
- (IBAction)onClickTeth4:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth5;
- (IBAction)onClickTeth5:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth6;
- (IBAction)onClickTeth6:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth7;
- (IBAction)onClickTeth7:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth8;
- (IBAction)onClickTeth8:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth9;
- (IBAction)onClickTeth9:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth11;
- (IBAction)onClickTeth11:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth12;
- (IBAction)onClickTeth12:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth13;
- (IBAction)onClickTeth13:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth14;
- (IBAction)onClickTeth14:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnTeeth15;
- (IBAction)onClickTeth15:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnTeeth16;
- (IBAction)onClickTeth16:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth17;
- (IBAction)onClickTeth17:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnTeeth18;
- (IBAction)onClickTeth18:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth19;
- (IBAction)onClickTeth19:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnTeeth20;
- (IBAction)onClickTeth20:(id)sender;

//Images
@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth1;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth2;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth3;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth4;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth5;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth6;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth7;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth8;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth9;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth10;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth11;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth12;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth13;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth14;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth15;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth16;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth17;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth18;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth19;

@property (weak, nonatomic) IBOutlet UIImageView *imgTeeth20;

@end

@implementation BabyTeethViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.btnBabyTeeth setBackgroundColor:[UIColor lightGrayColor]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickAdultTeeth:(id)sender {
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AdultTeethViewController_SB_ID"];
    [self.navigationController pushViewController:vc animated:NO];
}

- (IBAction)onClickBabyTeeth:(id)sender {
}
- (IBAction)onClickTeth10:(id)sender {
}

- (IBAction)onClickTeth1:(id)sender {
}

- (IBAction)onClickTeth2:(id)sender {
}

- (IBAction)onClickTeth3:(id)sender {
}

- (IBAction)onClickTeth4:(id)sender {
}

- (IBAction)onClickTeth5:(id)sender {
}

- (IBAction)onClickTeth6:(id)sender {
}

- (IBAction)onClickTeth7:(id)sender {
}

- (IBAction)onClickTeth8:(id)sender {
}

- (IBAction)onClickTeth9:(id)sender {
}

- (IBAction)onClickTeth11:(id)sender {
}

- (IBAction)onClickTeth12:(id)sender {
}

- (IBAction)onClickTeth13:(id)sender {
}

- (IBAction)onClickTeth14:(id)sender {
}

- (IBAction)onClickTeth15:(id)sender {
}

- (IBAction)onClickTeth16:(id)sender {
}

- (IBAction)onClickTeth17:(id)sender {
}

- (IBAction)onClickTeth18:(id)sender {
}

- (IBAction)onClickTeth19:(id)sender {
}

- (IBAction)onClickTeth20:(id)sender {
}

@end
