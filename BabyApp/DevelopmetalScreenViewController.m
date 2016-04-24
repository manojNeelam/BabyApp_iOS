//
//  DevelopmetalScreenViewController.m
//  BabyApp
//
//  Created by Sandeep Dave on 24/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "DevelopmetalScreenViewController.h"
#import "DevelopmentalCell.h"

@interface DevelopmetalScreenViewController ()

@end

@implementation DevelopmetalScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Child Developmental Screening";
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DevelopmentalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"developmentalSelectedCell"];
    if(cell==nil)
    {
        cell=[[DevelopmentalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"developmentalSelectedCell"];
        
        
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.containerView.layer.cornerRadius = 5.0;
    cell.containerView.layer.masksToBounds = YES;
    cell.imgSelected.layer.borderColor = [UIColor redColor].CGColor;
    cell.imgSelected.layer.borderWidth = 2.0;
    cell.imgSelected.layer.masksToBounds = YES;
    if (indexPath.row == 0) {
        
        cell.headerView.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:192.0/255.0 blue:180.0/255.0 alpha:1.0];
       cell.imgSelected.hidden = NO;
        return cell;
    }
    else
    {
        
    cell.headerView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0];
        cell.imgSelected.hidden = YES;
        
        return cell;
    }
    
   
    
    
    
}



@end
