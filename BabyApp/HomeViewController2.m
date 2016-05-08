//
//  HomeViewController2.m
//  BabyApp
//
//  Created by Atul Awasthi on 01/05/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "HomeViewController2.h"
#import <QuartzCore/QuartzCore.h>
#import "NSUserDefaults+Helpers.h"
#import "WSConstant.h"
#import "AppDelegate.h"
#import "UIImageView+JMImageCache.h"
#import "ChildDetailsData.h"
#import "AppConstent.h"
#import "EncyclopediaTapScroller.h"
#import "ConnectionsManager.h"

@interface HomeViewController2 ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate, ServerResponseDelegate>
{
    UIPageControl *pageHome;
    NSArray *titlesArray,*imagesNames,*colorArray;
    NSArray *list;
    int selectedChildIndex;
    ChildDetailsData *child;
    
    UIView *overlayView;
    
    
}
@property (nonatomic)  UITableView *home2Table;
@property (nonatomic)  UIScrollView *home2Scorll;

@end

@implementation HomeViewController2

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / width;
    
    [pageHome setCurrentPage:page];
    child =[list objectAtIndex:pageHome.currentPage];
    [NSUserDefaults saveObject:child.child_id forKey:CURRENT_CHILD_ID];
    
    NSLog(@"current page=%ld",(long)pageHome.currentPage);

    [self.home2Table reloadData];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    overlayView=[UIView new];
    overlayView.frame=self.view.frame;
    overlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [overlayView setHidden:YES];
    [self.view addSubview:overlayView];
    
    selectedChildIndex=0;
    imagesNames=[NSArray arrayWithObjects:@"needle_icon.png",@"screening_icon2.png",@"growth_icon.png", nil];
    titlesArray=[NSArray arrayWithObjects:@"My Immunisation",@"My Screenings",@"Encyclopedia", nil];
    colorArray=[NSArray arrayWithObjects:@"D35560",@"F8C34F",@"53B8B1", nil];
    
    
    _home2Scorll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height*30)/100)];
    
    [self.view addSubview:_home2Scorll];
    
    
    [_home2Scorll setBackgroundColor:[UIColor colorWithRed:60.0/255.0 green:125.0/255.0 blue:116.0/255.0 alpha:1.0]];
    
    _home2Scorll.delegate=self;
    
    _home2Table=[[UITableView alloc] initWithFrame:CGRectMake(0, _home2Scorll.frame.size.height+_home2Scorll.frame.origin.y, self.view.frame.size.width, (self.view.frame.size.height*68)/100)];
    
    [self.view addSubview:_home2Table];
    
    _home2Table.dataSource=self;
    _home2Table.delegate=self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveUploadStateNotification:)
                                                 name:@"UploadNotification"
                                               object:nil];
    
   //  [NSUserDefaults saveBool:YES forKey:IS_FROM_SIGNUP];
   // [NSUserDefaults saveBool:YES forKey:IS_CHILD_NOT_AVAILABLE];

    
}
- (void) receiveUploadStateNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"UploadNotification"])
    {
        NSDictionary* userInfo = notification.userInfo;
        NSLog (@"Successfully received the UploadNotification! userInfo=%@",userInfo);
        int n=[[userInfo objectForKey:@"leftMenuSelection"] intValue];
        
        [_home2Scorll setContentOffset:CGPointMake(_home2Scorll.frame.size.width*n, _home2Scorll.frame.origin.y) animated:NO];
        [pageHome setCurrentPage:n];
        
        ChildDetailsData *childUser = [list objectAtIndex:pageHome.currentPage];
        [NSUserDefaults saveObject:childUser.child_id forKey:CURRENT_CHILD_ID];

        
    }
}

-(void)showAddbio
{
    

      UIViewController *vc ;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"AddBio"];
    [self.navigationController pushViewController:vc animated:YES];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    //    list = [appdelegate listOfChildrens];
    //
    //    child = [list objectAtIndex:selectedChildIndex];
    //    [NSUserDefaults saveObject:child.child_id forKey:CURRENT_CHILD_ID];
    
    [self loadChild];
    
    
}

