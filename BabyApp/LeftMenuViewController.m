//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"

#import "NSUserDefaults+Helpers.h"
#import "AppDelegate.h"

#import "HeartTypeTableViewCell.h"
#import "ProfileTableViewCell.h"

#import "UIImageView+JMImageCache.h"

#import "ConnectionsManager.h"
#import "Constants.h"
#import "WSConstant.h"
#import "ChildDetailsData.h"

@interface LeftMenuViewController()<ServerResponseDelegate>
{
    NSArray *section1Array,*section2Array,*section3Array;
    NSInteger noofSections;
    BOOL dropdownSelected;
    NSArray *childransArray;
    
}

@end

@implementation LeftMenuViewController
#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.slideOutAnimationEnabled = YES;
    
    return [super initWithCoder:aDecoder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    noofSections = 4;
    dropdownSelected=NO;
    //@"Baby Booklet"
    section1Array=[NSArray arrayWithObjects:@"New Immunisation",@"New Screening", nil];
   // section2Array=[NSArray arrayWithObjects:@"My Immunisation",@"My Screening",@"My Growth Percentiles",@"Health Book",@"Encyclopedia", nil];
    
   //  section2Array=[NSArray arrayWithObjects:@"My Growth Percentiles",@"Health Book",@"Bio Data",@"Support (FAQ)",@"About (Disclaimer)", nil];
   
    section2Array=[NSArray arrayWithObjects:@"My Growth Percentiles",@"Bio Data",@"Support (FAQ)",@"About (Disclaimer)", nil];

    
    section3Array=[NSArray arrayWithObjects:@"Settings",@"Sign Out", nil];
    
    
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftMenu.jpg"]];
    self.tableView.backgroundView = imageView;
    [self getAllChildrans];
}

