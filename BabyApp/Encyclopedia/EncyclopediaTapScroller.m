//
//  EncyclopediaTapScroller.m
//  BabyApp
//
//  Created by Atul Awasthi on 16/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "EncyclopediaTapScroller.h"
#import "KeyConstants.h"
#import "ConnectionsManager.h"
#import "EncycloItemData.h"
#import "EncyclopediaData.h"
#import "EncycloMedicationData.h"

@interface EncyclopediaTapScroller ()<ServerResponseDelegate, UITextFieldDelegate, UISearchBarDelegate>
{
    UISearchBar *search;
    
    UISearchBar *search2;
}
@property UIScrollView *scroll1;
@property UIPageControl *page1;
@property NSArray *medicationArr,*medicationDictArr,*immunisationArr, *medicationArrHolder, *immunisationArrHolder,*immunisationDictArr;

@end

@implementation EncyclopediaTapScroller
@synthesize scrollerTable,scrollerTable2,scroll1,page1,immunisationDictArr,medicationDictArr;
NSArray *labelArrayScroller,*labelArrayScroller2;

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    //  NSInteger page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    NSInteger page = scrollView.contentOffset.x / width;
    
    [page1 setCurrentPage:page];
    
    self.navigationItem.title = [hed objectAtIndex:page];
    
    NSLog(@"current page=%ld",(long)page1.currentPage);
}

