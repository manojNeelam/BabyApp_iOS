//
//  BirthRecordTableViewController.m
//  BabyApp
//
//  Created by Charan Giri on 22/02/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "BirthRecordTableViewController.h"
#import "CommonSelectionListVC.h"
#import "DateTimeUtil.h"
#import "CustomIOS7AlertView.h"
#import "ConnectionsManager.h"
#import "NSString+CommonForApp.h"

@interface BirthRecordTableViewController () <CommonSelectionListVCDelegate, CustomIOS7AlertViewDelegate, ServerResponseDelegate>
{
    NSArray *identifierNames;
    
    UITapGestureRecognizer *genderGesture, *ethnicGesture, *modeDeliveryGesture, *apgarMinDurationGesture, *apgarMaxDurationGesture, *durationGesture;
    NSString *keyString;
    
    NSInteger selectedIndex;
    CustomIOS7AlertView *dateAlertView;
    UIDatePicker *datePicker;
    
    BOOL isUpdate;
}
@end

@implementation BirthRecordTableViewController
@synthesize selectedBioData;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.maxDurationView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.maxDurationView.layer.borderWidth = 1.0f;
    
    self.minDurationView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.minDurationView.layer.borderWidth = 1.0f;
    
    [self.txtFldHeadCircunference setText:@"152"];
    
    [self loadData];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidLayoutSubviews
{
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.baseHeadCircumferenceView.frame.origin.y+self.baseDurationGestationView.frame.size.height + 20)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addGestures];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:10] forKey:@"child_id"];
    
    [[ConnectionsManager sharedManager] readBirthRecord:dict withdelegate:self];
}

-(void)addGestures
{
    genderGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickGenderButton:)];
    [self.baseSexView addGestureRecognizer:genderGesture];
    
    ethnicGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickEthnicGesture:)];
    [self.baseEthnicGroupView addGestureRecognizer:ethnicGesture];
    
    modeDeliveryGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickModeDeliveryGesture:)];
    [self.baseModeOfDeliveryView addGestureRecognizer:modeDeliveryGesture];
    
    apgarMinDurationGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickApgarMinScoreGesture:)];
    [self.minDurationView addGestureRecognizer:apgarMinDurationGesture];
    
    apgarMaxDurationGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickApgarMaxScoreGesture:)];
    [self.maxDurationView addGestureRecognizer:apgarMaxDurationGesture];
    
    durationGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickDurationGesture:)];
    [self.baseDurationGestationView addGestureRecognizer:durationGesture];
}

-(void)onClickGenderButton:(UIGestureRecognizer *)aGesture
{
    selectedIndex = 1;
    keyString = @"Gender";
    [self openCommonSelectionVC];
}

-(void)onClickEthnicGesture:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 2;
    keyString = @"Ethnic";
    [self openCommonSelectionVC];
}

-(void)onClickModeDeliveryGesture:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 3;
    keyString = @"Delivery";
    [self openCommonSelectionVC];
}

-(void)onClickApgarMinScoreGesture:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 4;
    keyString = @"MinScore";
    [self openCommonSelectionVC];
}

-(void)onClickApgarMaxScoreGesture:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 5;
    keyString = @"MaxScore";
    [self openCommonSelectionVC];
}

//onClickDurationGesture
-(void)onClickDurationGesture:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 6;
    [self openDate];
}

-(void)selectedValue:(NSString *)aSelectedValue
{
    switch (selectedIndex) {
        case 1:
        {
            [self.txtFldSex setText:aSelectedValue];
        }
            break;
        case 2:
        {
            [self.txtFldEthnicGroup setText:aSelectedValue];
        }
            break;
        case 3:
        {
            [self.txtFldModeofDelivery setText:aSelectedValue];
        }
            break;
        case 4:
        {
            [self.lblMinDuration setText:aSelectedValue];
        }
            break;
        case 5:
        {
            [self.lblMaxDuration setText:aSelectedValue];
        }
            break;
            
        default:
            break;
    }
}

-(void)openCommonSelectionVC
{
    CommonSelectionListVC *commonSelectionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CommonSelectionListVC_SB_ID"];
    [commonSelectionVC setDelegate:self];
    commonSelectionVC.keyString = keyString;
    [self.navigationController pushViewController:commonSelectionVC animated:YES];
}

-(void)openDate
{
    dateAlertView = [[CustomIOS7AlertView alloc] init];
    [dateAlertView setContainerView:[self createDateView]];
    [dateAlertView setButtonTitles:[NSMutableArray arrayWithObjects:@"CLOSE", @"SET", nil]];
    [dateAlertView setDelegate:self];
    [dateAlertView setUseMotionEffects:true];
    dateAlertView.tag = selectedIndex;
    
    [dateAlertView show];
}

