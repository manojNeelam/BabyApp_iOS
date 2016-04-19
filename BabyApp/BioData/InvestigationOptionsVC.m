//
//  InvestigationOptionsVC.m
//  BabyApp
//
//  Created by Vishal Kolhe on 02/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "InvestigationOptionsVC.h"
#import "InvestigationDefaultCell.h"
#import "InvestOtherTestCell.h"
#import "InvestAddNewTestCell.h"
#import "InvestigationOptionsData.h"
#import "CustomIOS7AlertView.h"
#import "DateTimeUtil.h"
#import "ConnectionsManager.h"

@interface InvestigationOptionsVC () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, CustomIOS7AlertViewDelegate, ServerResponseDelegate>
{
    NSMutableArray *investigationList;
    
    
    UITextField *currentTextField;
    CustomIOS7AlertView *dateAlertView;
    UIDatePicker *datePicker;
}
@end

@implementation InvestigationOptionsVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    investigationList = [NSMutableArray array];
}

-(void)loadData
{
    /*NSMutableArray *tempArray = [NSMutableArray array];
     
     InvestigationOptionsData *investigationDataSerum = [[InvestigationOptionsData alloc] init];
     [investigationDataSerum setTestName:@"Serum Bilirubin:"];
     [investigationDataSerum setPlaceHolderText:@"mol/L"];
     [investigationDataSerum setDate:@"xxxx-xx-xx"];
     
     [tempArray addObject:investigationDataSerum];
     
     InvestigationOptionsData *investigationData = [[InvestigationOptionsData alloc] init];
     [investigationData setTestName:@"Blood Group:"];
     [investigationData setPlaceHolderText:@"mol/L"];
     [investigationData setDate:@"xxxx-xx-xx"];
     
     [tempArray addObject:investigationData];
     
     investigationList = tempArray;
     
     [self.investTableView reloadData];*/
    
    NSNumber *childID = [[NSUserDefaults standardUserDefaults] objectForKey:@"child_id"];
    ///if(childID && childID != nil)
    // {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"10" forKey:@"child_id"];
    
    [[ConnectionsManager sharedManager] readinvestigations_read:dict withdelegate:self];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(investigationList && investigationList.count > 0)
        return investigationList.count +1;
    else
        return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row<2)
    {
        static NSString *cellIdentifier = @"InvestigationDefaultCell";
        InvestigationDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        InvestigationOptionsData *investgationData = [investigationList objectAtIndex:indexPath.row];
        [cell.txtFldDate setDelegate:self];
        
        [cell populateData:investgationData];
        return cell;
    }
    else if(indexPath.row == investigationList.count)
    {
        static NSString *cellIdentifier = @"InvestAddNewTestCell";
        InvestAddNewTestCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"InvestOtherTestCell";
        InvestOtherTestCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        [cell.txtFldDate setDelegate:self];
        InvestigationOptionsData *investgationData = [investigationList objectAtIndex:indexPath.row];
        [cell populateData:investgationData];
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == investigationList.count)
    {
        [self addNewCell];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row<2)
    {
        return 150;
    }
    else if (indexPath.row < investigationList.count)
    {
        return 150;
    }
    else
    {
        return 97;
    }
}

-(void)addNewCell
{
    InvestigationOptionsData *investigationData = [[InvestigationOptionsData alloc] init];
    [investigationData setTestName:@"Blood Group:"];
    [investigationData setPlaceHolderText:@"Other tests (Specify)"];
    [investigationData setDate:@"xxxx-xx-xx"];
    
    [investigationList insertObject:investigationData atIndex:investigationList.count -1];
    
    [self.investTableView reloadData];
}

-(void) textFieldDidEndEditing: (UITextField * ) textField {
    // Decide which text field based on it's tag and save data to the model.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self resignFirstResponder];
    currentTextField = textField;
    [self openDate];
    return NO;
}

-(void)openDate
{
    dateAlertView = [[CustomIOS7AlertView alloc] init];
    [dateAlertView setContainerView:[self createDateView]];
    [dateAlertView setButtonTitles:[NSMutableArray arrayWithObjects:@"CLOSE", @"SET", nil]];
    [dateAlertView setDelegate:self];
    [dateAlertView setUseMotionEffects:true];
    
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
    
    [currentTextField setText:dateFromData];
}

- (IBAction)onClickPreviousButton:(id)sender {
}

- (IBAction)onClickNextButton:(id)sender {
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
        id dataDict = [dict objectForKey:@"data"];
        if([dataDict isKindOfClass:[NSDictionary class]])
        {
            /*
             "child_id" : 101
             "serum_billirubin" : ""
             "date_serum" : ""
             "blood_group" : ""
             "date_blood_group" : ""
             "add_test" : ""
             
             */
            
            
            NSMutableArray *tempArray = [NSMutableArray array];
            
            InvestigationOptionsData *investigationDataSerum = [[InvestigationOptionsData alloc] init];
            [investigationDataSerum setTestName:[NSString stringWithFormat:@"Serum Bilirubin: %@", [dataDict objectForKey:@"serum_billirubin"]]];
            [investigationDataSerum setPlaceHolderText:@"mol/L"];
            [investigationDataSerum setDate:@"xxxx-xx-xx"];
            
            [tempArray addObject:investigationDataSerum];
            
            
            investigationList = tempArray;
            
            [self.investTableView reloadData];
        }
        
    }
}

-(void)failure:(id)response
{
    
}
@end
