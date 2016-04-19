//
//  ImmunisationCalenderDetailViewController.m
//  BabyApp
//
//  Created by Charan Giri on 28/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "ImmunisationCalenderDetailViewController.h"
#import "RSDFDatePickerView.h"
#import "immunisationMainTableViewCell.h"
#import "immunisationSecondaryTableViewCell.h"


@interface ImmunisationCalenderDetailViewController ()<RSDFDatePickerViewDelegate,RSDFDatePickerViewDataSource,UITableViewDataSource,UITableViewDelegate>

@end

@implementation ImmunisationCalenderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self calenderCreation];
    
    self.navigationItem.rightBarButtonItem = [self addRightButton];
    
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row==0) {
        
        return 90;
    }
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        
        immunisationMainTableViewCell *cell = (immunisationMainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"mainCell"];
        cell.backgroundColor=[UIColor whiteColor];
        cell.dateLabel.text=@"30";
        cell.monthLabel.text=@"Apr";
        cell.mainLabel.text=@"HepB(D1)";
        cell.subTitleLabel.text=@"Hepatits B vaccine, first dose";
        cell.titleLabel.text=@"Birth";
        
        return cell;
    }
    else
    {
        immunisationSecondaryTableViewCell *cell = (immunisationSecondaryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"secondCell"];
        cell.backgroundColor=[UIColor whiteColor];
        cell.subtitleLabel.text=@"Bacillus calmette-Guerin";
        cell.titleLabel.text=@"BCG";
        
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // [self performSegueWithIdentifier:@"ImmunisationsSegue" sender:self];
}



#pragma mark - Bar button



-(UIBarButtonItem *)addRightButton
{
    UIImage *buttonImage = [UIImage imageNamed:@"teeth.png"];
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [aButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    aButton.frame = CGRectMake(0.0, 0.0, 40,40);
    
    UIBarButtonItem *aBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    
    [aButton addTarget:self action:@selector(showCalender) forControlEvents:UIControlEventTouchUpInside];
    
    return aBarButtonItem;
}
-(void)showCalender
{
    //calenderSegue
    
    // [self performSegueWithIdentifier:@"calenderSegue" sender:self];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Calender data source


// Returns YES if the date should be highlighted or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldHighlightDate:(NSDate *)date
{
    return YES;
}

// Returns YES if the date should be selected or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldSelectDate:(NSDate *)date
{
    return YES;
}

// Prints out the selected date.
- (void)datePickerView:(RSDFDatePickerView *)view didSelectDate:(NSDate *)date
{
    NSLog(@"%@", [date description]);
}
// Returns YES if the date should be marked or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldMarkDate:(NSDate *)date
{
    // The date is an `NSDate` object without time components.
    // So, we need to use dates without time components.
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *todayComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDate *today = [calendar dateFromComponents:todayComponents];
    
    return [date isEqual:today];
}

// Returns the color of the default mark image for the specified date.
- (UIColor *)datePickerView:(RSDFDatePickerView *)view markImageColorForDate:(NSDate *)date
{
    if (arc4random() % 2 == 0) {
        return [UIColor grayColor];
    } else {
        return [UIColor greenColor];
    }
}

// Returns the mark image for the specified date.
- (UIImage *)datePickerView:(RSDFDatePickerView *)view markImageForDate:(NSDate *)date
{
    if (arc4random() % 2 == 0) {
        return [UIImage imageNamed:@"img_yellow_mark"];
    } else {
        return [UIImage imageNamed:@"img_green_mark"];
    }
}
-(void)calenderCreation
{
    //    RSDFDatePickerView *datePickerView = [[RSDFDatePickerView alloc] initWithFrame:self.view.bounds];
    RSDFDatePickerView *datePickerView = [[RSDFDatePickerView alloc] initWithFrame:CGRectMake(0, 40 , self.view.frame.size.width, _baseView.frame.size.height)];
    
    datePickerView.delegate = self;
    datePickerView.dataSource = self;
    datePickerView.tintColor=[UIColor blueColor];
    [self.view addSubview:datePickerView];
    
    
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
