//
//  ChildDevelopementalViewController.m
//  BabyApp
//
//  Created by Pramod Ganapati Patil on 15/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "ChildDevelopementalViewController.h"
#import "ASValueTrackingSlider.h"
#import "WSConstant.h"
#import "Constants.h"
#import "ConnectionsManager.h"
#import "NSUserDefaults+Helpers.h"

#import "ChildDevData.h"
#import "ChildDevelopmentData.h"

@interface ChildDevelopementalViewController ()<ASValueTrackingSliderDataSource,UITableViewDataSource,UITableViewDelegate,ServerResponseDelegate>
{
    NSArray *childDevelopemntalScreeningArray;
    NSArray *allChildArray;
}


@property (strong, nonatomic) IBOutlet ASValueTrackingSlider *slider;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ChildDevelopementalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.slider setThumbImage:[UIImage imageNamed:@"thumImage"] forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [self.slider setNumberFormatter:formatter];
    
    _slider.minimumValue = 1;
    _slider.maximumValue = 12;
    _slider.popUpViewCornerRadius = 0.0;
    [_slider setMaxFractionDigitsDisplayed:0];
    //    slider.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    _slider.popUpViewColor = [UIColor darkGrayColor];
    
    _slider.font = [UIFont boldSystemFontOfSize:16];
    _slider.textColor = [UIColor whiteColor];
    _slider.dataSource = self;
    self.title = @"Child Developemental Screening";
    
    //    childDevelopemntalScreeningArray = @[
    //     @{@"title":@"type of screening",
    //     @"items":@[@"ajsdhgasdgajshgd ajsdhgas dahjgd",
    //     @"jahgd asjdhgas dajsgd adasjgd ajdgasd ajghsd ajdgasj dasdgas dajshgd asjdghas dajshgdas dgasd asjhgdas dgas dasjghd",
    //     @"dkajdhgasd a ajgsd asdg"
    //     ]
    //     },
    //     @{@"title":@"type of screening",
    //     @"items":@[@"ajsdhgasdgajshgd ajsdhgas dahjgd",
    //     @"jahgd asjdhgas dajsgd adasjgd ajdgasd ajghsd ajdgasj dasdgas dajshgd asjdghas dajshgdas dgasd asjhgdas dgas dasjghd",
    //     @"dkajdhgasd a ajgsd asdg hsdgf sdhfgsd fgs fsdhjgf sd"
    //     ]
    //     }
    //     ];
    
    
    //[self.tableView reloadData];
    
    //[self getChildDevevelopementals];
    
    [self loadData];
    
}

-(void)loadData
{
    NSMutableArray *tempHolder = [NSMutableArray array];
    
    ChildDevelopmentData *childDetailsData = [[ChildDevelopmentData alloc] init];
    childDetailsData.headerTitle = @"TYPE OF SCREENING";
    
    NSMutableArray *temp = [NSMutableArray array];
    
    ChildDevData *childDevData = [[ChildDevData alloc] init];
    childDevData.title = @"1. Growth monitoring: weight, length, OFC";
    [temp addObject:childDevData];
    
    ChildDevData *childDevData1 = [[ChildDevData alloc] init];
    childDevData1.title = @"2. Feeding history";
    [temp addObject:childDevData1];
    
    ChildDevData *childDevData2 = [[ChildDevData alloc] init];
    childDevData2.title = @"3. Hearing Screenig if not done at birth";
    [temp addObject:childDevData2];
    
    ChildDevData *childDevData3 = [[ChildDevData alloc] init];
    childDevData3.title = @"4. Physical examination and Development check";
    [temp addObject:childDevData3];
    
    childDetailsData.listChildDev = temp;
    
    [tempHolder addObject:childDetailsData];
    
    ChildDevelopmentData *childDetailsData1 = [[ChildDevelopmentData alloc] init];
    childDetailsData1.headerTitle = @"IMMUNISATION";
    
    NSMutableArray *temp1 = [NSMutableArray array];
    
    ChildDevData *childDevData4 = [[ChildDevData alloc] init];
    childDevData4.title = @"BCG, Hep B-1 at birth. Hep B-2 month after Hep-b1";
    [temp1 addObject:childDevData4];
    
    childDetailsData1.listChildDev = temp1;
    
    [tempHolder addObject:childDetailsData1];
    
    
    childDevelopemntalScreeningArray = tempHolder;
    
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

#pragma mark - slider datasources
- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value;
{
    value = roundf(value);
    NSString *s = [NSString  stringWithFormat:@"%d MONTTHS",(int)value];
    if (value == 1) {
        s = [NSString  stringWithFormat:@"%d MONTH",(int)value];
    }
    //    if (value < -10.0) {
    //        s = @"❄️Brrr!⛄️";
    //    } else if (value > 29.0 && value < 50.0) {
    //        s = [NSString stringWithFormat:@"😎 %@ 😎", [slider.numberFormatter stringFromNumber:@(value)]];
    //    } else if (value >= 50.0) {
    //        s = @"I’m Melting!";
    //    }
    //[self sortDataWithAge:value];
    return s;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return childDevelopemntalScreeningArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ChildDevelopmentData *childDevelopmentalDict = childDevelopemntalScreeningArray[section];
    return  childDevelopmentalDict.listChildDev.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    ChildDevelopmentData *childDevelopmentalDict = childDevelopemntalScreeningArray[indexPath.section];
    
    ChildDevData *childDev = [childDevelopmentalDict.listChildDev objectAtIndex:indexPath.row];
    
    NSString *screeningText =  childDev.title;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    [cell.textLabel setTextColor:[UIColor colorWithRed:141.0/255.0 green:140.0/255.0 blue:146.0/255.0 alpha:1.0]];
    [cell.textLabel setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15]];
    //
    //    NSString *cellText = @"Go get some text for your cell.";
    //    UIFont *cellFont = cell.textLabel.font;
    //    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    //    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    //    cell.textLabel.frame.size = labelSize;
    cell.textLabel.text = screeningText;
    
    return cell;
    
}

