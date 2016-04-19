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
    // Do any additional setup after loading the view.
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [self.slider setNumberFormatter:formatter];
    
    _slider.minimumValue = 1;
    _slider.maximumValue = 12;
    _slider.popUpViewCornerRadius = 12.0;
    [_slider setMaxFractionDigitsDisplayed:0];
    //    slider.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    _slider.popUpViewColor = [UIColor darkGrayColor];
    
    _slider.font = [UIFont boldSystemFontOfSize:16];
    _slider.textColor = [UIColor whiteColor];
    _slider.dataSource = self;
    self.title = @"Child Developemental Screening";
    
    /*childDevelopemntalScreeningArray = @[
     @{@"title":@"type of screening",
     @"items":@[@"ajsdhgasdgajshgd ajsdhgas dahjgd",
     @"jahgd asjdhgas dajsgd adasjgd ajdgasd ajghsd ajdgasj dasdgas dajshgd asjdghas dajshgdas dgasd asjhgdas dgas dasjghd",
     @"dkajdhgasd a ajgsd asdg"
     
     ]
     },
     @{@"title":@"type of screening",
     @"items":@[@"ajsdhgasdgajshgd ajsdhgas dahjgd",
     @"jahgd asjdhgas dajsgd adasjgd ajdgasd ajghsd ajdgasj dasdgas dajshgd asjdghas dajshgdas dgasd asjhgdas dgas dasjghd",
     @"dkajdhgasd a ajgsd asdg hsdgf sdhfgsd fgs fsdhjgf sd"
     
     ]
     }
     
     
     ];*/
    [self getChildDevevelopementals];
    
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
    [self sortDataWithAge:value];
    return s;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return childDevelopemntalScreeningArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    NSDictionary *childDevelopmentalDict = childDevelopemntalScreeningArray[section];
    return  [childDevelopmentalDict[@"items"] count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSDictionary *childDevelopmentalDict = childDevelopemntalScreeningArray[indexPath.section];
    NSString *screeningText =  childDevelopmentalDict[@"items"][indexPath.row];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
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
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *childDevelopmentalDict = childDevelopemntalScreeningArray[section];
    NSString *sectionTitle =  childDevelopmentalDict[@"title"];
    return sectionTitle;
}


#pragma  mark - get child developemenatal screening

-(void)getChildDevevelopementals
{
    //    NSString *screeningID = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    
    NSString *screeningID = @"1";
    
    NSString *childID = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    NSString *userId  = [NSUserDefaults retrieveObjectForKey:USERID];
    childID = @"1";
    NSDictionary *params = @{@"child_id" : childID,@"screening_id" : screeningID };
    [[ConnectionsManager sharedManager] getDevelopmentCheckList:params withdelegate:self];
}


#pragma mark - ServerResponseDelegate
-(void)success:(id)response
{
    NSLog(@"Response of get child dev screening : %@",response);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSDictionary *responseDict = (NSDictionary *)response;
        if ([responseDict[@"status"] boolValue]) {
            
            if ([responseDict[@"data"] count] > 0) {
                allChildArray = responseDict[@"data"];
                [self sortDataWithAge:12.0];
                
                
            }
        }
        else
        {
            [Constants showOKAlertWithTitle:@"Error" message:@"Unable to get the list of child developemental, Please try after some time" presentingVC:self];
        }
        
    });
}

-(void)failure:(id)response
{
    NSLog(@"Error of get child dev screening : %@",response);
    
}

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
