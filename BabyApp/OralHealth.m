//
//  OralHealth.m
//  BabyApp
//
//  Created by Atul Awasthi on 25/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "OralHealth.h"

@interface OralHealth ()
@property (weak, nonatomic) IBOutlet UIImageView *bhImage;

@end

@implementation OralHealth

UIButton *b1,*b2;

- (void)viewDidLoad {
    [super viewDidLoad];
   // _bhImage.image=[UIImage imageNamed:@"Oral health.png"];
    
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"forOral"])
    {
        _bhImage.image=[UIImage imageNamed:@"Oral health.png"];
        self.navigationItem.title = @"ORAL HEALTH";
        
        b1=[[UIButton alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width/2, 30)];
        
        b2=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width/2, 30)];
        [self.view addSubview:b1];
        [self.view addSubview:b2];
        [b1 setTitle:@"ADULT TEETH" forState:UIControlStateNormal];
        [b2 setTitle:@"BABY TEETH" forState:UIControlStateNormal];
        
        [b1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [b2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        [b1 setBackgroundColor:[UIColor whiteColor]];
        [b2 setBackgroundColor:[UIColor grayColor]];


    }
    else
        {
            _bhImage.image=[UIImage imageNamed:@"visualcheck.png"];
        self.navigationItem.title = @"ORAL HEALTH";

       }

    
    
    
    [_bhImage setContentMode:UIViewContentModeScaleAspectFit];
    [_bhImage setClipsToBounds:YES];
    
    
    // Do any additional setup after loading the view.
}
-(void)btnClick:(UIButton*)b
{
    if(b==b1)
    {
        [b1 setBackgroundColor:[UIColor whiteColor]];
        [b2 setBackgroundColor:[UIColor grayColor]];

    }
    else
    {
        [b2 setBackgroundColor:[UIColor whiteColor]];
        [b1 setBackgroundColor:[UIColor grayColor]];

    }
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
