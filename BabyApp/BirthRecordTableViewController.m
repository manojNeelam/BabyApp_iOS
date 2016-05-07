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
#import "ParticularsOfParentsVC.h"
#import "WSConstant.h"
#import "NSUserDefaults+Helpers.h"

@interface BirthRecordTableViewController () <CommonSelectionListVCDelegate, CustomIOS7AlertViewDelegate, ServerResponseDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    
    NSArray *genderList;
    NSArray *identifierNames;
    
    BOOL isDone;
    BOOL isPrevious;
    UITapGestureRecognizer *genderGesture, *ethnicGesture, *modeDeliveryGesture, *apgarMinDurationGesture, *apgarMaxDurationGesture, *durationGesture;
    NSString *keyString;
    
    NSInteger selectedIndex;
    CustomIOS7AlertView *dateAlertView;
    UIDatePicker *datePicker;
    
    UITableView *commonTblView;
    
    UITextField *currentTextField;
    
    UILabel *currentLabel;
    
    BOOL isUpdate;
}
@end

@implementation BirthRecordTableViewController
@synthesize selectedBioData;




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.txtFldBirthCertificateNo setDelegate:self];
    [self.txtFldDurationGestation setDelegate:self];
    [self.txtFldEthnicGroup setDelegate:self];
    
    
    [self.txtFldLengthAtBirth setDelegate:self];
    [self.txtFldModeofDelivery setDelegate:self];
    [self.txtfldPlaceOfDelivery setDelegate:self];
    [self.txtFldSex setDelegate:self];
    [self.txtFldWeightAtBirth setDelegate:self];
    [self.txtFldHeadCircunference setDelegate:self];
    
    [self.txtFldWeightAtBirth setKeyboardType:UIKeyboardTypeNumberPad];
    [self.txtFldLengthAtBirth setKeyboardType:UIKeyboardTypeNumberPad];
    [self.txtFldHeadCircunference setKeyboardType:UIKeyboardTypeNumberPad];
    
    self.maxDurationView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.maxDurationView.layer.borderWidth = 1.0f;
    
    self.minDurationView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.minDurationView.layer.borderWidth = 1.0f;
    
    [self loadData];
    
    commonTblView = [[UITableView alloc] init];
    [commonTblView setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    commonTblView.backgroundView = nil;
    [commonTblView setDataSource:self];
    [commonTblView setDelegate:self];
    [commonTblView setHidden:YES];
    
    isDone = NO;
    [self.scrollView addSubview:commonTblView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidLayoutSubviews
{
    [commonTblView setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.baseHeadCircumferenceView.frame.origin.y+self.baseHeadCircumferenceView.frame.size.height + 80)];
}

-(void)onclickkeyboardhide:(UITapGestureRecognizer *)aGesture
{
    [self.view endEditing:YES];
    [commonTblView setHidden:YES];
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
    [dict setObject:[self numfromString:[NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID]] forKey:@"child_id"];
    
    [[ConnectionsManager sharedManager] readBirthRecord:dict withdelegate:self];
}

-(void)onCircumferenceBecomeResponse:(UIGestureRecognizer *)aGesture
{
    [self.txtFldHeadCircunference becomeFirstResponder];
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
    [self.view endEditing:YES];
    
    currentTextField = self.txtFldSex;
    [self loadGenderData];
    
    CGRect frameView = self.baseSexView.frame;
    CGRect frameTxtFld = self.txtFldSex.frame;
    [self setFrameCommonTableView:frameView andTextFieldRect:frameTxtFld];
    
    //    [commonTblView setFrame:CGRectMake(frameTxtFld.origin.x, frameView.origin.y+frameView.size.height, frameTxtFld.size.width, 88)];
    //    [commonTblView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    //    [commonTblView setBackgroundColor:[UIColor whiteColor]];
    //
    //
    //    [commonTblView setHidden:NO];
    //    [commonTblView reloadData];
    
    //[self openCommonSelectionVC];
}

-(void)onClickEthnicGesture:(UITapGestureRecognizer *)aTapGesture
{
    [self.view endEditing:YES];
    
    currentTextField = self.txtFldEthnicGroup;
    [self loadEthickData];
    
    
    CGRect frameView = self.baseEthnicGroupView.frame;
    CGRect frameTxtFld = self.txtFldEthnicGroup.frame;
    [self setFrameCommonTableView:frameView andTextFieldRect:frameTxtFld];
    
    //selectedIndex = 2;
    //keyString = @"Ethnic";
    //[self openCommonSelectionVC];
}

-(void)onClickModeDeliveryGesture:(UITapGestureRecognizer *)aTapGesture
{
    
    [self.view endEditing:YES];
    
    
    //    selectedIndex = 3;
    //    keyString = @"Delivery";
    //    [self openCommonSelectionVC];
    
    currentTextField = self.txtFldModeofDelivery;
    
    [self loadDeliveryData];
    
    
    CGRect frameView = self.baseModeOfDeliveryView.frame;
    CGRect frameTxtFld = self.txtFldModeofDelivery.frame;
    [self setFrameCommonTableView:frameView andTextFieldRect:frameTxtFld];
    
}

-(void)onClickApgarMinScoreGesture:(UITapGestureRecognizer *)aTapGesture
{
    
    //    [self.view endEditing:YES];
    //
    //
    //    selectedIndex = 4;
    //    keyString = @"MinScore";
    //    [self openCommonSelectionVC];
    
    currentTextField = nil;
    
    [self.view endEditing:YES];
    
    
    //    selectedIndex = 3;
    //    keyString = @"Delivery";
    //    [self openCommonSelectionVC];
    
    currentLabel = self.lblMinDuration;
    
    [self loadApgarData];
    
    CGRect frameView = self.baseApgarScoreView.frame;
    CGRect frameTxtFld = self.minDurationView.frame;
    [self setFrameCommonTableViewApgar:frameView andTextFieldRect:frameTxtFld];
    
}

-(void)onClickApgarMaxScoreGesture:(UITapGestureRecognizer *)aTapGesture
{
    //    [self.view endEditing:YES];
    //
    //    selectedIndex = 5;
    //    keyString = @"MaxScore";
    //    [self openCommonSelectionVC];
    
    currentTextField = nil;
    
    [self.view endEditing:YES];
    
    
    //    selectedIndex = 3;
    //    keyString = @"Delivery";
    //    [self openCommonSelectionVC];
    
    currentLabel = self.lblMaxDuration;
    
    [self loadApgarData];
    
    CGRect frameView = self.baseApgarScoreView.frame;
    CGRect frameTxtFld = self.maxDurationView.frame;
    [self setFrameCommonTableViewApgar:frameView andTextFieldRect:frameTxtFld];
    
    
}

//onClickDurationGesture
-(void)onClickDurationGesture:(UITapGestureRecognizer *)aTapGesture
{
    [self.view endEditing:YES];
    
    selectedIndex = 6;
    [self openDate];
}

-(void)setFrameCommonTableView:(CGRect)frameView andTextFieldRect:(CGRect)frameTxtFld
{
    [commonTblView setFrame:CGRectMake(frameTxtFld.origin.x-20, frameView.origin.y+frameView.size.height, frameTxtFld.size.width+50, genderList.count*44)];
    [commonTblView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [commonTblView setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    
    [commonTblView setHidden:NO];
    [commonTblView reloadData];
}

-(void)setFrameCommonTableViewApgar:(CGRect)frameView andTextFieldRect:(CGRect)frameTxtFld
{
    CGRect frm = self.baseSubApgarView.frame;
    
    [commonTblView setFrame:CGRectMake(frm.origin.x +  frameTxtFld.origin.x, frameView.origin.y+frameTxtFld.size.height +frameTxtFld.origin.y , frameTxtFld.size.width+50, 4*44)];
    [commonTblView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [commonTblView setBackgroundColor:[UIColor whiteColor]];
    
    
    [commonTblView setHidden:NO];
    [commonTblView reloadData];
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
    [dateAlertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Close", @"Set", nil]];
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

- (IBAction)onClickPreviousButton:(id)sender
{
    isPrevious = YES;
     [self onClickDone:sender];
}

- (IBAction)onClickNextButton:(id)sender
{
    [self onClickDone:sender];
    
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
        
        
        [dict setObject:[self numfromString:self.txtFldWeightAtBirth.text] forKey:@"weight_at_birth"];
        [dict setObject:[self numfromString:self.txtFldLengthAtBirth.text] forKey:@"length_at_birth"];
        [dict setObject:[self numfromString:self.txtFldHeadCircunference.text] forKey:@"head_circumference"];
        
        
        
        [dict setObject:[self numfromString:[NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID]] forKey:@"child_id"];
        [dict setObject:selectedBioData.name forKey:@"name"];
        [dict setObject:selectedBioData.dob forKey:@"dob"];
        
        if(isUpdate)
        {
            isDone = YES;
            [[ConnectionsManager sharedManager] updateBirthRecord:dict withdelegate:self];
        }
        else
        {
            isDone = YES;
            [[ConnectionsManager sharedManager] addBirthRecord:dict withdelegate:self];
        }
    }
}

-(NSNumber *)numfromString:(NSString *)aStr
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [f numberFromString:aStr];
    
    return myNumber;
    
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
        
        [self.txtFldHeadCircunference setText:[NSString stringWithFormat:@"%@",[dataDict objectForKey:@"head_circumference"]]];
        [self.txtFldLengthAtBirth setText:[dataDict objectForKey:@"length_at_birth"]];
        [self.txtFldModeofDelivery setText:[dataDict objectForKey:@"mode_of_delivery"]];
        [self.txtfldPlaceOfDelivery setText:[dataDict objectForKey:@"place_of_delivery"]];
        
        [self.txtFldSex setText:[dataDict objectForKey:@"sex"]];
        [self.txtFldWeightAtBirth setText:[dataDict objectForKey:@"weight_at_birth"]];
        
        [self.lblMinDuration setText:[dataDict objectForKey:@"apgar_score1"]];
        [self.lblMaxDuration setText:[dataDict objectForKey:@"apgar_score2"]];
        
        isUpdate = YES;
        
        
        if (isDone) {
            isDone = NO;
            
            if (isPrevious)
            {
                isPrevious = NO;
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
            ParticularsOfParentsVC *ParentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ParticularsOfParentsVC_SB_ID"];
            [self.navigationController pushViewController:ParentVC animated:YES];
            }
        }
    }
}

-(void)failure:(id)response
{
    
}

-(void)loadGenderData
{
    NSMutableArray *tempData = [NSMutableArray array];
    [tempData addObject:@"Male"];
    [tempData addObject:@"Female"];
    
    genderList = tempData;
    
}

-(void)loadEthickData
{
    NSMutableArray *tempData = [NSMutableArray array];
    
    [tempData addObject:@"Hispanic or Latino"];
    [tempData addObject:@"American Indian or Alaska Native"];
    [tempData addObject:@"Asian"];
    [tempData addObject:@"Black or African American"];
    [tempData addObject:@"Native Hawaiian or Pacific Islander"];
    [tempData addObject:@"White"];
    
    genderList = tempData;
}

-(void)loadDeliveryData
{
    NSMutableArray *tempData = [NSMutableArray array];
    
    [tempData addObject:@"Normal delivery"];
    [tempData addObject:@"Cesarean delivery"];
    
    genderList = tempData;
}

-(void)loadApgarData
{
    NSMutableArray *tempData = [NSMutableArray array];
    
    [tempData addObject:@"1"];
    [tempData addObject:@"2"];
    [tempData addObject:@"3"];
    [tempData addObject:@"4"];
    [tempData addObject:@"5"];
    [tempData addObject:@"6"];
    [tempData addObject:@"7"];
    [tempData addObject:@"8"];
    [tempData addObject:@"9"];
    
    genderList = tempData;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return genderList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    [cell.textLabel setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
    [cell.textLabel setText:[genderList objectAtIndex:indexPath.row]];
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel sizeToFit];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [genderList objectAtIndex:indexPath.row];
    [commonTblView setHidden:YES];
    
    if(currentTextField && currentTextField !=nil)
    {
        [currentTextField setText:str];
    }
    else
    {
        [currentLabel setText:str];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [commonTblView setHidden:YES];
    return YES;
}


@end