#pragma mark - UITableViewDelegate


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //minimum size of your cell, it should be single line of label if you are not clear min. then return UITableViewAutomaticDimension;
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    ChildDevelopmentData *childDevelopmentalDict = childDevelopemntalScreeningArray[section];
    NSString *sectionTitle =  childDevelopmentalDict.headerTitle;
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 45)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *headerLblSep = [[UILabel alloc] initWithFrame:CGRectMake(20, 44, tableView.frame.size.width-40, 1)];
    [headerLblSep setBackgroundColor:[UIColor colorWithRed:141.0/255.0 green:140.0/255.0 blue:146.0/255.0 alpha:1.0]];
    [headerView addSubview:headerLblSep];
    
    UILabel *headerLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 18, tableView.frame.size.width-40, 21)];
    [headerLbl setText:sectionTitle];
    [headerLbl setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi" size:15]];
    [headerLbl setTextColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    [headerView addSubview:headerLbl];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0f;
}

//#pragma  mark - get child developemenatal screening
//
//-(void)getChildDevevelopementals
//{
//    //    NSString *screeningID = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
//
//    NSString *screeningID = @"1";
//
//    NSString *childID = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
//    NSString *userId  = [NSUserDefaults retrieveObjectForKey:USERID];
//    childID = @"1";
//    NSDictionary *params = @{@"child_id" : childID,@"screening_id" : screeningID };
//    [[ConnectionsManager sharedManager] getDevelopmentCheckList:params withdelegate:self];
//}
//
//
//#pragma mark - ServerResponseDelegate
//-(void)success:(id)response
//{
//    NSLog(@"Response of get child dev screening : %@",response);
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        NSDictionary *responseDict = (NSDictionary *)response;
//        if ([responseDict[@"status"] boolValue]) {
//
//            if ([responseDict[@"data"] count] > 0) {
//                allChildArray = responseDict[@"data"];
//                [self sortDataWithAge:12.0];
//
//
//            }
//        }
//        else
//        {
//            [Constants showOKAlertWithTitle:@"Error" message:@"Unable to get the list of child developemental, Please try after some time" presentingVC:self];
//        }
//
//    });
//}
//
//-(void)failure:(id)response
//{
//    NSLog(@"Error of get child dev screening : %@",response);
//
//}

#pragma mark - sorting data by Age

-(void)sortDataWithAge:(float)age
{
    NSMutableArray *sortedList = [NSMutableArray new];
    
    for(NSDictionary *sectionDict in allChildArray )
    {
        NSArray * items = sectionDict[@"items"];
        NSMutableArray *sortedItems = [NSMutableArray new];
        
        for (NSDictionary *itemDict in items) {
            NSLog(@"Child Dict : %@",itemDict);
            if ([itemDict[@"age"] isKindOfClass:[NSDictionary class]]) {
                NSLog(@"%@ %@",sectionDict,itemDict);
            }
            NSString *childAge = (NSString *)itemDict[@"age"];
            
            
            NSRange searchFromRange = [childAge rangeOfString:@"e"];
            NSRange searchToRange = [childAge rangeOfString:@"M"];
            NSString *substring = [childAge substringWithRange:NSMakeRange(searchFromRange.location+searchFromRange.length, searchToRange.location-searchFromRange.location-searchFromRange.length)];
            NSString *agestr = [substring stringByReplacingOccurrencesOfString:@" " withString:@""];
            if ([agestr floatValue] <= age) {
                [sortedItems addObject:itemDict];
            }
            
            
        }
        
        if([sortedItems count] > 0){
            
            NSDictionary *sortedDict = @{@"id" :sectionDict[@"id"],
                                         @"title":sectionDict[@"title"],
                                         @"items": sortedItems
                                         
                                         };
            
            [sortedList addObject:sortedDict];
            
        }
    }
    
    childDevelopemntalScreeningArray = sortedList;
    [self.tableView reloadData];
}

@end