#pragma mark - UITableView Delegate & Datasrouce -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return noofSections;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"";
            break;
        case 1:
            sectionName = @"";
            break;
        case 2:
            sectionName = @"MAIN MENU";
            break;
            
        case 3:
            sectionName=  @"";
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (dropdownSelected)
    {
        if(childransArray && childransArray.count)
        {
            return [childransArray count] +1;
        }
        else
        {
            return 2;
        }
        
    }
    else{
        
        switch (section)
        {
            case 0:
                return 1;
                break;
                
            case 1:
                //return section1Array.count;
                return 0;
                break;
            case 2:
                return section2Array.count;
                break;
                
            case 3:
                return section3Array.count;
                break;
                
                //        case 3:
                //            return section3Array.count;
                //            break;
        }
    }
    return 4;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"profileIdentifier";
    ProfileTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    HeartTypeTableViewCell*cell2=nil;
    cell1.babyPic.layer.cornerRadius = cell1.babyPic.frame.size.width/2;
    [cell1.babyPic setClipsToBounds:YES];
    
    
    if (dropdownSelected) {
        
        
        
        
        if(childransArray && childransArray.count)
        {
//            if (indexPath.row==0) {
//                
//                
//                
//                [cell1.babyPic setHidden:NO];
//                
//                //delegate.ch
//                cell1.babyNameLabel.text=[NSUserDefaults retrieveObjectForKey:USER_NAME];
//                return cell1;
//            }
//            
//            else
         
            if(indexPath.row == childransArray.count)
            {
                //cell1=[tableView dequeueReusableCellWithIdentifier:@"profileIdentifier"];
                
                [cell1.babyNameLabel setTextColor:[UIColor whiteColor]];
                cell1.babyNameLabel.text=@"Add New Baby";
                [cell1.babyPic setHidden:YES];
                cell1.dropdown.hidden=YES;
                return cell1;
            }
            else
            {
                NSDictionary *childrenDict = childransArray[indexPath.row];
                //cell1=[tableView dequeueReusableCellWithIdentifier:@"profileIdentifier"];
                
                [cell1.babyPic setHidden:NO];
                
                cell1.babyNameLabel.text=childrenDict[@"name"];
                [cell1.babyPic setImageWithURL:[NSURL URLWithString:[childrenDict objectForKey:@"baby_image"]] placeholder:[UIImage imageNamed:@"e1.png"]];
                if (indexPath.row == 0) {
                    cell1.dropdown.hidden = NO;
                }
                else
                {
                    cell1.dropdown.hidden = YES;
                }
                
                return cell1;
            }

        }
        else
        {
            if (indexPath.row==0) {
                
                
                NSDictionary *childrenDict = childransArray[indexPath.row];
                //cell1=[tableView dequeueReusableCellWithIdentifier:@"profileIdentifier"];
                
                [cell1.babyPic setHidden:NO];
                
                cell1.babyNameLabel.text=childrenDict[@"name"];
                [cell1.babyPic setImageWithURL:[NSURL URLWithString:[childrenDict objectForKey:@"baby_image"]] placeholder:[UIImage imageNamed:@"e1.png"]];
               
                cell1.dropdown.hidden = NO;
                
                
//                [cell1.babyPic setHidden:NO];
//                //delegate.ch
//                cell1.babyNameLabel.text=[NSUserDefaults retrieveObjectForKey:USER_NAME];
                return cell1;
            }
            else
            {
                //cell1=[tableView dequeueReusableCellWithIdentifier:@"profileIdentifier"];
                
                [cell1.babyNameLabel setTextColor:[UIColor whiteColor]];
                cell1.babyNameLabel.text=@"Add New Baby";
                [cell1.babyPic setHidden:YES];
                cell1.dropdown.hidden=YES;
                return cell1;
            }
        }
    }
    else{
        NSDictionary *childrenDict;
        switch (indexPath.section)
        {
            case 0:
                
                
                
                childrenDict = childransArray[0];
                //cell1=[tableView dequeueReusableCellWithIdentifier:@"profileIdentifier"];
                
                [cell1.babyPic setHidden:NO];
                
                cell1.babyNameLabel.text=childrenDict[@"name"];
                [cell1.babyPic setImageWithURL:[NSURL URLWithString:[childrenDict objectForKey:@"baby_image"]] placeholder:[UIImage imageNamed:@"e1.png"]];
                cell1.dropdown.hidden=NO;

                
//                //cell1=[tableView dequeueReusableCellWithIdentifier:@"profileIdentifier"];
//                cell1.babyPic.layer.cornerRadius = cell1.babyPic.frame.size.width/2;
//                [cell1.babyPic setClipsToBounds:YES];
//                
//                cell1.babyNameLabel.text=[NSUserDefaults retrieveObjectForKey:USER_NAME];
//                cell1.babyPic.image = [UIImage imageNamed:@"e1.png"];
                
                
                
                //                cell1.babyPic.layer.cornerRadius = cell1.babyPic.frame.size.width/2;
                //                cell1.babyPic.layer.masksToBounds = YES;
                //                cell1.babyPic.contentMode = UIViewContentModeScaleAspectFill;
                return cell1;
                break;
                
            case 1:
                cell2 = (HeartTypeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"heartTypeIdentifier"];
                cell2.contentNameLabel.text = section1Array[indexPath.row];
                if (indexPath.row== 0) {
                    [cell2.imageButton setBackgroundImage:[UIImage imageNamed:@"newScreening.png"] forState:UIControlStateNormal];
                    
                }
                if (indexPath.row== 1) {
                    [cell2.imageButton setBackgroundImage:[UIImage imageNamed:@"newScreening.png"] forState:UIControlStateNormal];
                    
                }
                return cell2;
                break;
                
            case 2:
                cell2 = (HeartTypeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"heartTypeIdentifier"];
                cell2.contentNameLabel.text = section2Array[indexPath.row];
                if (indexPath.row== 0) {
                    [cell2.imageButton setBackgroundImage:[UIImage imageNamed:@"myGrowth.png"] forState:UIControlStateNormal];

                   
                    
                }
                if (indexPath.row== 1) {
                    [cell2.imageButton setBackgroundImage:[UIImage imageNamed:@"healthBookletnew.png"] forState:UIControlStateNormal];
                  
                    
                }
               /* if (indexPath.row== 2)
                {
                    
                    // [cell2.imageButton setBackgroundImage:[UIImage imageNamed:@"myImmunisattion.png"] forState:UIControlStateNormal];
                    [cell2.imageButton setBackgroundImage:[UIImage imageNamed:@"healthBookletnew.png"] forState:UIControlStateNormal];
                    
                }*/
                if (indexPath.row== 2)//3
                {
                    // [cell2.imageButton setBackgroundImage:[UIImage imageNamed:@"myScreening.png"] forState:UIControlStateNormal];
                    [cell2.imageButton setBackgroundImage:[UIImage imageNamed:@"Support Icon1.png"] forState:UIControlStateNormal];
                    
                }
                if (indexPath.row== 3)//4
                {
                    [cell2.imageButton setBackgroundImage:[UIImage imageNamed:@"About Disclaimer.png"] forState:UIControlStateNormal];
                   //[cell2.imageButton setBackgroundImage:[UIImage imageNamed:@"Encyclopedianew.png"] forState:UIControlStateNormal];
                    
                }
                
                
                return cell2;
                break;
                
            case 3:
                cell2 = (HeartTypeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"heartTypeIdentifier"];
                cell2.contentNameLabel.text = section3Array[indexPath.row];
                if (indexPath.row== 0) {
                    [cell2.imageButton setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
                    
                }
                else
                {
                    [cell2.imageButton setBackgroundImage:[UIImage imageNamed:@"Signout.png"] forState:UIControlStateNormal];
                    
                }
                return cell2;
                break;
                
                //            case 3:
                //                cell2 = (HeartTypeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"heartTypeIdentifier"];
                //                cell2.contentNameLabel.text = section3Array[indexPath.row];
                //                return cell2;
                break;
        }
    }
    
    
    cell1.backgroundColor = [UIColor whiteColor];
    
    return cell1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    UIViewController *vc ;
    
    if (indexPath.section == 0) {
        
        
        
    
            if(childransArray && childransArray.count)
            {
                if (indexPath.row==0) {
                    
                    if (indexPath.row==0 ) {
                        
                        
                        if (dropdownSelected) {
                            dropdownSelected=NO;
                            noofSections=4;
                        }
                        else
                        {
                            noofSections=1;
                            dropdownSelected=YES;
                        }
                        [self.tableView reloadData];
                    }
                }
                else if(indexPath.row == childransArray.count)
                {
                    //addbio
                    
                    
                    [NSUserDefaults saveObject:@"-2" forKey:CURRENT_CHILD_ID];
                    
                    NSString *childID = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
                    
                    NSLog(@"Left Menu childID=%@",childID);
                    
                    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"AddBio"];
                    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
                    
                    
                    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                     andCompletion:nil];

                }
                else
                {
                    //perticular child
                    
                    dropdownSelected=NO;
                    noofSections=4;
                    [self.tableView reloadData];
                    
                    NSDictionary *childrenDict = childransArray[indexPath.row];

                    
                    NSLog(@"open home page childrenDict=%@",childrenDict);
                    
                  //  vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
                    
                    NSDictionary *d=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)indexPath.row],@"leftMenuSelection", nil ];
                     vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeController2"];
                    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
                    
                    
                    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                     andCompletion:nil];
                    
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"UploadNotification" object:self userInfo:d];
                }
                
            }
            else
            {
                if (indexPath.row==0)
                {
                    
                    if (dropdownSelected) {
                        dropdownSelected=NO;
                        noofSections=4;
                    }
                    else
                    {
                        noofSections=1;
                        dropdownSelected=YES;
                    }
                    [self.tableView reloadData];
                }
                else
                {
                    //addbio
                    
                    

                    

                    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"AddBio"];
                    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
                    
                  
                    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                     andCompletion:nil];

                    
                }
            }
       
        
        
        
        
        
        
        
        