- (UIView *)createDateView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 216)];
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    datePicker.frame = CGRectMake(10, 10, 280, 216);
    datePicker.datePickerMode = UIDatePickerModeDate;
    [demoView addSubview:datePicker];
    return demoView;
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    [dateAlertView close];
    NSString * dateFromData = [DateTimeUtil stringFromDateTime:datePicker.date withFormat:@"dd-MM-yyyy"];
    
    switch (selectedIndex) {
        case 6:
        {
            [self.txtFldDurationGestation setText:dateFromData];
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickPreviousButton:(id)sender {
}

- (IBAction)onClickNextButton:(id)sender {
}
- (IBAction)onClickDone:(id)sender
{
    
    if([self isValidData])
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [dict setObject:self.txtFldBirthCertificateNo.text forKey:@"birth_certificate_no"];
        [dict setObject:self.txtfldPlaceOfDelivery.text forKey:@"place_of_delivery"];
        [dict setObject:self.txtFldSex.text forKey:@"sex"];
        [dict setObject:self.txtFldEthnicGroup.text forKey:@"ethnic_group"];
        [dict setObject:self.txtFldDurationGestation.text forKey:@"duration_of_gestation"];
        [dict setObject:self.txtFldModeofDelivery.text forKey:@"mode_of_delivery"];
        [dict setObject:self.lblMinDuration.text forKey:@"apgar_score1"];
        [dict setObject:self.lblMaxDuration.text forKey:@"apgar_score2"];
        [dict setObject:self.txtFldWeightAtBirth.text forKey:@"weight_at_birth"];
        [dict setObject:self.txtFldLengthAtBirth.text forKey:@"length_at_birth"];
        [dict setObject:self.txtFldHeadCircunference.text forKey:@"head_circumference"];
        
        [dict setObject:@"10" forKey:@"child_id"];
        [dict setObject:selectedBioData.name forKey:@"name"];
        [dict setObject:selectedBioData.dob forKey:@"dob"];
        
        if(isUpdate)
        {
            [[ConnectionsManager sharedManager] updateBirthRecord:dict withdelegate:self];
        }
        else
        {
            [[ConnectionsManager sharedManager] addBirthRecord:dict withdelegate:self];
        }
    }
}

-(BOOL)isValidData
{
    if([self.txtFldBirthCertificateNo.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Birth Certificate" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtfldPlaceOfDelivery.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Place of delivery" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldSex.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid sex" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldEthnicGroup.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid EthnicGroup" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldDurationGestation.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Duration" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldModeofDelivery.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Mode of delivery" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.lblMinDuration.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Min Duration" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.lblMaxDuration.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Max Duration" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    
    if([self.txtFldWeightAtBirth.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Weight" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldLengthAtBirth.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Length" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldHeadCircunference.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Head Circumference" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    return YES;
}

-(void)success:(id)response
{
    NSDictionary *dict = response;
    id statusStr_ = [dict objectForKey:@"status"];
    NSString *statusStr;
    
    if([statusStr_ isKindOfClass:[NSNumber class]])
    {
        statusStr = [statusStr_ stringValue];
    }
    else
    {
        statusStr = statusStr_;
    }
    if([statusStr isEqualToString:@"1"])
    {
        NSDictionary *dataDict = [dict objectForKey:@"data"];
        /*
         "apgar_score1" = 3;
         "apgar_score2" = 3;
         "birth_certificate_no" = 1235;
         "child_id" = 10;
         dob = "01-07-2016";
         "duration_of_gestation" = "10-04-2016";
         "ethnic_group" = Asian;
         "head_circumference" = 0;
         "length_at_birth" = 522;
         "mode_of_delivery" = "Normal delivery";
         name = mukesh;
         "place_of_delivery" = vishrantiwadi;
         sex = Female;
         "weight_at_birth" = 522;
         */
        
        [self.txtFldBirthCertificateNo setText:[dataDict objectForKey:@"birth_certificate_no"]];
        [self.txtFldDurationGestation setText:[dataDict objectForKey:@"duration_of_gestation"]];
        [self.txtFldEthnicGroup setText:[dataDict objectForKey:@"ethnic_group"]];
        
        [self.txtFldHeadCircunference setText:[dataDict objectForKey:@"head_circumference"]];
        [self.txtFldLengthAtBirth setText:[dataDict objectForKey:@"length_at_birth"]];
        [self.txtFldModeofDelivery setText:[dataDict objectForKey:@"mode_of_delivery"]];
        [self.txtfldPlaceOfDelivery setText:[dataDict objectForKey:@"place_of_delivery"]];
        
        [self.txtFldSex setText:[dataDict objectForKey:@"sex"]];
        [self.txtFldWeightAtBirth setText:[dataDict objectForKey:@"weight_at_birth"]];
        
        [self.lblMinDuration setText:[dataDict objectForKey:@"apgar_score1"]];
        [self.lblMaxDuration setText:[dataDict objectForKey:@"apgar_score2"]];
        
        isUpdate = YES;
    }
}

-(void)failure:(id)response
{
    
}
@end
