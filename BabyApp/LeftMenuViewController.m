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



#import "HeartTypeTableViewCell.h"
#import "ProfileTableViewCell.h"

#import "ConnectionsManager.h"
#import "Constants.h"
#import "WSConstant.h"
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
    noofSections=3;
    dropdownSelected=NO;
//@"Baby Booklet"
    section1Array=[NSArray arrayWithObjects:@"New Immunisation",@"New Screening", nil];
    section2Array=[NSArray arrayWithObjects:@"My Immunisation",@"My Screening",@"My Growth Percentiles",@"Health Book",@"Encyclopedia", nil];
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
            sectionName = @"";
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
    
    if (dropdownSelected) {
        return [childransArray count] +1;

    }
    else{
        
    switch (section)
    {
        case 0:
            return 1;
            break;
            
        case 1:
            return section1Array.count;
            break;
            
        case 2:
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
    HeartTypeTableViewCell*cell2=nil;
    ProfileTableViewCell *cell1=nil;

    if (dropdownSelected) {
        
        if (indexPath.row==0) {
            
            cell1=[tableView dequeueReusableCellWithIdentifier:@"profileIdentifier"];
            cell1.babyNameLabel.text=@"Charan Giri";
            return cell1;
        }
        else
        {
            NSDictionary *childrenDict = childransArray[indexPath.row-1];
            cell1=[tableView dequeueReusableCellWithIdentifier:@"profileIdentifier"];
            cell1.babyNameLabel.text=childrenDict[@"name"];
            cell1.dropdown.hidden=YES;
            return cell1;
        }
        
    }
    else{
        
    
        switch (indexPath.section)
        {
            case 0:

                cell1=[tableView dequeueReusableCellWithIdentifier:@"profileIdentifier"];
                cell1.babyNameLabel.text=@"Charan Giri";
                return cell1;
                break;
                
            case 1:
                 cell2 = (HeartTypeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"heartTypeIdentifier"];
                cell2.contentNameLabel.text = section1Array[indexPath.row];
                return cell2;
                break;
                
            case 2:
                cell2 = (HeartTypeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"heartTypeIdentifier"];
                cell2.contentNameLabel.text = section3Array[indexPath.row];
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
    
    if ( indexPath.section==0) {
        
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
        else
        {
            dropdownSelected=NO;
            noofSections=4;
            [self.tableView reloadData];

             vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
            [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
            
            
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
        }
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
        
      /*  else if (indexPath.section==2) {
            
            
            switch (indexPath.row)
            {
                case 0:
                    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"Immunisation"];
                    break;
                    
                case 1:
                    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"Screening"];
                    break;
                    
                case 2:
                    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"Growth"];
                    break;
                    
                case 3:
                    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"Health"];
                    break;
                case 4:
                    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"EncyclopediaStoryBoard"];
                    break;
            }
        }*/
        else
        {
            if (indexPath.row==0) {
                vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"SettingsViewController_SB_ID"];
            }
            else
            {
                [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:NO];
                return;
                
            }
            
            
            
        }
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
        
        
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                         andCompletion:nil];
        
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
    
}
- (IBAction)babyDropdownAction:(id)sender {
}

-(void)getAllChildrans
{
    NSDictionary *params = @{@"user_id" : USERID};
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
        }
        else{
            [Constants showOKAlertWithTitle:@"Error" message:@"Unagle to load your childrans list, Please try again after some time" presentingVC:self];
        }
    });
}
- (void) failure:(id)response
{
    NSLog(@"Failure Error of the get childrans : %@",response);
  
}
@end