//        if (indexPath.row==0 ) {
//            
//            
//            if (dropdownSelected) {
//                dropdownSelected=NO;
//                noofSections=4;
//            }
//            else
//            {
//                noofSections=1;
//                dropdownSelected=YES;
//            }
//            [self.tableView reloadData];
//        }
//        else
//        {
//            dropdownSelected=NO;
//            noofSections=4;
//            [self.tableView reloadData];
//            
//            NSLog(@"open home page");
//            
//            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
//            [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
//            
//            
//            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
//                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
//                                                                             andCompletion:nil];
//        }
    }
    else if (!dropdownSelected) {
        
        
        
        
        
        if (indexPath.section==1) {
            
            
            switch (indexPath.row)
            {
                    //                case 0:
                    //                    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
                    //                    break;
                    //
                case 0:
                    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"NewImmunisationVC_SB_ID"];
                    break;
                    
                case 1:
                    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"Screening"];
                    break;
                    
            }
        }
        
        else if (indexPath.section==2) {
            
            
            switch (indexPath.row)
            {
                case 0:
                     vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"Growth"];
                    
                    break;
                    
              /*  case 1:
                     vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"Health"];
                    
                    break;*/
                    
                case 1:  //1
                  //vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"Immunisation"];
                      vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"AddBio"];
                    break;
                    
                case 2:     //3
                     vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"SupportViewController_SB_ID"];
                    
                   // vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"Screening"];
                    break;
                case 3:       //4
                  vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"AboutViewController_SB_ID"];
                   // vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"EncyclopediaStoryBoard"];
                    break;
            }
        }
        else if (indexPath.section==3)
        {
            if (indexPath.row==0) {
                vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"SettingsViewController_SB_ID"];
            }
            else
            {
                
                
                UIAlertView *alt=[[UIAlertView alloc] initWithTitle:@"Are you sure?"  message:@"You want to Log out?"  delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
                [alt show];
                
               
                
                
                //[[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:NO];
                return;
                
            }
            
            
            
        }
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
        
        
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                         andCompletion:nil];
        
    }
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //
    NSLog(@"alert view clicked with MESSAGE=%@ at index=%ld",[alertView message],(long)buttonIndex);
    
    if([[alertView message] isEqualToString:@"You want to Log out?"])
    {
        if(buttonIndex==0)
        {
            [NSUserDefaults deleteObjectForKey:USERID];
            [NSUserDefaults deleteObjectForKey:CURRENT_CHILD_ID];
            [NSUserDefaults deleteObjectForKey:IS_FROM_SIGNUP];
            [NSUserDefaults deleteObjectForKey:IS_CHILD_NOT_AVAILABLE];
            
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate setListOfChildrens:nil];
            [delegate checkValidUser];
        }
        else
        {
            NSLog(@"Cancel clicked");
        }
    }
    
    
    
   
}