NSArray *hed;
int n;
- (void)viewDidLoad {
    [super viewDidLoad];
    hed=@[@"Medication",@"Immunisation"];
    self.navigationItem.title = [hed objectAtIndex:0];
    n=1;
    [[ConnectionsManager sharedManager] getMedicationEncyclopedia:nil withdelegate:self];
    
    
    
    // labelArrayScroller=[NSArray arrayWithObjects:@"ANTIHISTAMINES",@"FEVER MEDICATIONS",@"COUGH EXPETORANTS",@"MUCOLYTICS",@"MIXED COUGH PREPARATIONS",@"NASAL",@"LOZENGES",@"ANTINIOTICS",@"ANTIEMETICS",@"ANTISPAMODIC",@"TOPICAL", nil];
    
    //   labelArrayScroller2=[NSArray arrayWithObjects:@"BCG",@"HEPATITIS B",@"DTAP",@"MMR", nil];
    
    CGRect scrollFrame = CGRectMake(0, 0, [self.view bounds].size.width, [self.view bounds].size.height);
    scroll1 = [[UIScrollView alloc]initWithFrame: scrollFrame];
    
    [self.view addSubview:scroll1];
    [scroll1 setBackgroundColor:[UIColor blueColor]];
    
    scroll1.delegate=self;
    
    UIView *v1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, scroll1.frame.size.width, scroll1.frame.size.height)];
    [scroll1 addSubview:v1];
    [v1 setBackgroundColor:[UIColor redColor]];
    
    UIView *v2=[[UIView alloc] initWithFrame:CGRectMake(scroll1.frame.size.width, 0, scroll1.frame.size.width, scroll1.frame.size.height)];
    
    NSLog(@"self.view height=%f scrollbar height=%f v1 hight=%f",self.view.frame.size.height,scroll1.frame.size.height,v1.frame.size.height);
    [scroll1 addSubview:v2];
    [scroll1 setContentSize:CGSizeMake(scroll1.frame.size.width*2, scroll1.frame.size.height)];
    [v1 setBackgroundColor:[UIColor redColor]];
    [v2 setBackgroundColor:[UIColor greenColor]];
    
    [scroll1 setBounces:NO];
    
    [scroll1 setPagingEnabled:YES];
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 0,scroll1.frame.size.width, 220)];
    [v setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    [v1 addSubview:v];
    
    UILabel *lbl1=[[UILabel alloc] initWithFrame:CGRectMake(60,30, self.view.frame.size.width-120, 45)];
    [v addSubview:lbl1];
    
    [lbl1 setLineBreakMode:NSLineBreakByWordWrapping];
    [lbl1 setNumberOfLines:2];
    
    search=[[UISearchBar alloc] initWithFrame:CGRectMake(30,90, self.view.frame.size.width-60,35)];
    [search setDelegate:self];
    
    [v addSubview:search];
    
    search.barTintColor = [UIColor whiteColor];
    [search setPlaceholder:@"Name or Keyword"];
    
    UIView *vLine=[[UIView alloc] initWithFrame:CGRectMake(0, 155, self.view.frame.size.width,2)];
    [vLine setBackgroundColor:[UIColor whiteColor]];
    [v addSubview:vLine];
    
    
    UILabel *lblOr=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-20,145, 50, 30)];
    [v addSubview:lblOr];
    
    [lblOr setText:@"OR"];
    
    [lblOr setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    
    [lblOr setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular"
                                   size:12]];
    [lblOr setTextAlignment:NSTextAlignmentCenter];
    
    [lblOr setTextColor:[UIColor whiteColor]];
    
    
    UILabel *lbl2=[[UILabel alloc] initWithFrame:CGRectMake(10,170, self.view.frame.size.width-20, 40)];
    [v addSubview:lbl2];
    
    [lbl1 setText:@"Type in for a quick search in the database"];
    [lbl2 setText:@"SEARCH BY CATEGORIES BELOW"];
    
    // [lblCircum1 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi" size:12]];
    
    
    [lbl1 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular"
                                  size:20]];
    
    
    [lbl2 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular"
                                  size:16]];
    
    [lbl1 setTextAlignment:NSTextAlignmentCenter];
    [lbl2 setTextAlignment:NSTextAlignmentCenter];
    
    [lbl1 setTextColor:[UIColor whiteColor]];
    [lbl2 setTextColor:[UIColor whiteColor]];
    
    UIView *vv2=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 220)];
    [vv2 setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    [v2 addSubview:vv2];
    
    UILabel *lbl12=[[UILabel alloc] initWithFrame:CGRectMake(60,30, self.view.frame.size.width-120, 45)];
    [vv2 addSubview:lbl12];
    
    [lbl12 setLineBreakMode:NSLineBreakByWordWrapping];
    [lbl12 setNumberOfLines:2];
    
    search2=[[UISearchBar alloc] initWithFrame:CGRectMake(30,90, self.view.frame.size.width-60,35)];
    [vv2 addSubview:search2];
    [search2 setDelegate:self];
    search2.barTintColor = [UIColor whiteColor];
    [search2 setPlaceholder:@"Name or Keyword"];
    
    
    
    UIView *vLine2=[[UIView alloc] initWithFrame:CGRectMake(0, 155, self.view.frame.size.width,2)];
    [vLine2 setBackgroundColor:[UIColor whiteColor]];
    [vv2 addSubview:vLine2];
    
    
    UILabel *lblOr2=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-20,145, 50, 30)];
    [vv2 addSubview:lblOr2];
    
    [lblOr2 setText:@"OR"];
    
    [lblOr2 setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    
    [lblOr2 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular"
                                    size:12]];
    [lblOr2 setTextAlignment:NSTextAlignmentCenter];
    
    [lblOr2 setTextColor:[UIColor whiteColor]];
    
    
    
    UILabel *lbl22=[[UILabel alloc] initWithFrame:CGRectMake(10,170, self.view.frame.size.width-20, 40)];
    [vv2 addSubview:lbl22];
    
    [lbl12 setText:@"Type in for a quick search in the database"];
    [lbl22 setText:@"SEARCH BY CATEGORIES BELOW"];
    
    
    [lbl12 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular"
                                   size:20]];
    
    
    [lbl22 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular"
                                   size:16]];
    
    
    [lbl12 setTextAlignment:NSTextAlignmentCenter];
    [lbl22 setTextAlignment:NSTextAlignmentCenter];
    
    [lbl12 setTextColor:[UIColor whiteColor]];
    [lbl22 setTextColor:[UIColor whiteColor]];
    
    
    scrollerTable=[[UITableView alloc] initWithFrame:CGRectMake(0, v.frame.origin.y+v.frame.size.height, self.view.frame.size.width, (self.view.frame.size.height-(v.frame.origin.y+v.frame.size.height))-50)];
    [v1 addSubview:scrollerTable];
    
    scrollerTable2=[[UITableView alloc] initWithFrame:CGRectMake(0, vv2.frame.origin.y+vv2.frame.size.height, self.view.frame.size.width, (scroll1.frame.size.height-(vv2.frame.origin.y+vv2.frame.size.height))-50)];
    [v2 addSubview:scrollerTable2];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    page1=[[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-15, 65, 30, 20)];
    [page1 setNumberOfPages:2];
    [page1 setCurrentPage:0];
    
    [self.view addSubview:page1];
    [self.view bringSubviewToFront:page1];
    
    
    int n= (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"scrollAt"];
    
    if(n>0)
    {
        [scroll1 setContentOffset:CGPointMake(scroll1.frame.size.width*(n-1), scroll1.frame.origin.y) animated:NO];
        [page1 setCurrentPage:n-1];
        self.navigationItem.title = [hed objectAtIndex:page1.currentPage];


    }

    
}
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

