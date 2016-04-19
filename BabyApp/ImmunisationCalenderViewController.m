//
//  ImmunisationCalenderViewController.m
//  BabyApp
//
//  Created by Charan Giri on 28/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "ImmunisationCalenderViewController.h"
#import "RSDFDatePickerView.h"

@interface ImmunisationCalenderViewController ()<RSDFDatePickerViewDelegate,RSDFDatePickerViewDataSource>

@end

@implementation ImmunisationCalenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self calenderCreation];
    // Do any additional setup after loading the view.
}




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
    //calenderDetailSegue
    [self performSegueWithIdentifier:@"calenderDetailSegue" sender:self];

    
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
    RSDFDatePickerView *datePickerView = [[RSDFDatePickerView alloc] initWithFrame:CGRectMake(0, 40 , self.view.frame.size.width, self.view.frame.size.height-40)];
  
    datePickerView.delegate = self;
    datePickerView.dataSource = self;
    datePickerView.tintColor=[UIColor blueColor];
    [self.view addSubview:datePickerView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
