//
//  PercentialViewController.m
//  BabyApp
//
//  Created by Charan Giri on 15/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "PercentialViewController.h"

#import "SHLineGraphView.h"
#import "SHPlot.h"

@interface PercentialViewController ()

@end

@implementation PercentialViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _titleLabel.text=_titleLableString;
    _subTitleLabel.text=_subTitleLableString;
    self.title=_titleString;
    [self graphCreation];

}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *header = @"customHeader";
    
    UITableViewHeaderFooterView *vHeader;
    
    vHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:header];
    
    if (!vHeader) {
        vHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:header];
    }
    
    NSString *sectionName;
    
    switch (section)
    {
        case 0:
            sectionName = @"SUMMARY";
            break;
            
        default:
            sectionName = @"";
            break;
    }
    vHeader.textLabel.text = sectionName;
    vHeader.backgroundColor=[UIColor whiteColor];
    vHeader.textLabel.textColor=[UIColor colorWithRed:103/255.0f green:231/255.0f blue:223/255.0f alpha:1.0f];
    
    return vHeader;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    
    if (indexPath.row==0) {
        cell.textLabel.text=@"Age";
        cell.detailTextLabel.text=@"6";
    }
    else if (indexPath.row==1)
    {
        NSString *text=[NSString stringWithFormat:@"%@(%@)",_titleString,_suffix];
        cell.textLabel.text=text;
        cell.detailTextLabel.text=@"35";
    }
    else
    {
        cell.textLabel.text=@"Percentile";
        cell.detailTextLabel.text=@"15%";
        cell.detailTextLabel.textColor=[UIColor redColor];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self performSegueWithIdentifier:@"ImmunisationsSegue" sender:self];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)graphCreation
{
    SHLineGraphView *_lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(10,30, 340, 320)];
    
    //set the main graph area theme attributes
    
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"HelveticaNeueCyr-Light" size:12],
                                       kYAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"HelveticaNeueCyr-Light" size:12],
                                       kYAxisLabelSideMarginsKey : @20,
                                       kPlotBackgroundLineColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kDotSizeKey : @5
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    
    //set the line graph attributes
    
    _lineGraph.yAxisRange = @(12);
    
    
    _lineGraph.yAxisSuffix = _suffix;
    
    
    _lineGraph.xAxisValues = @[
                               @{ @1 : @"" },
                               @{ @2 : @"" },
                               @{ @3 : @"" },
                               @{ @4 : @"" },
                               @{ @5 : @"" },
                               @{ @6 : @"" },
                               @{ @7 : @"" },
                               @{ @8 : @"" },
                               @{ @9 : @"" },
                               @{ @10 : @"" },
                               @{ @11 : @"" },
                               @{ @12 : @"" }
                               ];
    
    //create a new plot object that you want to draw on the `_lineGraph`
    SHPlot *_plot1 = [[SHPlot alloc] init];
    
    //set the plot attributes
    
    
    _plot1.plottingValues = @[
                              @{ @1 : @0 },
                              @{ @2 : @2 },
                              @{ @3 : @3 },
                              @{ @4 : @2 },
                              @{ @5 : @1.3 },
                              @{ @6 : @5.8 },
                              @{ @7 : @6 },
                              @{ @8 : @7 },
                              @{ @9 : @5 },
                              @{ @10 : @10 },
                              @{ @11 : @7 },
                              @{ @12 : @3 }
                              ];
    
    NSArray *arr = @[@"1", @"2", @"3", @"111", @"5", @"6" , @"7" , @"8", @"9", @"10", @"11", @"12"];
    _plot1.plottingPointsLabels = arr;
    
    
    
    NSDictionary *_plotThemeAttributes = @{
                                           kPlotFillColorKey : [UIColor colorWithRed:0.56 green:0.88 blue:0.73 alpha:1],
                                           kPlotStrokeWidthKey : @2,
                                           kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointFillColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"HelveticaNeueCyr-Light" size:18]
                                           };
    
    _plot1.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot1];
    
    
    SHPlot *_plot2 = [[SHPlot alloc] init];
    
    
    _plot2.plottingValues = @[
                              @{ @1 : @5 },
                              @{ @2 : @12 },
                              @{ @3 : @3 },
                              @{ @4 : @5 },
                              @{ @5 : @6 },
                              @{ @6 : @7 },
                              @{ @7 : @8 },
                              @{ @8 : @3 },
                              @{ @9 : @5 },
                              @{ @10 : @9 },
                              @{ @11 : @2 },
                              @{ @12 : @8 }
                              ];
    
    
    NSArray *arr1 = @[@"1", @"2", @"3", @"98", @"5", @"6" , @"7" , @"8", @"9", @"10", @"11", @"12"];
    _plot2.plottingPointsLabels = arr1;
    
    NSDictionary *_plotThemeAttributes1 = @{
                                            kPlotFillColorKey : [UIColor colorWithRed:0.56 green:0.88 blue:0.73 alpha:1],
                                            kPlotStrokeWidthKey : @2,
                                            kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                            kPlotPointFillColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                            kPlotPointValueFontKey : [UIFont fontWithName:@"HelveticaNeueCyr-Light" size:18]
                                            };
    
    _plot1.plotThemeAttributes = _plotThemeAttributes1;
    [_lineGraph addPlot:_plot2];
    
    
    //You can as much `SHPlots` as you can in a `SHLineGraphView`
    
    [_lineGraph setupTheView];
    
    [_baseView addSubview:_lineGraph];
    
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
