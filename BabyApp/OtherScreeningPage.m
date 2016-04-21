//
//  OtherScreeningPage.m
//  BabyApp
//
//  Created by Atul Awasthi on 08/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "OtherScreeningPage.h"

@interface OtherScreeningPage ()

@end

@implementation OtherScreeningPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedScreenLbl"] capitalizedString];
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 50)];
    [v setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:240.0/255.0 alpha:1.0]];
    [self.view addSubview:v];
    
    
    UITextField *lblName=nil;
    
    lblName=[[UITextField alloc] initWithFrame:CGRectMake(20, v.frame.origin.y+v.frame.size.height+5, self.view.frame.size.width-40, 40)];
    lblName.tag=10;
    [self.view addSubview:lblName];
    [lblName setPlaceholder:@"Other Screening (e.g. Hearing Screening)"];
    
    
   // [lblName setFont:[UIFont fontWithName:@"AvenirNextLTPro-DemiCn" size:20]];

    
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(onClickSave:)];
}

-(void)onClickSave:(id)sender
{
    
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

@end