/*-(void)viewWillAppear:(BOOL)animated
 {
 
 labelArrayScroller=[NSArray arrayWithObjects:@"ANTIHISTAMINES",@"FEVER MEDICATIONS",@"COUGH EXPETORANTS",@"MUCOLYTICS",@"MIXED COUGH PREPARATIONS",@"NASAL",@"LOZENGES",@"ANTINIOTICS",@"ANTIEMETICS",@"ANTISPAMODIC",@"TOPICAL", nil];
 
 labelArrayScroller2=[NSArray arrayWithObjects:@"BCG",@"HEPATITIS B",@"DTAP",@"MMR", nil];
 
 CGRect scrollFrame = CGRectMake(0, 60, [self.view bounds].size.width, [self.view bounds].size.height-60);
 scroll1 = [[UIScrollView alloc]initWithFrame: scrollFrame];
 
 [self.view addSubview:scroll1];
 [scroll1 setBackgroundColor:[UIColor blueColor]];
 
 scroll1.delegate=self;
 
 UIView *v1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, scroll1.frame.size.width, scroll1.frame.size.height)];
 [scroll1 addSubview:v1];
 [v1 setBackgroundColor:[UIColor redColor]];
 
 UIView *v2=[[UIView alloc] initWithFrame:CGRectMake(scroll1.frame.size.width, 0, scroll1.frame.size.width, scroll1.frame.size.height)];
 
 NSLog(@"self.view height=%f scrollbar height=%f v1 hight=%f",self.view.frame.size.height,scroll1.frame.size.height,v1.frame.size.height);
 [scroll1 addSubview:v2];
 [scroll1 setContentSize:CGSizeMake(scroll1.frame.size.width*2, scroll1.frame.size.height)];
 [v1 setBackgroundColor:[UIColor redColor]];
 [v2 setBackgroundColor:[UIColor greenColor]];
 
 [scroll1 setBounces:NO];
 
 [scroll1 setPagingEnabled:YES];
 UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 0,scroll1.frame.size.width, 150)];
 [v setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
 [v1 addSubview:v];
 
 UILabel *lbl1=[[UILabel alloc] initWithFrame:CGRectMake(10,5, self.view.frame.size.width-20, 40)];
 [v addSubview:lbl1];
 
 UISearchBar *search=[[UISearchBar alloc] initWithFrame:CGRectMake(10,55, self.view.frame.size.width-20, 40)];
 [v addSubview:search];
 
 UIView *vLine=[[UIView alloc] initWithFrame:CGRectMake(0, 105, self.view.frame.size.width,2)];
 [vLine setBackgroundColor:[UIColor whiteColor]];
 [v addSubview:vLine];
 
 UILabel *lbl2=[[UILabel alloc] initWithFrame:CGRectMake(10,117, self.view.frame.size.width-20, 40)];
 [v addSubview:lbl2];
 
 [lbl1 setText:@"Type in for a quick search in the database"];
 [lbl2 setText:@"SEARCH BY CATEGORIES BELOW"];
 
 [lbl1 setTextAlignment:NSTextAlignmentCenter];
 [lbl2 setTextAlignment:NSTextAlignmentCenter];
 
 [lbl1 setTextColor:[UIColor whiteColor]];
 [lbl2 setTextColor:[UIColor whiteColor]];
 
 UIView *vv2=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
 [vv2 setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
 [v2 addSubview:vv2];
 
 UILabel *lbl12=[[UILabel alloc] initWithFrame:CGRectMake(10,5, self.view.frame.size.width-20, 40)];
 [vv2 addSubview:lbl12];
 
 UISearchBar *search2=[[UISearchBar alloc] initWithFrame:CGRectMake(10,55, self.view.frame.size.width-20, 40)];
 [vv2 addSubview:search2];
 
 UIView *vLine2=[[UIView alloc] initWithFrame:CGRectMake(0, 105, self.view.frame.size.width,2)];
 [vLine2 setBackgroundColor:[UIColor whiteColor]];
 [vv2 addSubview:vLine2];
 
 UILabel *lbl22=[[UILabel alloc] initWithFrame:CGRectMake(10,117, self.view.frame.size.width-20, 40)];
 [vv2 addSubview:lbl22];
 
 [lbl12 setText:@"Type in for a quick search in the database"];
 [lbl22 setText:@"SEARCH BY CATEGORIES BELOW"];
 
 [lbl12 setTextAlignment:NSTextAlignmentCenter];
 [lbl22 setTextAlignment:NSTextAlignmentCenter];
 
 [lbl12 setTextColor:[UIColor whiteColor]];
 [lbl22 setTextColor:[UIColor whiteColor]];
 
 
 scrollerTable=[[UITableView alloc] initWithFrame:CGRectMake(0, v.frame.origin.y+v.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-(v.frame.origin.y+v.frame.size.height))];
 [v1 addSubview:scrollerTable];
 scrollerTable.dataSource=self;
 scrollerTable.delegate=self;
 
 scrollerTable2=[[UITableView alloc] initWithFrame:CGRectMake(0, vv2.frame.origin.y+vv2.frame.size.height, self.view.frame.size.width, scroll1.frame.size.height-(vv2.frame.origin.y+vv2.frame.size.height))];
 [v2 addSubview:scrollerTable2];
 scrollerTable2.dataSource=self;
 scrollerTable2.delegate=self;
 
 self.automaticallyAdjustsScrollViewInsets = NO;
 
 page1=[[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-15, 60, 30, 20)];
 [page1 setNumberOfPages:2];
 [page1 setCurrentPage:0];
 
 [self.view addSubview:page1];
 [self.view bringSubviewToFront:page1];
 }
 */

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Stores"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Stores"];
        
        
        UILabel *lblName=nil;
        
        lblName=[[UILabel alloc] initWithFrame:CGRectMake(20,10, scrollerTable.frame.size.width-40, 35)];
        lblName.tag=10;
        [cell.contentView addSubview:lblName];
        
        
        UILabel *lblName2=nil;
        
        lblName2=[[UILabel alloc] initWithFrame:CGRectMake(20,30,scrollerTable.frame.size.width-40, 30)];
        lblName2.tag=20;
        [cell.contentView addSubview:lblName2];
        // [lblName setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
        // [lblName2 setFont:[UIFont fontWithName:@"HelveticaNeueCyr-Light" size:12]];
        
        [lblName setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi"
                                         size:18]];
        
        
        [lblName2 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:14]];
        
        
        
        
    }
    UILabel *lblName=[cell.contentView viewWithTag:10];
    UILabel *lblName2=[cell.contentView viewWithTag:20];
    
    
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *d;
    if(self.scrollerTable==tableView)
    {
        EncyclopediaData *enc = [_medicationArr objectAtIndex:indexPath.row];
        [lblName setText:enc.title];
        [lblName2 setText:enc.descriptionEncyclo];
    }
    else
    {
        
        EncycloMedicationData *enc = [_immunisationArr objectAtIndex:indexPath.row];
        [lblName setText:enc.title];
        [lblName2 setText:enc.descriptionEncyMedi];
        
    }
    
    NSLog(@"lblName.text=%@",lblName.text);
    
    // [lblName2 setText:@"Examples:Proingravida,nibh vel velit,aliquet"];
    [lblName setTextColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    [lblName2 setTextColor:[UIColor colorWithRed:108.0/255.0 green:107.0/255.0 blue:108.0/255.0 alpha:1.0]];
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:( NSIndexPath *)indexPath
{
    //immunisationDictArr,medicationDictArr

    NSDictionary *d;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"didDeselectRowAtIndexPath");
    
    if(self.scrollerTable==tableView)
    {
        NSLog(@"_medicationArr selected=%@",[_medicationArr objectAtIndex:indexPath.row]);
        d=[medicationDictArr objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:[d objectForKey:@"title"] forKey:@"selectedMedicationLbl"];
        [[NSUserDefaults standardUserDefaults] setObject:[d objectForKey:@"items"] forKey:@"selectedMedicationArray"];
        [self performSegueWithIdentifier:@"medicationcategorysegu" sender:self];
        
        
    }
    else
    {
        
        NSLog(@"_immunisationArr selected=%@",[_immunisationArr objectAtIndex:indexPath.row]);

        d=[immunisationDictArr objectAtIndex:indexPath.row];
        
        [[NSUserDefaults standardUserDefaults] setObject:[d objectForKey:@"title"] forKey:@"selectedMedicationLbl"];
        [[NSUserDefaults standardUserDefaults] setObject:d forKey:@"selectedImmunisationTypeDetail"];
        [self performSegueWithIdentifier:@"immunisationtypesegu" sender:self];
        
    }
    
    
    
    
    //medicationcategorysegu
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.scrollerTable==tableView)
        return _medicationArr.count;
    else
        return _immunisationArr.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
        // NSLog(@"\n---------------\ndataDict=%@",dataDict);
        
        if(n==1)
        {
            NSArray *listTemp  = [dict objectForKey:@"data"];
            if(listTemp.count)
            {
                NSMutableArray *temp = [NSMutableArray array];
                for(NSDictionary *dict in listTemp)
                {
                    EncyclopediaData *encyclo = [[EncyclopediaData alloc] initwithDictionary:dict];
                    [temp addObject:encyclo];
                }
                
                _medicationArrHolder = temp;
                
                _medicationArr = temp;
                medicationDictArr=listTemp;

                
            }
            NSLog(@"_medicationArr count=%lu",(unsigned long)_medicationArr.count);
            
            scrollerTable.dataSource=self;
            scrollerTable.delegate=self;
            [scrollerTable reloadData];
            
        }
        //immunisationDictArr,medicationDictArr
        if(n==2)
        {
            
            NSArray *listTemp  = [dict objectForKey:@"data"];
            if(listTemp.count)
            {
                NSMutableArray *temp = [NSMutableArray array];

                for(NSDictionary *dict in listTemp)
                {
                    EncycloMedicationData *encyclo = [[EncycloMedicationData alloc] initwithDictionary:dict];
                    [temp addObject:encyclo];
                }
                
                _immunisationArrHolder = temp;
                _immunisationArr = temp;
                immunisationDictArr=listTemp;
                
            }
            NSLog(@"_immunisationArr count=%lu",(unsigned long)_immunisationArr.count);

            
            scrollerTable2.dataSource=self;
            scrollerTable2.delegate=self;
            [scrollerTable2 reloadData];
            
            
        }
        
    }
    else
    {
        NSString *messageStr = [dict objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:messageStr delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    
    
    if(n==1)
    {
        [[ConnectionsManager sharedManager] getImmunisationEncyclopedia:nil withdelegate:self];
        n++;
    }
}

-(void)failure:(id)response
{
    NSLog(@"failure");
    
}


-(void)btnClicked2
{
    [self performSegueWithIdentifier:@"medicationcategorysegu" sender:self];
    
}
-(void)btnClicked22
{
    [self performSegueWithIdentifier:@"immunisationtypesegu" sender:self];
    
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

/*
 [lblName setText:[d objectForKey:@"title"]];
 [lblName2 setText:[d objectForKey:@"description"]];
 */


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //
    if([searchBar isEqual:search2])
    {
        
        NSArray *resultArray = [_immunisationArr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(SELF.title CONTAINS[cd] %@) OR (SELF.descriptionEncyMedi CONTAINS[cd] %@)", search2.text, search2.text]];
        if(resultArray.count)
        {
            _immunisationArr = resultArray;
        }
        else
        {
            _immunisationArr = _immunisationArrHolder;
        }
        
        [self.scrollerTable2 reloadData];
        
        [search2 resignFirstResponder];
        
    }
    else
    {
        NSArray *resultArray = [_medicationArr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(SELF.title CONTAINS[cd] %@) OR (SELF.descriptionEncyclo CONTAINS[cd] %@)", search.text, search.text]];
        if(resultArray.count)
        {
            _medicationArr = resultArray;
        }
        else
        {
            _medicationArr = _medicationArrHolder;
        }
        
        [self.scrollerTable reloadData];
        
        [search resignFirstResponder];
    }
}

@end
