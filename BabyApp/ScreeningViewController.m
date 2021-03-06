//
//  ScreeningViewController.m
//  BabyApp
//
//  Created by Atul Awasthi on 07/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "ScreeningViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ConnectionsManager.h"
#import "ScreeningDevCheckListObj.h"
#import "ScreeningParentalViewController.h"
#import "NSUserDefaults+Helpers.h"
#import "WSConstant.h"
#import "ScreeningSummaryData.h"
#import "CustomIOS7AlertView.h"
#import "DateTimeUtil.h"
#import "NIDropDown.h"

@interface ScreeningViewController () <ServerResponseDelegate , CustomIOS7AlertViewDelegate,NIDropDownDelegate>
{
    NSArray *personalSocialList, *fineMotorList, *languageList, *grossMotorList;
    NSMutableArray *allChildDevList;
    UIButton *txtDate;
    CustomIOS7AlertView *dateAlertView;
    UIDatePicker *datePicker;
    UILabel *lblHeading;
    UITextField *txtAge,*txtCare;
    
    NSArray *labelArray;

    
    NSArray *screeningSummaryList;
    int currentScreening;
    NIDropDown *dropDown;

}
@property  UIButton *drpDownBtn;
- (IBAction)doneBtnClicked:(id)sender;
@end

@implementation ScreeningViewController
@synthesize screeningTable,drpDownBtn;

- (IBAction)doneBtnClicked:(id)sender
{
    NSLog(@"doneBtnClicked");
    
    [self toStopEditing];
    NSString *dt=[txtDate titleForState:UIControlStateNormal];
    NSString *careGiver=[txtCare text];
    NSString *age=[txtAge text];
    
    if(![dt isEqualToString:@"Date of Screening"]&&![careGiver isEqualToString:@"  Main Caregiver"]&&![careGiver isEqualToString:@"Age"])
    {
    ScreeningSummaryData *screen =[screeningSummaryList objectAtIndex:currentScreening];
   [[NSUserDefaults standardUserDefaults] setObject:screen.screening_id forKey:@"screening_id"];
    
    NSString *childStr = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if(childStr && childStr != nil)
    {
        [dict setObject:childStr forKey:@"child_id"];
        
    }
    [dict setObject:screen.screening_id forKey:@"screening_id"];
    [dict setObject:dt forKey:@"screening_date"];
    [dict setObject:careGiver forKey:@"screening_caregiver"];
    [dict setObject:age forKey:@"screening_age"];
    
    NSLog(@"Final information to send=%@",dict);

   [[ConnectionsManager sharedManager] updateScreening:dict withdelegate:self];
    }
else
{
    UIAlertView *alt1 =[[UIAlertView alloc] initWithTitle:@"Sorry"  message:@"Sorry input all fields" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alt1 show];
    
}
  }
-(void)toStopEditing
{
    [self.view endEditing:YES];
}
//
-(void)dropDownBtnClicked:(UIButton*)sender
{
    if(screeningSummaryList.count>0)
    [self openDropdown:screeningSummaryList withSender:sender withDir:@"down"];
}

