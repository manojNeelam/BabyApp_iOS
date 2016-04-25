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

- (void)viewDidLoad {
    [super viewDidLoad];
   // _bhImage.image=[UIImage imageNamed:@"Oral health.png"];
    
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"forOral"])
    {
        _bhImage.image=[UIImage imageNamed:@"Oral health.png"];
        self.navigationItem.title = @"ORAL HEALTH";
 
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
