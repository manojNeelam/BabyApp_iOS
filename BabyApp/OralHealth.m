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
        
        b1=[[UIButton alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width/2, 40)];
        
        b2=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2,0, self.view.frame.size.width/2, 40)];
        [self.view addSubview:b1];
        [self.view addSubview:b2];
        [b1 setTitle:@"ADULT TEETH" forState:UIControlStateNormal];
        [b2 setTitle:@"BABY TEETH" forState:UIControlStateNormal];
        
        [b1 setTitleColor:[UIColor colorWithRed:108.0/255.0 green:107.0/255.0 blue:108.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [b2 setTitleColor:[UIColor colorWithRed:108.0/255.0 green:107.0/255.0 blue:108.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [b1 setBackgroundColor:[UIColor whiteColor]];
        [b2 setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:240.0/255.0 alpha:1.0]];

        [[b1 titleLabel] setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi" size:14]];
        [[b2 titleLabel] setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi" size:14]];

        [b1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [b2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];


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
        [b2 setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:240.0/255.0 alpha:1.0]];
        _bhImage.image=[UIImage imageNamed:@"Oral health.png"];

    }
    else
    {
        [b2 setBackgroundColor:[UIColor whiteColor]];
        [b1 setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:240.0/255.0 alpha:1.0]];
        _bhImage.image=[UIImage imageNamed:@"babyTeeth.png"];

        
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