-(void)openDropdown:(NSArray*)array withSender:(id)sender withDir:(NSString *)dir
{
    if(dropDown == nil) {
        CGFloat f = 150;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :array :nil :dir];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender withData:(id)Data_ {
    [self rel];
    
    if([Data_ isKindOfClass:[NSString class]])
    {
        NSString *cat = Data_;
        currentScreening=(int)[screeningSummaryList indexOfObject:cat];
        [drpDownBtn setTitle:cat forState:UIControlStateNormal];
        
        ScreeningSummaryData *screen =[screeningSummaryList objectAtIndex:currentScreening];
       
        [txtDate setTitle:screen.due_date forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:screen.screening_id forKey:@"screening_id"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:screen.screening_id forKey:@"screening_id"];
        [[NSUserDefaults standardUserDefaults] setObject:screen.screening_id forKey:@"selectedScreenId"];
        [[ConnectionsManager sharedManager] readScreening:dict withdelegate:self];
        

        
        
    }
   
}

-(void)rel{
    dropDown = nil;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    currentScreening=0;
    
    allChildDevList = [NSMutableArray array];
    
    
   // [self loadData];
    
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIFont boldSystemFontOfSize:20] forKey:UITextAttributeFont];
    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
    
    labelArray=[NSArray arrayWithObjects:@"DEVELOPMENTAL CHECKLIST",@"Personal Social",@"Fine Motor-Adaptive",@"Language",@"Gross Motor",@"GROWTH",@"OTHER SCREENING",@"PHYSICAL EXAMINATION",@"OUTCOME EXAMINATION", nil];
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 45)];
    [v setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:240.0/255.0 alpha:1.0]];
    [self.view addSubview:v];
    
    lblHeading=[[UILabel alloc] initWithFrame:CGRectMake(30,10, v.frame.size.width-60, 30)];
    [v addSubview:lblHeading];
    
    [lblHeading setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi"
                                        size:15]];
    //[lblHeading setText:@"6 MONTHS TO 12 MONTHS"];
    
    
   
    
    
    
    [lblHeading setTextColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    [lblHeading setTextAlignment:NSTextAlignmentCenter];
    
    UIButton *drpDownBtn1 = [[UIButton alloc] init];
    
    [drpDownBtn1 setFrame:CGRectMake(0,75,v.frame.size.width, v.frame.size.height)];
    [drpDownBtn1 setBackgroundColor:[UIColor whiteColor]];
    
     [self.view addSubview:drpDownBtn1];
    [drpDownBtn1 setTitleColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [drpDownBtn1.titleLabel setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi"
                                                    size:15]];
    [drpDownBtn1 addTarget:self action:@selector(dropDownBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [drpDownBtn1 setTitle:@"6-8 Months" forState:UIControlStateNormal];
    
   /*  UIButton *imgNext = [[UIButton alloc] init];

    [imgNext setFrame:CGRectMake(10, 15, 10, 10)];
    [imgNext setBackgroundImage:[UIImage imageNamed:@"previousAppBg"] forState:UIControlStateNormal];
    [v addSubview:imgNext];
    
    UIButton *imgPrevious = [[UIButton alloc] init];

    [imgPrevious setFrame:CGRectMake(v.frame.size.width-25, 15, 10, 10)];
    [imgPrevious setBackgroundImage:[UIImage imageNamed:@"nextAppColor"] forState:UIControlStateNormal];

    [v addSubview:imgPrevious];
    
    [imgNext addTarget:self action:@selector(btnPrevious) forControlEvents:UIControlEventTouchUpInside];
    
    [imgPrevious addTarget:self action:@selector(btnNext) forControlEvents:UIControlEventTouchUpInside];
    
    */
    
    
    UIView *v2=[[UIView alloc] initWithFrame:CGRectMake(25, v.frame.origin.y+v.frame.size.height+20, self.view.frame.size.width-50, 90)];
    [v2 setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:240.0/255.0 alpha:1.0]];
    [self.view addSubview:v2];
    [[v2 layer] setCornerRadius:5];
    
    
    UIView *vLine=[[UIView alloc] initWithFrame:CGRectMake(0, v2.frame.size.height/2-0.3, v2.frame.size.width,.25)];
    [vLine setBackgroundColor:[UIColor grayColor]];
    [v2 addSubview:vLine];
    [v2 setAlpha:0.5];
    
    UIView *hLine=[[UIView alloc] initWithFrame:CGRectMake((v2.frame.size.width*70)/100,0,0.6,v2.frame.size.height/2)];
    [hLine setBackgroundColor:[UIColor grayColor]];
    [v2 addSubview:hLine];
    
    
    
    txtDate=[UIButton buttonWithType:UIButtonTypeCustom];
    txtDate.frame = CGRectMake(8,0, (v2.frame.size.width*70)/100-15, v2.frame.size.height/2);
    [txtDate addTarget:self action:@selector(onClickDateOfBirth:) forControlEvents:UIControlEventTouchUpInside];
    txtDate.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    
    txtAge=[[UITextField alloc] initWithFrame:CGRectMake((v2.frame.size.width*70)/100+8,0,(v2.frame.size.width*30)/100-15,v2.frame.size.height/2)];
    
    txtCare=[[UITextField alloc] initWithFrame:CGRectMake(8,v2.frame.size.height/2,v2.frame.size.width-15,v2.frame.size.height/2)];
    
    [v2 addSubview:txtDate];
    [v2 addSubview:txtAge];
    [v2 addSubview:txtCare];
    
    [txtDate.titleLabel setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15]];
    txtDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [txtAge setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15]];
    [txtCare setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15]];
    
    [txtDate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [txtDate setTitle:@"Date of Screening" forState:UIControlStateNormal];
      NSAttributedString *str=[[NSAttributedString alloc] initWithString:@"  Main Caregiver" attributes:@{
                                                                                                      NSForegroundColorAttributeName: [UIColor blackColor],
                                                                                                      NSFontAttributeName : [UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15]
                                                                                                      }];
    txtCare.attributedPlaceholder=str;
    txtAge.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Age"
                                    attributes:@{
                                                 NSForegroundColorAttributeName: [UIColor blackColor],
                                                 NSFontAttributeName : [UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15]
                                                 }
     ];

    

    
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-180, v2.frame.origin.y+v2.frame.size.height+10, 150, 30)];
    [self.view addSubview:lbl];
    [lbl setText:@"Parental Concerns"];
    [lbl setTextColor:[UIColor colorWithRed:242.0/255.0 green:176.0/255.0 blue:42.0/255.0 alpha:1.0]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    
    
    //parentControlInfo
    UIImageView *imgParent = [[UIImageView alloc] init];
    [imgParent setFrame:CGRectMake(self.view.frame.size.width-190, v2.frame.origin.y+v2.frame.size.height+18, 15, 15)];
    [imgParent setImage:[UIImage imageNamed:@"parentControlInfo"]];
    [self.view addSubview:imgParent];
    
    
    screeningTable=[[UITableView alloc] initWithFrame:CGRectMake(0, lbl.frame.origin.y+lbl.frame.size.height+10, self.view.frame.size.width, self.view.frame.size.height-(lbl.frame.origin.y+lbl.frame.size.height+20))];
    [self.view addSubview:screeningTable];
    screeningTable.dataSource=self;
    screeningTable.delegate=self;
    
    
     [self loadScreeningData];
    
}




