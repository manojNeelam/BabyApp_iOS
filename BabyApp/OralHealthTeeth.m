//
//  OralHealthTeeth.m
//  BabyApp
//
//  Created by Atul Awasthi on 25/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "OralHealthTeeth.h"

@interface OralHealthTeeth ()

@end

@implementation OralHealthTeeth
@synthesize bgImage;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
 self.navigationItem.title = [@"oral health" capitalizedString];
    
 //   bgImage=[[UIImageView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
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