-(void)loadChild
{
    //
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    NSArray *listChild = [appdelegate listOfChildrens];
    
    NSLog(@"calling of load child at home page list=%@",listChild);
    
    if(listChild.count)
    {
        list=listChild;
        
        child = [list objectAtIndex:0];

        [NSUserDefaults saveObject:child.child_id forKey:CURRENT_CHILD_ID];
        [self.home2Table reloadData];

        NSLog(@"child photo url at home page=%@",child.baby_image);
        
        for(UIView * v in _home2Scorll.subviews)
            [v removeFromSuperview];
        
        [self drawViewInScrollForChildAt];
    }
    else
    {
        [self getAllChildrans];
    }
    
    
    
}

-(void)getAllChildrans
{
    
    NSString *s=[[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    NSDictionary *params = @{@"user_id" : s};
    
    NSLog(@"calling of getAllChildrans at home page user id=%@ s=%@",[params objectForKey:@"user_id"],s);
    
    [[ConnectionsManager sharedManager] childrenDetails:params  withdelegate:self];
}
-(void)btnTap:(UIButton*)bt
{
    int tapedShild=(int)bt.tag-200;
    
    ChildDetailsData *childUser = [list objectAtIndex:tapedShild];
    [NSUserDefaults saveObject:childUser.child_id forKey:CURRENT_CHILD_ID];
    
    
    NSLog(@"btnTap tag=%ld tapedShild postion=%d selected child id=%@",(long)bt.tag,tapedShild,childUser.child_id);
    [self performSelector:@selector(showAddbio) withObject:nil afterDelay:0.5];

   // [NSUserDefaults saveObject:@"-1" forKey:CURRENT_CHILD_ID];

}
-(void)drawViewInScrollForChildAt
{
    int i=0;
    for( ;i<list.count;i++)
    {
        ChildDetailsData *childUser = [list objectAtIndex:i];

        UIView *vv2=[[UIView alloc] initWithFrame:CGRectMake(i*self.view.frame.size.width, 0,self.view.frame.size.width, _home2Scorll.frame.size.height)];
        [vv2 setBackgroundColor:[UIColor colorWithRed:60.0/255.0 green:125.0/255.0 blue:116.0/255.0 alpha:1.0]];
        [_home2Scorll addSubview:vv2];
        
        
        UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50,10, 120, 120)];
        [[iv layer] setCornerRadius:iv.frame.size.height/2];
        [iv setClipsToBounds:YES];
        [vv2 addSubview:iv];
        iv.tag=100+i;
        [[iv layer] setBorderWidth:15];
        [[iv layer] setBorderColor:[UIColor colorWithRed:35.0/255.0 green:127.0/255.0 blue:118.0/255.0 alpha:1.0].CGColor];
        
        
        UIButton *bt=[[UIButton alloc] initWithFrame:iv.frame];
        [bt addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        [vv2 addSubview:bt];
        
        bt.tag=200+i;
        
        UILabel *lbl1=nil,*lbl2=nil;
        
        lbl1=[[UILabel alloc] initWithFrame:CGRectMake(20,iv.frame.origin.y+iv.frame.size.height, vv2.frame.size.width-40, 30)];
        lbl1.tag=10;
        [vv2 addSubview:lbl1];
        
        lbl2=[[UILabel alloc] initWithFrame:CGRectMake(20,lbl1.frame.origin.y+lbl1.frame.size.height, vv2.frame.size.width-40, 20)];
        lbl2.tag=20;
        [vv2 addSubview:lbl2];
        
        [lbl1 setTextAlignment:NSTextAlignmentCenter];
        [lbl2 setTextAlignment:NSTextAlignmentCenter];
        [lbl1 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi"
                                      size:24]];
        
        [lbl1 setTextColor:[UIColor whiteColor]];
        //lbl1.text=@"Margerie Tyrell";
        lbl1.text=childUser.name;
        
        [lbl2 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15]];
        [lbl2 setTextColor:[UIColor whiteColor]];
         lbl2.text=@"5 months old";

        [iv setImageWithURL:[NSURL URLWithString:childUser.baby_image] placeholder:[UIImage imageNamed:@"home_kid.png"]];
        
        vv2.tag=2000+i;
        
    }
    
    [_home2Scorll setContentSize:CGSizeMake(self.view.frame.size.width*i, _home2Scorll.frame.size.height)];
    [_home2Scorll setBounces:NO];
    [_home2Scorll setPagingEnabled:YES];
    
    
    pageHome=[[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-15, _home2Scorll.frame.size.height-20, 30, 20)];
    [pageHome setNumberOfPages:list.count];
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
        
        [lbl1 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi"
                                      size:15]];
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
    
    
    
    
    /*
     HomeTableViewCell *cell = (HomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"homeCellIdentifier"];
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
    
    if(indexPath.row == 0)
    {
        [self immunisationView];
    }
    else if (indexPath.row == 1)
    {
        [self screeningView];
    }
    
    
    if(indexPath.row==2)
    {
        [self encyclopediaView];

    }
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

-(void)immunisationView
{
    [[overlayView subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    [self.view bringSubviewToFront:overlayView];
    [overlayView setHidden:NO];
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setBackgroundImage:[UIImage imageNamed:@"immunisation-floting-middle.png"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(10, _home2Scorll.frame.origin.y + _home2Scorll.frame.size.height + 15, 80, 80);
    
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:backButton];
    
    UIButton *drugButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [drugButton setBackgroundImage:[UIImage imageNamed:@"immunisation-floting-new.png"] forState:UIControlStateNormal];
    drugButton.frame=CGRectMake(backButton.frame.origin.x+10, backButton.frame.origin.y-70, 50, 50);
    [drugButton addTarget:self action:@selector(newImmuAction) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:drugButton];
    
    UILabel *drugLabel =[[UILabel alloc]initWithFrame:CGRectMake(drugButton.frame.origin.x+50+10, drugButton.frame.origin.y, 200, 50)];
    drugLabel.text=@"Enter New Immunisation";
    drugLabel.textAlignment=NSTextAlignmentLeft;
    drugLabel.textColor=[UIColor whiteColor];
    [overlayView addSubview:drugLabel];
    
    
   
    UIButton *medicalButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    NSString *immuStr = @"View My Immunisation";
     [medicalButton setBackgroundImage:[UIImage imageNamed:@"immunisation-floting-summar.png"] forState:UIControlStateNormal];
    if(!child.immunisationList.count)
    {
        immuStr = @"View My Immunisation \n(no summary yet)";
        [medicalButton setBackgroundImage:[UIImage imageNamed:@"immunisation-floting-nosummar.png"] forState:UIControlStateNormal];
    }
    
   
    medicalButton.frame=CGRectMake(backButton.frame.origin.x+10, backButton.frame.origin.y+100+10, 50, 50);
    [medicalButton addTarget:self action:@selector(immuMy) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:medicalButton];
    
    
    UILabel *medicalLabel =[[UILabel alloc]initWithFrame:CGRectMake(medicalButton.frame.origin.x+50+10, medicalButton.frame.origin.y, 200, 50)];
    medicalLabel.text=immuStr;
    medicalLabel.numberOfLines=2;
    medicalLabel.textAlignment=NSTextAlignmentLeft;
    medicalLabel.textColor=[UIColor whiteColor];
    [overlayView addSubview:medicalLabel];
    
   //
   
    
    UIButton *medicalButton2 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [medicalButton2 setBackgroundImage:[UIImage imageNamed:@"immunisation-floting-summar.png"] forState:UIControlStateNormal];
    
    NSString *immuStr2 = @"Immunisation Information";
    
    if(!child.immunisationList.count)
    {
        immuStr2 = @"Immunisation Information \n(no summary yet)";
        [medicalButton2 setBackgroundImage:[UIImage imageNamed:@"immunisation-floting-nosummar.png"] forState:UIControlStateNormal];
    }

    
    medicalButton2.frame=CGRectMake(backButton.frame.origin.x+10, medicalButton.frame.origin.y+100+10, 50, 50);
    [medicalButton2 addTarget:self action:@selector(immuInfoAction) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:medicalButton2];
    
    
    UILabel *medicalLabel2 =[[UILabel alloc]initWithFrame:CGRectMake(medicalButton2.frame.origin.x+50+10, medicalButton2.frame.origin.y, 200, 50)];
    medicalLabel2.text=immuStr2;
    medicalLabel2.numberOfLines=2;
    medicalLabel2.textAlignment=NSTextAlignmentLeft;
    medicalLabel2.textColor=[UIColor whiteColor];
    [overlayView addSubview:medicalLabel2];
    [medicalLabel2 setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];

    //
    
    
    
    [drugLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    [medicalLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];

    
}

-(void)screeningView
{
    
    NSLog(@"in screeningView");
    [[overlayView subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    float heightView = 75;
    
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(result.height > 568)
    {
        heightView = 110;

    }
    
    [self.view bringSubviewToFront:overlayView];
    [overlayView setHidden:NO];
    
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setBackgroundImage:[UIImage imageNamed:@"middle-screening.png"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(10, _home2Scorll.frame.origin.y + _home2Scorll.frame.size.height + heightView +15, 80, 80);
    
    [backButton addTarget:self action:@selector(backScreeningAction) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:backButton];
    
    UIButton *drugButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [drugButton setBackgroundImage:[UIImage imageNamed:@"screening-floting-new.png"] forState:UIControlStateNormal];
    drugButton.frame=CGRectMake(backButton.frame.origin.x+10, backButton.frame.origin.y-(heightView-30), 50, 50);
    [drugButton addTarget:self action:@selector(newScreeningAction) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:drugButton];
    
    UILabel *drugLabel =[[UILabel alloc]initWithFrame:CGRectMake(drugButton.frame.origin.x+50+20, drugButton.frame.origin.y, 150, 50)];
    drugLabel.text=@"New Screening";
    drugLabel.textAlignment=NSTextAlignmentLeft;
    drugLabel.textColor=[UIColor whiteColor];
    [overlayView addSubview:drugLabel];
    
    //
    
    NSString *immuStr = @"View My Screening";
    
    if(!child.screeningList.count)
    {
        immuStr = @"View My Screening \n(no summary yet)";
    }

    UIButton *drugButton2 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [drugButton2 setBackgroundImage:[UIImage imageNamed:@"screening-floting-summary.png"] forState:UIControlStateNormal];
    drugButton2.frame=CGRectMake(backButton.frame.origin.x+10, drugButton.frame.origin.y-(heightView-30), 50, 50);
    [drugButton2 addTarget:self action:@selector(myScreeningAction) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:drugButton2];
    
    UILabel *drugLabel2 =[[UILabel alloc]initWithFrame:CGRectMake(drugButton2.frame.origin.x+50+20, drugButton2.frame.origin.y, 200, 50)];
    drugLabel2.text=immuStr;
    drugLabel2.textAlignment=NSTextAlignmentLeft;
    drugLabel2.textColor=[UIColor whiteColor];
    [overlayView addSubview:drugLabel2];

    [drugLabel2 setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];

    //
    
    NSString *immuSt = @"Percentile Information";
    
    if(!child.immunisationList.count)
    {
        immuSt = @"Percentile Information \n(no Percentile yet)";
    }
    
    
    
  
    
    UIButton *medicalButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [medicalButton setBackgroundImage:[UIImage imageNamed:@"screening-floting-nosummary.png"] forState:UIControlStateNormal];
    medicalButton.frame=CGRectMake(backButton.frame.origin.x+10, backButton.frame.origin.y+100, 50, 50);
    [medicalButton addTarget:self action:@selector(percentileScreening) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:medicalButton];
    
    
    UILabel *medicalLabel =[[UILabel alloc]initWithFrame:CGRectMake(medicalButton.frame.origin.x+50+20, medicalButton.frame.origin.y, 150, 50)];
    medicalLabel.text=immuSt;
    medicalLabel.numberOfLines=2;
    medicalLabel.textAlignment=NSTextAlignmentLeft;
    medicalLabel.textColor=[UIColor whiteColor];
    [overlayView addSubview:medicalLabel];
    
    
    //
    
    NSString *immuStr2 = @"Visual Screening";
    
    if(!child.screeningList.count)
    {
        immuStr2 = @"Visual Screening \n(no Visual Screening yet)";
    }

    
   
    UIButton *medicalButton2 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [medicalButton2 setBackgroundImage:[UIImage imageNamed:@"hb_visual_option.png"] forState:UIControlStateNormal];
    medicalButton2.frame=CGRectMake(backButton.frame.origin.x+10, medicalButton.frame.origin.y+60, 50, 50);
    [medicalButton2 addTarget:self action:@selector(dentalScreeningAction) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:medicalButton2];
    
    
    UILabel *medicalLabel2 =[[UILabel alloc]initWithFrame:CGRectMake(medicalButton2.frame.origin.x+50+10, medicalButton2.frame.origin.y, 200, 50)];
    medicalLabel2.text=immuStr2;
    medicalLabel2.numberOfLines=2;
    medicalLabel2.textAlignment=NSTextAlignmentLeft;
    medicalLabel2.textColor=[UIColor whiteColor];
    [overlayView addSubview:medicalLabel2];
    [medicalLabel2 setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    
    
    
   immuStr2 = @" Dental Screening";
    
    if(!child.screeningList.count)
    {
        immuStr2 = @"Dental Screening \n(no  Dental Screening yet)";
    }
    
    
    
    
    UIButton *medicalButton3 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [medicalButton3 setBackgroundImage:[UIImage imageNamed:@"hb_teeth.png"] forState:UIControlStateNormal];
    medicalButton3.frame=CGRectMake(backButton.frame.origin.x+10, medicalButton2.frame.origin.y+60, 50, 50);
    [medicalButton3 addTarget:self action:@selector(dentalScreeningAction) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:medicalButton3];
    
    
    UILabel *medicalLabel3 =[[UILabel alloc]initWithFrame:CGRectMake(medicalButton2.frame.origin.x+50+10, medicalButton3.frame.origin.y, 200, 50)];
    medicalLabel3.text=immuStr2;
    medicalLabel3.numberOfLines=2;
    medicalLabel3.textAlignment=NSTextAlignmentLeft;
    medicalLabel3.textColor=[UIColor whiteColor];
    [overlayView addSubview:medicalLabel3];
    [medicalLabel3 setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    

    
    
    
    
    
    //
    
    
    
    [drugLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    [medicalLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    
}

//
-(void)encyclopediaView
{
    
    [[overlayView subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    float heightView = 150;
    
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(result.height > 568)
    {
        heightView = 220;
    }
    
    [self.view bringSubviewToFront:overlayView];
    [overlayView setHidden:NO];
    
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setBackgroundImage:[UIImage imageNamed:@"encyclopedia-floting-bottom.png"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(10, _home2Scorll.frame.origin.y + _home2Scorll.frame.size.height + heightView +15, 80, 80);
    
    [backButton addTarget:self action:@selector(backScreeningAction) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:backButton];
    //
    UIButton *drugButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [drugButton setBackgroundImage:[UIImage imageNamed:@"encyclopedia-floting-medication.png"] forState:UIControlStateNormal];
    drugButton.frame=CGRectMake(backButton.frame.origin.x+10, backButton.frame.origin.y-70, 50, 50);
    [drugButton addTarget:self action:@selector(encyclopediaMedication) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:drugButton];
    
    UILabel *drugLabel =[[UILabel alloc]initWithFrame:CGRectMake(drugButton.frame.origin.x+50+20, drugButton.frame.origin.y, 150, 50)];
    drugLabel.text=@"Medication";
    drugLabel.textAlignment=NSTextAlignmentLeft;
    drugLabel.textColor=[UIColor whiteColor];
    [overlayView addSubview:drugLabel];
    
    
    
    //
    
    NSString *immuStr = @"Immunisation";
    
   
    UIButton *drugButton2 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [drugButton2 setBackgroundImage:[UIImage imageNamed:@"encyclopedia-floting-immu.png"] forState:UIControlStateNormal];
    drugButton2.frame=CGRectMake(backButton.frame.origin.x+10, drugButton.frame.origin.y-110, 50, 50);
    [drugButton2 addTarget:self action:@selector(encyclopediaImmunisation) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:drugButton2];
    
    UILabel *drugLabel2 =[[UILabel alloc]initWithFrame:CGRectMake(drugButton2.frame.origin.x+50+20, drugButton2.frame.origin.y, 200, 50)];
    drugLabel2.text=immuStr;
    drugLabel2.textAlignment=NSTextAlignmentLeft;
    drugLabel2.textColor=[UIColor whiteColor];
    [overlayView addSubview:drugLabel2];
    
    [drugLabel2 setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    
    
    
    
    immuStr = @"Child Safety Checklist";
    
    
    UIButton *drugButton3 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [drugButton3 setBackgroundImage:[UIImage imageNamed:@"hb_Alergy_option.png"] forState:UIControlStateNormal];
    drugButton3.frame=CGRectMake(backButton.frame.origin.x+10, drugButton2.frame.origin.y-100, 50, 50);
    [drugButton3 addTarget:self action:@selector(encyclopediaChildSafety) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:drugButton3];
    
    UILabel *drugLabel3 =[[UILabel alloc]initWithFrame:CGRectMake(drugButton3.frame.origin.x+50+20, drugButton3.frame.origin.y, 200, 50)];
    drugLabel3.text=immuStr;
    drugLabel3.textAlignment=NSTextAlignmentLeft;
    drugLabel3.textColor=[UIColor whiteColor];
    [overlayView addSubview:drugLabel3];
    [drugLabel3 setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    
    
    //

    
    
    
    
    NSString *immuSt = @"Developmental Assesment";
    
    UIButton *medicalButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [medicalButton setBackgroundImage:[UIImage imageNamed:@"hb_medical_option.png"] forState:UIControlStateNormal];
    medicalButton.frame=CGRectMake(backButton.frame.origin.x+10, backButton.frame.origin.y+100, 50, 50);
    [medicalButton addTarget:self action:@selector(encyclopediaDevelopmental) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:medicalButton];
    
    
    UILabel *medicalLabel =[[UILabel alloc]initWithFrame:CGRectMake(medicalButton.frame.origin.x+50+20, medicalButton.frame.origin.y, 200, 50)];
    medicalLabel.text=immuSt;
    medicalLabel.numberOfLines=2;
    medicalLabel.textAlignment=NSTextAlignmentLeft;
    medicalLabel.textColor=[UIColor whiteColor];
    [overlayView addSubview:medicalLabel];
    
    [drugLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    [medicalLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    
}

-(void)encyclopediaMedication
{
    [overlayView setHidden:YES];

    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"scrollAt"];

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
     bundle: nil];
     
     EncyclopediaTapScroller *ImmunisationsVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"EncyclopediaStoryBoard"];
     [self.navigationController pushViewController:ImmunisationsVC animated:YES];

}
-(void)encyclopediaImmunisation
{
    [overlayView setHidden:YES];

    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"scrollAt"];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
     bundle: nil];
     
     EncyclopediaTapScroller *ImmunisationsVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"EncyclopediaStoryBoard"];
     [self.navigationController pushViewController:ImmunisationsVC animated:YES];

}

-(void)encyclopediaDevelopmental
{
    [overlayView setHidden:YES];
    
    UIViewController *dummyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DevelopmetalScreenViewController"];
    [self.navigationController pushViewController:dummyVC animated:YES];
    
    
}

-(void)encyclopediaChildSafety
{
    [overlayView setHidden:YES];
    
    UIViewController *dummyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"childSafety"];
    [self.navigationController pushViewController:dummyVC animated:YES];
    
    
}



//

-(void)backAction
{
    [overlayView setHidden:YES];
}


-(void)newImmuAction
{
    [overlayView setHidden:YES];
    
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier: @"NewImmunisationVC_SB_ID"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)immuInfoAction //correct*
{
    [overlayView setHidden:YES];
    if(child.immunisationList.count)
    {
        
        UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier: @"Immunisation"];
        [self.navigationController pushViewController:vc animated:YES];
        }
}
-(void)immuMy//correct*
{
    [overlayView setHidden:YES];
    if(child.immunisationList.count)
    {
        
        
          UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier: @"ImmunisationsVC_SB_ID"];
        [self.navigationController pushViewController:vc animated:YES];
        
        }
}



-(void)backScreeningAction
{
    [overlayView setHidden:YES];
}

-(void)dentalScreeningAction//correct*
{
    [overlayView setHidden:YES];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"forOral"];
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier: @"oralHealth"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)newScreeningAction  //correct*
{
    [overlayView setHidden:YES];
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier: @"Screening"];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)myScreeningAction  //correct*
{
    [overlayView setHidden:YES];
    
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier: @"screeningSummaryList"];
    [self.navigationController pushViewController:vc animated:YES];

   
}
-(void)percentileScreening//correct*
{
    [overlayView setHidden:YES];
    
    
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Growth"];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)screeningSummaryAction
{
    [overlayView setHidden:YES];
    if(child.immunisationList.count)
    {
        
        UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier: @"ImmunisationsVC_SB_ID"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}




#pragma mark - IBActions -

-(void)success:(id)response
{
    
    /*
     {
     message = "Your new password has been sent to you email";
     status = 1;
     }
     */
    
    NSDictionary *params;
    
    if([response isKindOfClass:[NSString class]])
    {
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        params = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    }
    else if ([response isKindOfClass:[NSDictionary class]])
    {
        params = response;
    }
    
    id statusStr_ = [params objectForKey:@"status"];
    NSString *statusStr;
    
    if([statusStr_ isKindOfClass:[NSNumber class]])
    {
        statusStr = [statusStr_ stringValue];
    }
    else
        statusStr = statusStr_;
    
    if([statusStr isEqualToString:@"1"])
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        NSDictionary *responseDict = (NSDictionary *)response;
            if ([responseDict[@"status"] boolValue])
            {
                
                //    children
                NSArray *childrenList = responseDict[@"data"][@"children"];
                if(childrenList.count)
                {
                    NSMutableArray *temp = [NSMutableArray array];
                    
                    for(NSDictionary *dict in childrenList)
                    {
                        ChildDetailsData *child1 = [[ChildDetailsData alloc] initwithDictionary:dict];
                        [temp addObject:child1];
                    }
                    
                    NSArray *childHolder = temp;
                    
                    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
                    [appdelegate setListOfChildrens:childHolder];
                    
                    [NSUserDefaults saveBool:NO forKey:IS_CHILD_NOT_AVAILABLE];
                    list=[appdelegate listOfChildrens];

                    NSLog(@"in chuld List api result at homepage2 =%@ ",list);

                    [self loadChild];

                }
                else
                {
                    [NSUserDefaults saveBool:YES forKey:IS_FROM_SIGNUP];
                    [NSUserDefaults saveBool:YES forKey:IS_CHILD_NOT_AVAILABLE];
                    if(list.count==0)
                    {
                        [NSUserDefaults saveObject:@"-1" forKey:CURRENT_CHILD_ID];

                        NSLog(@"in else at home from with no child childrenList=%@",childrenList);
                        [self performSelector:@selector(showAddbio) withObject:nil afterDelay:0.2];
                        
                    }

                    
                }
                

            }
            else{
                
            }
        });
    }
    else if([statusStr isEqualToString:@"0"])
    {
        
        if(list.count==0)
        {
            
            [NSUserDefaults saveObject:@"-1" forKey:CURRENT_CHILD_ID];

            NSLog(@"at home from with no child status is 0");
            [self performSelector:@selector(showAddbio) withObject:nil afterDelay:0.2];
            
        }

    }
    
  
}

-(void)failure:(id)response
{
    
}

@end