-(void)loadScreeningData
{
    NSString *childStr = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if(childStr && childStr != nil)
    {
        [dict setObject:childStr forKey:@"child_id"];
    
    [[ConnectionsManager sharedManager] getScreeningSummary:dict withdelegate:self];
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Stores"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Stores"];
        
        
        UILabel *lblName=nil;
        
        lblName=[[UILabel alloc] initWithFrame:CGRectMake(10,00, screeningTable.frame.size.width-50, 30)];
        lblName.tag=10;
        [cell.contentView addSubview:lblName];
        //AvenirNextLTPro-MediumCn
        //HelveticaNeueCyr-Light
        
        
        UIImageView *ivIcon=[[UIImageView alloc] initWithFrame:CGRectMake(10,12.5,25,25)];
        ivIcon.image=[UIImage imageNamed:@"notepad_white"];
        ivIcon.tag=20;
        [cell.contentView addSubview:ivIcon];
        [ivIcon setContentMode:UIViewContentModeScaleAspectFill];
        [ivIcon setClipsToBounds:YES];
        [ivIcon setHidden:YES];
        
        
    }
    UILabel *lblName=[cell.contentView viewWithTag:10];
    UIImageView *ivIcon=[cell.contentView viewWithTag:20];
   // if(indexPath.row==0||indexPath.row==5||indexPath.row==6)
        if(indexPath.row==0||indexPath.row>=5)

    {
        [lblName setFont:[UIFont fontWithName:@"AvenirNextLTPro-Bold" size:13]];
        [cell setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
        [lblName setTextColor:[UIColor whiteColor]];
        [ivIcon setHidden:NO];
        lblName.frame=CGRectMake(50,15, screeningTable.frame.size.width-100, 30);
    }
    else
    {
        [lblName setFont:[UIFont fontWithName:@"Helvetica-Neue-LT" size:10]];
        [cell setBackgroundColor:[UIColor whiteColor]];
        [lblName setTextColor:[UIColor grayColor]];
        [ivIcon setHidden:YES];
        lblName.frame=CGRectMake(15,10, screeningTable.frame.size.width-50, 30);
        
    }
    
    if(indexPath.row==0){
        [cell setTintColor:[UIColor whiteColor]];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    else
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    [lblName setText:[labelArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:( NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] setObject:[labelArray objectAtIndex:indexPath.row] forKey:@"selectedScreenLbl"];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"didDeselectRowAtIndexPath");
    if(indexPath.row==7)
        [self performSegueWithIdentifier:@"screeningexaminationsegue" sender:self];
    else if(indexPath.row==8)
        [self performSegueWithIdentifier:@"screeningoutcomeoptionsegu" sender:self];
    else if(indexPath.row==6)
        [self performSegueWithIdentifier:@"otherscreensegu" sender:self];
    else if(indexPath.row==5)
        [self performSegueWithIdentifier:@"growthsegu" sender:self];
    else
        [self performSegueWithIdentifier:@"parentalconcernsegu" sender:self];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return labelArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"accessoryButtonTappedForRowWithIndexPath at row=%ld",(long)indexPath.row);
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"parentalconcernsegu"])
    {
        // Get reference to the destination view controller
        ScreeningParentalViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        NSString *titleStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedScreenLbl"];
        if([titleStr isEqualToString:@"Gross Motor"])
        {
            [vc setListOfObjects:grossMotorList];
        }
        else if([titleStr isEqualToString:@"Language"])
        {
            [vc setListOfObjects:languageList];
        }
        else if([titleStr isEqualToString:@"Fine Motor-Adaptive"])
        {
            [vc setListOfObjects:fineMotorList];
        }
        else if([titleStr isEqualToString:@"Personal Social"])
        {
            [vc setListOfObjects:personalSocialList];
        }
        else if([titleStr isEqualToString:@"DEVELOPMENTAL CHECKLIST"])
        {
            [vc setListOfObjects:allChildDevList];
        }
    }
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