-(void)buttonClickedEvent
{
    
}

- (IBAction)kidDropdownAction:(id)sender {
    if (dropdownSelected) {
        dropdownSelected=NO;
        noofSections=4;
    }
    else
    {
        noofSections=1;
        dropdownSelected=YES;
    }
    
    [self.tableView reloadData];
    
}
- (IBAction)babyDropdownAction:(id)sender {
}

-(void)getAllChildrans
{
    NSString *s=[[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    NSDictionary *params = @{@"user_id" : s};
    
    // NSDictionary *params = @{@"user_id" : USERID};
    [[ConnectionsManager sharedManager] childrenDetails:params  withdelegate:self];
}

#pragma mark - ServerResponseDelegate
- (void) success:(id)response
{
    NSLog(@"Response of the get childrans : %@",response);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSDictionary *responseDict = (NSDictionary *)response
        ;
        if ([responseDict[@"status"] boolValue]) {
            
            //            children
            childransArray = responseDict[@"data"][@"children"];
            
            [self.tableView reloadData];
        }
        else{
          //  [Constants showOKAlertWithTitle:@"Error" message:@"Unable to load your childrans list, Please try again after some time" presentingVC:self];
        }
    });
}
- (void) failure:(id)response
{
    NSLog(@"Failure Error of the get childrans : %@",response);
    
}
@end
