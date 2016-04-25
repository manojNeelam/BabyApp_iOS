//
//  HomeViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "HomeViewController.h"
#import "LeftMenuViewController.h"
#import "HomeTableViewCell.h"
#import "ImmunisationsVC.h"
#import "ScreeningSummaryViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NSUserDefaults+Helpers.h"
#import "WSConstant.h"
#import "AppDelegate.h"
#import "UIImageView+JMImageCache.h"
#import "ChildDetailsData.h"
#import "AppConstent.h"

@implementation HomeViewController
{
    NSArray *titlesArray,*imagesNames,*colorArray;
}
- (IBAction)helthBookletClicked:(id)sender {
    NSLog(@"helthBookletClicked");
    [self performSegueWithIdentifier:@"healthBookletsegue" sender:self];

    //growthsummarysegu
}
- (IBAction)encyclopediaClicked:(id)sender
{
    NSLog(@"encyclopediaClicked");
    [self performSegueWithIdentifier:@"encyclopediatapscrollersegu" sender:self];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.navigationItem setTitle:@"Baby Booklet"];
    self.navigationController.navigationBarHidden=NO;
    [[_addBioButton layer] setBorderWidth:1.0f];
    [[_addBioButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    imagesNames=[NSArray arrayWithObjects:@"needle_icon.png",@"screening_icon.png",@"growth_icon.png", nil];
    titlesArray=[NSArray arrayWithObjects:@"My Immunisation",@"My Screening",@"My Growth Percentiles", nil];
    colorArray=[NSArray arrayWithObjects:@"D35560",@"F8C34F",@"53B8B1", nil];

    
    self.btnEncyclopedia.layer.borderWidth = 1.0;
    self.btnEncyclopedia.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.btnHealthbooklet.layer.borderWidth = 1.0;
    self.btnHealthbooklet.layer.borderColor = [UIColor lightGrayColor].CGColor;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BOOL isFromSignUp = [NSUserDefaults retrieveBoolForKey:IS_FROM_SIGNUP];
    if(isFromSignUp)
    {
        //
        [self performSegueWithIdentifier:@"bioDataSegue" sender:self];
        [NSUserDefaults saveBool:NO forKey:IS_FROM_SIGNUP];
    }
    else
    {
        [self loadChild];
    }
}

-(void)loadChild
{
    //
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    NSArray *list = [appdelegate listOfChildrens];
    
    NSLog(@"calling of load child at home page list=%@",list);

    if(list.count)
    {
        ChildDetailsData *child = [list objectAtIndex:0];
        [NSUserDefaults saveObject:child.child_id forKey:CURRENT_CHILD_ID];
        
        NSLog(@"child photo url at home page=%@",child.baby_image);

        [self.childPic setImageWithURL:[NSURL URLWithString:child.baby_image] placeholder:[UIImage imageNamed:@"home_kid.png"]];
     //   [self.childPic setContentMode:UIViewContentModeScaleAspectFit];
     //   [self.childPic setClipsToBounds:YES];
        
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

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return NO;
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
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 60;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
   /* HomeTableViewCell *cell = (HomeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if([cell.subtitleLabel.text isEqualToString:@"No entry yet"])
    {
        
        UIAlertView *alt=[[UIAlertView alloc] initWithTitle:(NSString*)NOENTRYTITLE message:(NSString*)NOENTRYMESSAGE delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [alt show];
        

    }
    else
    {*/
    //ImmunisationsVC_SB_ID
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    if(indexPath.row==0)
    {
        
        ImmunisationsVC *ImmunisationsVC = [mainStoryboard instantiateViewControllerWithIdentifier: @"ImmunisationsVC_SB_ID"];
        
        
        [self.navigationController pushViewController:ImmunisationsVC animated:YES];
    }
    if(indexPath.row==1)
    {
        //screeningSummaryList
        
        ScreeningSummaryViewController *summaryVC = [mainStoryboard instantiateViewControllerWithIdentifier: @"screeningSummaryList"];
        
        
        [self.navigationController pushViewController:summaryVC animated:YES];
        
    }
    else if(indexPath.row==2)
    {
        [self performSegueWithIdentifier:@"growthsummarysegu" sender:self];
    }
  //  }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    NSLog(@"alert view clicked with MESSAGE=%@ at index=%ld",[alertView message],(long)buttonIndex);
    
    if([[alertView message] isEqualToString:NOENTRYMESSAGE])
    {
        if(buttonIndex==0)
        {
            [NSUserDefaults saveBool:NO forKey:IS_FROM_SIGNUP];
            [self performSegueWithIdentifier:@"bioDataSegue" sender:self];
        }
        else
        {
            NSLog(@"Cancel clicked");
        }
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
            
            NSDictionary *responseDict = (NSDictionary *)response
            ;
            if ([responseDict[@"status"] boolValue]) {
                
                //            children
                NSArray *childrenList = responseDict[@"data"][@"children"];
                if(childrenList.count)
                {
                    NSMutableArray *temp = [NSMutableArray array];
                    
                    for(NSDictionary *dict in childrenList)
                    {
                        ChildDetailsData *child = [[ChildDetailsData alloc] initwithDictionary:dict];
                        [temp addObject:child];
                    }
                    
                    NSArray *childHolder = temp;
                    
                    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
                    [appdelegate setListOfChildrens:childHolder];
                    
                    [NSUserDefaults saveBool:NO forKey:IS_CHILD_NOT_AVAILABLE];
                    [self loadChild];
                    
                }
                else
                {
                    [NSUserDefaults saveBool:YES forKey:IS_FROM_SIGNUP];
                    [NSUserDefaults saveBool:YES forKey:IS_CHILD_NOT_AVAILABLE];
                    
                }
            }
            else{
                
            }
        });
    }
    else if([statusStr isEqualToString:@"0"])
    {
        
    }
}


-(void)failure:(id)response
{
    
}

@end