-(void)loadData:(NSDictionary*)dict
{
  
    
    [[ConnectionsManager sharedManager] getDevelopmentCheckList:dict withdelegate:self];
}

-(void)success:(id)response
{
    /*
     {
     data =     (
     {
     id = 1;
     items =             (
     {
     age = "Age 4.5 Months";
     id = 1;
     status = 0;
     title = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
     },
     {
     age = "Age 5.5 Months";
     id = 2;
     status = 0;
     title = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
     }
     );
     title = "Personal Social";
     },
     {
     id = 2;
     items =             (
     {
     age = "Age 6.5 Months";
     id = 3;
     status = 0;
     title = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
     },
     {
     age = "Age 7 Months";
     id = 4;
     status = 0;
     title = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
     }
     );
     title = "Fine Motor-Adaptive";
     },
     {
     id = 3;
     items =             (
     {
     age = "Age 8 Months";
     id = 5;
     status = 0;
     title = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
     },
     {
     age = "Age 7 Months";
     id = 6;
     status = 0;
     title = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
     }
     );
     title = Language;
     },
     {
     id = 4;
     items =             (
     {
     age = "Age 8 Months";
     id = 7;
     status = 0;
     title = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
     },
     {
     age = "Age 7 Months";
     id = 8;
     status = 0;
     title = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
     }
     );
     title = "Gross Motor";
     }
     );
     message = success;
     status = 1;
     }
     */
    
    
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
        id dataList_ = [dict objectForKey:@"data"];
        if([dataList_ isKindOfClass:[NSDictionary class]])
        {
            
                if ([[dataList_ allKeys] containsObject:@"caregiver"])
                {
               // if([dataList_ valueForKey:@"caregiver"] != nil)
               // {
                    NSLog(@"Second api result with screenoing id data recived");
                    [self getDevelopmentalDataOfParticularScreeningId:dataList_];
                }
                else
                {
            NSLog(@"First api result with screenoing id list recived");
            NSArray *itemsArray = [dataList_ objectForKey:@"summary"];
            if(itemsArray.count)
            {
                NSMutableArray *temp = [NSMutableArray array];
                
                for(NSDictionary *itemDict in itemsArray)
                {
                    ScreeningSummaryData *screen = [[ScreeningSummaryData alloc] init];
                    screen.screening_id = [itemDict objectForKey:@"screening_id"];
                    screen.title = [itemDict objectForKey:@"title"];
                    screen.taken_date = [itemDict objectForKey:@"taken_date"];
                    screen.status = [itemDict objectForKey:@"status"];
                    screen.remainder_date = [itemDict objectForKey:@"remainder_date"];
                    screen.due_date = [itemDict objectForKey:@"due_date"];
                    
                    [temp addObject:screen];
                }
                
                screeningSummaryList = temp;
                
                if(screeningSummaryList.count>0)
                {
                    currentScreening=0;

                    [self setHeaderLabelFor:currentScreening];
                    
                    
                }

            }
        }
        }
        else if ([dataList_ isKindOfClass:[NSArray class]])
        {
            NSLog(@"third api result with screenoing Result recived");

            NSArray *dataList = dataList_;
            if(dataList.count)
            {
                
                for(NSDictionary *dataDict in dataList)
                {
                    
                    NSArray *itemsArray = [dataDict objectForKey:@"items"];
                    if(itemsArray.count)
                    {
                        NSMutableArray *temp = [NSMutableArray array];
                        
                        for(NSDictionary *itemDict in itemsArray)
                        {
                        ScreeningDevCheckListObj *screen = [[ScreeningDevCheckListObj alloc] init];
                            screen.age = [itemDict objectForKey:@"age"];
                            screen.screenID = [itemDict objectForKey:@"id"];
                            screen.title = [itemDict objectForKey:@"title"];
                            screen.status = [itemDict objectForKey:@"status"];
                            
                            [temp addObject:screen];
                            
                            [allChildDevList addObject:screen];
                        }
                        
                        NSString *titleStr = [dataDict objectForKey:@"title"];
                        if([titleStr isEqualToString:@"Gross Motor"])
                        {
                            grossMotorList = temp;
                            
                        }
                        else if([titleStr isEqualToString:@"Language"])
                        {
                            languageList = temp;
                        }
                        else if([titleStr isEqualToString:@"Fine Motor-Adaptive"])
                        {
                            fineMotorList = temp;
                        }
                        else if([titleStr isEqualToString:@"Personal Social"])
                        {
                            personalSocialList = temp;
                        }
                    }
                }
                
            }
        }
    }
}

