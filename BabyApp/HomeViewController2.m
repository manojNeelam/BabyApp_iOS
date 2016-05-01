//
//  HomeViewController2.m
//  BabyApp
//
//  Created by Atul Awasthi on 01/05/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "HomeViewController2.h"
#import "AppDelegate.h"
@interface HomeViewController2 ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIPageControl *pageHome;
    NSArray *titlesArray,*imagesNames,*colorArray;

}
@property (nonatomic)  UITableView *home2Table;
@property (nonatomic)  UIScrollView *home2Scorll;

@end

@implementation HomeViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imagesNames=[NSArray arrayWithObjects:@"needle_icon.png",@"screening_icon.png",@"growth_icon.png", nil];
    titlesArray=[NSArray arrayWithObjects:@"My Immunisation",@"My Screenings",@"Encyclopedia", nil];
    colorArray=[NSArray arrayWithObjects:@"D35560",@"F8C34F",@"53B8B1", nil];
    
    
    _home2Scorll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height*30)/100)];
    
    [self.view addSubview:_home2Scorll];
    
    
    _home2Table=[[UITableView alloc] initWithFrame:CGRectMake(0, _home2Scorll.frame.size.height+_home2Scorll.frame.origin.y, self.view.frame.size.width, (self.view.frame.size.height*68)/100)];
    
    [self.view addSubview:_home2Table];
    
    _home2Table.dataSource=self;
    _home2Table.delegate=self;
    [self drawViewInScrollForChildAt];
}



-(void)drawViewInScrollForChildAt
{
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    NSArray *list = [appdelegate listOfChildrens];
    int i=0;
    for( ;i<3;i++)
    {
        UIView *vv2=[[UIView alloc] initWithFrame:CGRectMake(i*self.view.frame.size.width, 0,self.view.frame.size.width, _home2Scorll.frame.size.height)];
        [vv2 setBackgroundColor:[UIColor colorWithRed:60.0/255.0 green:125.0/255.0 blue:116.0/255.0 alpha:1.0]];
        [_home2Scorll addSubview:vv2];
        
        
        
        UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50,15, 100, 100)];
        [[iv layer] setCornerRadius:iv.frame.size.height/2];
        [vv2 addSubview:iv];
        
        [[iv layer] setBorderWidth:10];
        [[iv layer] setBorderColor:[UIColor colorWithRed:35.0/255.0 green:127.0/255.0 blue:118.0/255.0 alpha:1.0].CGColor];
        UILabel *lbl1=nil,*lbl2=nil;
        
        lbl1=[[UILabel alloc] initWithFrame:CGRectMake(20,iv.frame.origin.y+iv.frame.size.height+10, vv2.frame.size.width-40, 30)];
        lbl1.tag=10;
        [vv2 addSubview:lbl1];
        
        lbl2=[[UILabel alloc] initWithFrame:CGRectMake(20,lbl1.frame.origin.y+lbl1.frame.size.height+5, vv2.frame.size.width-40, 20)];
        lbl2.tag=20;
        [vv2 addSubview:lbl2];
        
        [lbl1 setTextAlignment:NSTextAlignmentCenter];
        [lbl2 setTextAlignment:NSTextAlignmentCenter];

        [lbl1 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi"
                                            size:24]];
        [lbl1 setTextColor:[UIColor whiteColor]];

        lbl1.text=@"Margerie Tyrell";
        
        [lbl2 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15]];
        [lbl2 setTextColor:[UIColor whiteColor]];
        
        lbl2.text=@"5 months old";

        
    }
    
    [_home2Scorll setContentSize:CGSizeMake(self.view.frame.size.width*i, _home2Scorll.frame.size.height)];
    [_home2Scorll setBounces:NO];
    [_home2Scorll setPagingEnabled:YES];
    
    
    pageHome=[[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-15, _home2Scorll.frame.size.height-20, 30, 20)];
    [pageHome setNumberOfPages:3];
    [pageHome setCurrentPage:0];
    
    [self.view addSubview:pageHome];
    [self.view bringSubviewToFront:pageHome];
    

}



#pragma mark - UITableView Delegate & Datasrouce -


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return imagesNames.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        
        if(result.height > 568)
        {
            return 110;
            
        }
    }
    return 75;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Home2%ld",(long)indexPath.row]];
    
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Home2%ld",(long)indexPath.row]];
        
        
        UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(10,15, 110-30, 110-30)];
        [[iv layer] setCornerRadius:cell.frame.size.height-30/2];
        [cell.contentView addSubview:iv];
        
        UILabel *lbl1=nil,*lbl2=nil;
        
        lbl1=[[UILabel alloc] initWithFrame:CGRectMake(iv.frame.origin.x+iv.frame.size.width+20,iv.frame.origin.y+5, _home2Table.frame.size.width-90, 25)];
        lbl1.tag=10;
        [cell.contentView addSubview:lbl1];
        
        lbl2=[[UILabel alloc] initWithFrame:CGRectMake(iv.frame.origin.x+iv.frame.size.width+20,lbl1.frame.origin.y+25, _home2Table.frame.size.width-90,30)];
        lbl2.tag=20;
        [cell.contentView addSubview:lbl2];
        [lbl2 setLineBreakMode:NSLineBreakByWordWrapping];
        [lbl2 setNumberOfLines:0];
        
        iv.tag=5;
        
        
        [lbl2 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15]];
        
        [lbl2 setTextColor:[UIColor colorWithRed:143.0/255.0 green:143.0/255.0 blue:149.0/255.0 alpha:1.0]];

        
        
        
    }
    
    
    UIImageView *iv=[cell.contentView viewWithTag:5];
    UILabel *lbl1=[cell.contentView viewWithTag:10];
    UILabel *lbl2=[cell.contentView viewWithTag:20];
    
    cell.backgroundColor=[UIColor whiteColor];
    iv.image=[UIImage imageNamed:imagesNames[indexPath.row]];
    
    lbl1.text=titlesArray[indexPath.row];
    lbl1.textColor=[ self colorWithHexString:colorArray[indexPath.row]];
    if(indexPath.row!=2)
        lbl2.text=@"Click Here to Show Detail";
    else
        lbl2.text=@"Information on medicine and immunisations";
    
    
    
    
    
    /* HomeTableViewCell *cell = (HomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"homeCellIdentifier"];
     cell.backgroundColor=[UIColor whiteColor];
     cell.imageViewContent.image=[UIImage imageNamed:imagesNames[indexPath.row]];
     cell.titleLabel.text=titlesArray[indexPath.row];
     cell.titleLabel.textColor=[ self colorWithHexString:colorArray[indexPath.row]];
     
     AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
     NSArray *list = [appdelegate listOfChildrens];
     if(list.count<1)
     cell.subtitleLabel.text=@"No entry yet";
     else
     cell.subtitleLabel.text=@"Click Here to Show Detail";
     
     cell.subtitleLabel.textColor=[UIColor grayColor];
     */
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
}



- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
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
