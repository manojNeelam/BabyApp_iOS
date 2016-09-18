//
//  SelectScheduleVC.m
//  BabyApp
//
//  Created by Pai, Ankeet on 03/06/16.
//  Copyright © 2016 Infinity. All rights reserved.
//
#define UNCHECK @"unCheck"
#define CHECK @"checkBox"

#import "SelectScheduleVC.h"
#import "WSConstant.h"

@interface SelectScheduleVC ()
{
    BOOL option1, option2, option3;
}
@end

@implementation SelectScheduleVC
@synthesize isFromImmunisation;


- (IBAction)onClickProceedButon:(id)sender
{
    if([self isValid])
    {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewImmunisationVC_SB_ID"];
        [self.navigationController pushViewController:vc
                                             animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select any option" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
   /* if(isFromImmunisation)
    {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewImmunisationVC_SB_ID"];
        [self.navigationController pushViewController:vc
                                             animated:YES];
    }
    else
    {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewImmunisationVC_SB_ID"];
        [self.navigationController pushViewController:vc
                                             animated:YES];
    }*/
    
    
    
}

-(BOOL)isValid
{
    if(option1 || option2 || option3)
    {
        return YES;
    }
    return NO;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Immunisation"];
    
    [self addTapgestures];
    
    NSString *option = [NSUserDefaults retrieveObjectForKey:SCHDULE_OPTION];
    if(option && option.length > 0)
    {
        if([option isEqualToString:@"1"])
        {
            option1 = NO;
            [self onClickOption1:nil];
        }
        else if ([option isEqualToString:@"2"])
        {
            option2 = NO;
            [self onClickOption2:nil];
        }
        else if([option isEqualToString:@"3"])
        {
            option3 = NO;
            [self onClickOption3:nil];
        }
    }
    else
    {
        option1 = NO;
        option2 = NO;
        option3 = NO;
    }
    
    
    self.btnProceed.layer.cornerRadius = 8.0f;
    self.btnProceed.layer.masksToBounds = YES;
    
    
    [self.lblDesc setTextColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.7]];
    [self.lblDescOption1 setTextColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.7]];
    [self.lblDescOption2 setTextColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.7]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)addTapgestures
{
    UITapGestureRecognizer *option1Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickOption1:)];
    [self.baseOption1View addGestureRecognizer:option1Tap];
    
    UITapGestureRecognizer *option2Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickOption2:)];
    [self.baseOption2View addGestureRecognizer:option2Tap];
    
    UITapGestureRecognizer *option3Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickOption3:)];
    [self.baseOption3View addGestureRecognizer:option3Tap];
}

-(void)onClickOption1:(UITapGestureRecognizer *)aGest
{
    option1 = !option1;
    
    if(option1)
    {
        [NSUserDefaults saveObject:@"1" forKey:SCHDULE_OPTION];
        
        [self.imgOption1 setImage:[UIImage imageNamed:CHECK]];
        [self.imgOption2 setImage:[UIImage imageNamed:UNCHECK]];
        [self.imgOption3 setImage:[UIImage imageNamed:UNCHECK]];
    }
//    else
//    {
//        [self.imgOption1 setImage:[UIImage imageNamed:UNCHECK]];
//    }
}

-(void)onClickOption2:(UITapGestureRecognizer *)aGest
{
    option2 = !option2;
    
    if(option2)
    {
        [NSUserDefaults saveObject:@"2" forKey:SCHDULE_OPTION];
        [self.imgOption2 setImage:[UIImage imageNamed:CHECK]];
        [self.imgOption3 setImage:[UIImage imageNamed:UNCHECK]];
        [self.imgOption1 setImage:[UIImage imageNamed:UNCHECK]];
    }
//    else
//    {
//        [self.imgOption2 setImage:[UIImage imageNamed:UNCHECK]];
//    }
}

-(void)onClickOption3:(UITapGestureRecognizer *)aGest
{
    option3 = !option3;
    
    if(option3)
    {
        [NSUserDefaults saveObject:@"3" forKey:SCHDULE_OPTION];
        [self.imgOption3 setImage:[UIImage imageNamed:CHECK]];
        [self.imgOption1 setImage:[UIImage imageNamed:UNCHECK]];
        [self.imgOption2 setImage:[UIImage imageNamed:UNCHECK]];
    }
//    else
//    {
//        [self.imgOption3 setImage:[UIImage imageNamed:UNCHECK]];
//    }
}

@end