-(void)btnPrevious
{
     NSLog(@"btnPrevious currentScreening=%d screeningSummaryList.count=%ld",currentScreening,screeningSummaryList.count);
    if(screeningSummaryList.count>0)
    {
    if(currentScreening>0)
    {
        currentScreening--;
        [self setHeaderLabelFor:currentScreening];
    }
    }
}
-(void)btnNext
{
    NSLog(@"btnNext currentScreening=%d screeningSummaryList.count=%ld",currentScreening,screeningSummaryList.count);
    if(screeningSummaryList.count>0)
    {
    if(currentScreening<screeningSummaryList.count-1)
    {
        currentScreening++;
        [self setHeaderLabelFor:currentScreening];
    }
    }
}

-(void)setHeaderLabelFor:(int)pos
{
    NSLog(@"setheader pos=%d",pos);
    
    ScreeningSummaryData *screen =[screeningSummaryList objectAtIndex:pos];
    [lblHeading setText:screen.title];
   // if(![[NSUserDefaults standardUserDefaults] boolForKey:@"NewScreening"])
  //  {
    [txtDate setTitle:screen.due_date forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setObject:screen.screening_id forKey:@"screening_id"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:screen.screening_id forKey:@"screening_id"];
    [[NSUserDefaults standardUserDefaults] setObject:screen.screening_id forKey:@"selectedScreenId"];
    [[ConnectionsManager sharedManager] readScreening:dict withdelegate:self];
 //   }

  }
-(void)getDevelopmentalDataOfParticularScreeningId:(NSDictionary*)screenigDt
{
   // if([[screenigDt objectForKey:@"caregiver"] length]>0&&![[screenigDt objectForKey:@"caregiver"] isEqualToString:@""])
   // {
        
    NSString *childStr = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[screenigDt objectForKey:@"id"] forKey:@"screening_id"];
    [dict setObject:childStr forKey:@"child_id"];
    txtAge.text=[screenigDt objectForKey:@"age"];
    txtCare.text=[NSString stringWithFormat:@"  %@",[screenigDt objectForKey:@"caregiver"]];
    
    [self loadData:dict];
  //  }
}



-(void)failure:(id)response
{
    NSLog(@"failure");
}


-(void)onClickDateOfBirth:(id)sender
{
    [self.view endEditing:YES];
    
    [self openDate];
}

-(void)openDate
{
    dateAlertView = [[CustomIOS7AlertView alloc] init];
    [dateAlertView setContainerView:[self createDateView]];
    [dateAlertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Close", @"Set", nil]];
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
    [txtDate setTitle:dateFromData forState:UIControlStateNormal];
}


@end
