//
//  HealthBookletViewController.m
//  BabyApp
//
//  Created by Charan Giri on 28/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "HealthBookletViewController.h"
#import "ScreeningViewController.h"
#import "DrugAlergyListVC.h"
#import "MedicalConditionVC.h"
#import "PercentialViewController.h"
#import "DevelopmetalScreenViewController.h"
#import "OralHealth.h"
#import "VisualViewController.h"
@interface HealthBookletViewController ()
{
    float width;
    float imageSize;
    UIView *overlayView;
    UIView *percentailOverlayView;
    UIView *oralOverlayView;
    int percentialIndex;
    AwesomeMenuItem *starMenuItem1 ,*starMenuItem2 ,*starMenuItem3 ,*starMenuItem4 ,*starMenuItem5;
    
}
@end

@implementation HealthBookletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self circleView];
    
    overlayView=[UIView new];
    overlayView.frame=self.view.frame;
    overlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [overlayView setHidden:YES];
    [self.view addSubview:overlayView];
    
    
    percentailOverlayView=[UIView new];
    percentailOverlayView.frame=self.view.frame;
    percentailOverlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [percentailOverlayView setHidden:YES];
    [self.view addSubview:percentailOverlayView];
    
    oralOverlayView=[UIView new];
    oralOverlayView.frame=self.view.frame;
    oralOverlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [oralOverlayView setHidden:YES];
    [self.view addSubview:oralOverlayView];
    
    
    
    
}
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}



-(void)immunisationButtonAction
{
    [self performSegueWithIdentifier:@"immunisationTableSegue" sender:self];
    
    
}

-(void)screeningButtonAction
{
    [self performSegueWithIdentifier:@"activitySegue" sender:self];
    
    
}

-(void)circleView
{
    
    /*
     [20/04/16 10:41:16 pm] Atul Awasthi: Screening=250/215/113
     [20/04/16 10:42:26 pm] Atul Awasthi: Immunisation=236/103/121
     [20/04/16 10:42:31 pm] Atul Awasthi: RGB
     [20/04/16 10:47:26 pm] Atul Awasthi: Percentiles 244/144/50
     [20/04/16 10:51:26 pm] Atul Awasthi: Allergy =122/182/64
     [20/04/16 10:52:15 pm] Atul Awasthi: oral=95/150/234
     */
    
   // UIImage *storyMenuItemImage = [UIImage imageNamed:@"centerImage.png"];
   // UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"centerImage.png"];
  
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"centerImagetemp.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"centerImagetemp.png"];

    
    UIImage *starImage1 = [UIImage imageNamed:@"hb_immunisation.png"];
    UIImage *starImage2 = [UIImage imageNamed:@"hb_percentiles.png"];
    UIImage *starImage3= [UIImage imageNamed:@"hb_oral.png"];
    UIImage *starImage4 = [UIImage imageNamed:@"hb_allergy.png"];
    UIImage *starImage5 = [UIImage imageNamed:@"screening_icon2.png"];
    
    
    // Default Menu
    //250/215/113
    
     starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage1
                                                    highlightedContentImage:nil withTitle:@"Immunisation" color:[UIColor colorWithRed:236.0f/255.0f green:103.0f/255.0f blue:121.0f/255.0f alpha:1.0] andPosition:YES];
    
     starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage2
                                                    highlightedContentImage:nil withTitle:@"Percentile" color:[UIColor colorWithRed:244.0f/255.0f green:144.0f/255.0f blue:50.0f/255.0f alpha:1.0] andPosition:YES];
    
     starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage3
                                                    highlightedContentImage:nil withTitle:@"Oral Health and Visual" color:[UIColor colorWithRed:95.0f/255.0f green:150.0f/255.0f blue:234.0f/255.0f alpha:1.0] andPosition:YES];
    //122/182/64
    
    starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                          highlightedImage:storyMenuItemImagePressed
                                              ContentImage:starImage4
                                   highlightedContentImage:nil withTitle:@"Allergy and Medical Condition" color:[UIColor colorWithRed:122.0f/255.0f green:182.0f/255.0f blue:64.0f/255.0f alpha:1.0] andPosition:YES];
    
    //250/215/113
    
    AwesomeMenuItem *starMenuItem5 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage5
                                                    highlightedContentImage:nil withTitle:@"Screening" color:[UIColor colorWithRed:250.0f/255.0f green:215.0f/255.0f blue:113.0f/255.0f alpha:1.0] andPosition:YES];
    
    
    NSArray *menuItems = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, starMenuItem5, nil];
    
    
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@""]
                                                       highlightedImage:[UIImage imageNamed:@""]
                                                           ContentImage:[UIImage imageNamed:@""]
                                                highlightedContentImage:[UIImage imageNamed:@"hb_oral.png"] withTitle:nil color:nil andPosition:NO];
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:self.view.bounds startItem:startItem menuItems:menuItems];
    menu.delegate = self;
    [_baseCircleView addSubview:menu];
    
    
}
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %d",idx);
    
    if (idx ==0) {
        [self performSegueWithIdentifier:@"immunisationTableSegue" sender:self];
        
    }
    else if (idx==2)
    {
        [self oralAndVisualView];
    }
    else if (idx==4)
    {
        UIStoryboard *storyboard = self.navigationController.storyboard;
        
        
        ScreeningViewController *detailPage = [storyboard
                                               instantiateViewControllerWithIdentifier:@"Screening"];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"NewScreening"];

        [self.navigationController pushViewController:detailPage animated:YES];
        
    }
    else if(idx ==3)
    {
        [self AllergyAndMedicalView];
    }
    else if(idx ==1)
    {
        [self percentailView];
    }
    
    
    
}
- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    NSLog(@"Menu was closed!");
}
- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    NSLog(@"Menu is open!");
}

-(void)AllergyAndMedicalView
{
    
    [overlayView setHidden:NO];
    
    
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setBackgroundImage:[UIImage imageNamed:@"hb_Alergy_back.png"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(starMenuItem4.frame.origin.x+5, starMenuItem4.frame.origin.y+40, 70, 70);
    
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:backButton];
    
    UIButton *drugButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [drugButton setBackgroundImage:[UIImage imageNamed:@"hb_Alergy_option.png"] forState:UIControlStateNormal];
    drugButton.frame=CGRectMake(backButton.frame.origin.x+10, backButton.frame.origin.y-100, 50, 50);
    [drugButton addTarget:self action:@selector(drugAction) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:drugButton];
    
    UILabel *drugLabel =[[UILabel alloc]initWithFrame:CGRectMake(backButton.frame.origin.x, drugButton.frame.origin.y+drugButton.frame.size.height, 70, 30)];
    drugLabel.text=@"Allergy";
    drugLabel.textAlignment=NSTextAlignmentCenter;
    drugLabel.textColor=[UIColor whiteColor];
    [overlayView addSubview:drugLabel];
    
    
    UIButton *medicalButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [medicalButton setBackgroundImage:[UIImage imageNamed:@"hb_medical_option.png"] forState:UIControlStateNormal];
    medicalButton.frame=CGRectMake(backButton.frame.origin.x+10, backButton.frame.origin.y+100, 50, 50);
    [medicalButton addTarget:self action:@selector(medicalAction) forControlEvents:UIControlEventTouchUpInside];
    [overlayView addSubview:medicalButton];
    
    
    UILabel *medicalLabel =[[UILabel alloc]initWithFrame:CGRectMake(backButton.frame.origin.x, medicalButton.frame.origin.y+medicalButton.frame.size.height, 70, 50)];
    medicalLabel.text=@"Medical Condition";
    medicalLabel.numberOfLines=2;
    medicalLabel.textAlignment=NSTextAlignmentCenter;
    medicalLabel.textColor=[UIColor whiteColor];
    [overlayView addSubview:medicalLabel];
    
    [drugLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    [medicalLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    
    
}

-(void)backAction
{
    [overlayView setHidden:YES];
    
}

-(void)drugAction
{
    [overlayView setHidden:YES];
    UIStoryboard *storyboard = self.navigationController.storyboard;
    
    DrugAlergyListVC *detailPage = [storyboard
                                    instantiateViewControllerWithIdentifier:@"DrugAlergyListVC_SB_ID"];
    
    [self.navigationController pushViewController:detailPage animated:YES];
    
}

-(void)medicalAction
{
    [overlayView setHidden:YES];
    UIStoryboard *storyboard = self.navigationController.storyboard;
    
    MedicalConditionVC *detailPage = [storyboard
                                      instantiateViewControllerWithIdentifier:@"MedicalConditionVC_SB_ID"];
    
    [self.navigationController pushViewController:detailPage animated:YES];
    
}


-(void)percentailView
{
    
    [percentailOverlayView setHidden:NO];
    
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setBackgroundImage:[UIImage imageNamed:@"hb_Alergy_back.png"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(starMenuItem2.frame.origin.x+5, starMenuItem2.frame.origin.y+40, 70, 70);
    [backButton addTarget:self action:@selector(overlaybackAction) forControlEvents:UIControlEventTouchUpInside];
    [percentailOverlayView addSubview:backButton];
    [backButton setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    
    
    
    
    UIButton *headButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    headButton.frame=CGRectMake(backButton.frame.origin.x-100, backButton.frame.origin.y-60, 50, 50);
    [headButton addTarget:self action:@selector(headAction) forControlEvents:UIControlEventTouchUpInside];
    [percentailOverlayView addSubview:headButton];
    
    [headButton setBackgroundImage:[UIImage imageNamed:@"hb_Alergy_option.png"] forState:UIControlStateNormal];
    
    UILabel *medicalLabel =[[UILabel alloc]initWithFrame:CGRectMake(headButton.frame.origin.x-20, headButton.frame.origin.y+headButton.frame.size.height, 80, 50)];
    medicalLabel.text=@"Head Circumference";
    medicalLabel.numberOfLines=2;
    medicalLabel.textAlignment=NSTextAlignmentCenter;
    medicalLabel.textColor=[UIColor whiteColor];
    [percentailOverlayView addSubview:medicalLabel];
    
    
    UIButton *heightButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [heightButton setBackgroundImage:[UIImage imageNamed:@"hb_Alergy_option.png"] forState:UIControlStateNormal];
    heightButton.frame=CGRectMake(headButton.frame.origin.x, headButton.frame.origin.y+100, 50, 50);
    [heightButton addTarget:self action:@selector(heightAction) forControlEvents:UIControlEventTouchUpInside];
    [percentailOverlayView addSubview:heightButton];
    
    
    UILabel *heightLabel =[[UILabel alloc]initWithFrame:CGRectMake(heightButton.frame.origin.x-10, heightButton.frame.origin.y+heightButton.frame.size.height, 70, 50)];
    heightLabel.text=@"Height";
    heightLabel.numberOfLines=2;
    heightLabel.textAlignment=NSTextAlignmentCenter;
    heightLabel.textColor=[UIColor whiteColor];
    [percentailOverlayView addSubview:heightLabel];
    
    
    
    UIButton *weighttButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [weighttButton setBackgroundImage:[UIImage imageNamed:@"hb_Alergy_option.png"] forState:UIControlStateNormal];
    weighttButton.frame=CGRectMake(headButton.frame.origin.x, heightButton.frame.origin.y+100, 50, 50);
    [weighttButton addTarget:self action:@selector(weightAction) forControlEvents:UIControlEventTouchUpInside];
    [percentailOverlayView addSubview:weighttButton];
    
    
    
    UILabel *weightLabel =[[UILabel alloc]initWithFrame:CGRectMake(weighttButton.frame.origin.x-10, weighttButton.frame.origin.y+weighttButton.frame.size.height, 70, 50)];
    weightLabel.text=@"Weight";
    weightLabel.numberOfLines=2;
    weightLabel.textAlignment=NSTextAlignmentCenter;
    weightLabel.textColor=[UIColor whiteColor];
    [percentailOverlayView addSubview:weightLabel];
    

    UIButton *bmiButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [bmiButton setBackgroundImage:[UIImage imageNamed:@"hb_Alergy_option.png"] forState:UIControlStateNormal];
    bmiButton.frame=CGRectMake(headButton.frame.origin.x, weighttButton.frame.origin.y+100, 50, 50);
    [bmiButton addTarget:self action:@selector(bmiAction) forControlEvents:UIControlEventTouchUpInside];
    [percentailOverlayView addSubview:bmiButton];
    
    UILabel *bmiLabel =[[UILabel alloc]initWithFrame:CGRectMake(bmiButton.frame.origin.x-10, bmiButton.frame.origin.y+bmiButton.frame.size.height, 70, 50)];
    bmiLabel.text=@"BMI";
    bmiLabel.numberOfLines=2;
    bmiLabel.textAlignment=NSTextAlignmentCenter;
    bmiLabel.textColor=[UIColor whiteColor];
    [percentailOverlayView addSubview:bmiLabel];
    
    [medicalLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
    [heightLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    [weightLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    [bmiLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    
    
}

-(void)overlaybackAction
{
    [percentailOverlayView setHidden:YES];
    
    
    
}
-(void)headAction
{
    percentialIndex=1;
    [percentailOverlayView setHidden:YES];
    [self performSegueWithIdentifier:@"percentialSegue" sender:self];
    
}

-(void)heightAction
{
    percentialIndex=2;
    [percentailOverlayView setHidden:YES];
    [self performSegueWithIdentifier:@"percentialSegue" sender:self];
    
}


-(void)weightAction
{
    percentialIndex=3;
    [percentailOverlayView setHidden:YES];
    [self performSegueWithIdentifier:@"percentialSegue" sender:self];
    
}


-(void)bmiAction
{
    percentialIndex=4;
    [percentailOverlayView setHidden:YES];
    [self performSegueWithIdentifier:@"percentialSegue" sender:self];
    
}






-(void)oralAndVisualView
{
    
    [oralOverlayView setHidden:NO];
    
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setBackgroundImage:[UIImage imageNamed:@"hb_back_oralvisual.png"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(starMenuItem3.frame.origin.x+5, starMenuItem3.frame.origin.y+40, 70, 70);
    [backButton addTarget:self action:@selector(oralbackAction) forControlEvents:UIControlEventTouchUpInside];
    [oralOverlayView addSubview:backButton];
    
    NSLog(@"%f%f%f%f",starMenuItem3.frame.origin.x,starMenuItem3.frame.origin.y,starMenuItem3.frame.size.width,starMenuItem3.frame.size.height);
    NSLog(@"%f%f%f%f",backButton.frame.origin.x,backButton.frame.origin.y,backButton.frame.size.width,backButton.frame.size.height);
    
    
    UIButton *oralButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [oralButton setBackgroundImage:[UIImage imageNamed:@"hb_teeth.png"] forState:UIControlStateNormal];
    oralButton.frame=CGRectMake(backButton.frame.origin.x+10, backButton.frame.origin.y-100, 50, 50);
    [oralButton addTarget:self action:@selector(oralAction) forControlEvents:UIControlEventTouchUpInside];
    [oralOverlayView addSubview:oralButton];
    
    
    UILabel *bmiLabel =[[UILabel alloc]initWithFrame:CGRectMake(oralButton.frame.origin.x-10, oralButton.frame.origin.y+oralButton.frame.size.height, 70, 50)];
    bmiLabel.text=@"Oral Health";
    bmiLabel.numberOfLines=2;
    bmiLabel.textAlignment=NSTextAlignmentCenter;
    bmiLabel.textColor=[UIColor whiteColor];
    [oralOverlayView addSubview:bmiLabel];
    
    
    UIButton *visualtButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [visualtButton setBackgroundImage:[UIImage imageNamed:@"hb_visual_option.png"] forState:UIControlStateNormal];
    visualtButton.frame=CGRectMake(oralButton.frame.origin.x, backButton.frame.origin.y+100, 50, 50);
    [visualtButton addTarget:self action:@selector(visualAction) forControlEvents:UIControlEventTouchUpInside];
    [oralOverlayView addSubview:visualtButton];
    
    UILabel *visualLabel =[[UILabel alloc]initWithFrame:CGRectMake(visualtButton.frame.origin.x-10, visualtButton.frame.origin.y+visualtButton.frame.size.height, 70, 50)];
    visualLabel.text=@"Visual Check";
    visualLabel.numberOfLines=2;
    visualLabel.textAlignment=NSTextAlignmentCenter;
    visualLabel.textColor=[UIColor whiteColor];
    [oralOverlayView addSubview:visualLabel];
    
    [visualLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    
    [bmiLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
    
}

-(void)oralbackAction
{
    [oralOverlayView setHidden:YES];
    
}
-(void)oralAction
{
    [oralOverlayView setHidden:YES];
    //[self performSegueWithIdentifier:@"activitySegue" sender:self];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"forOral"];
    
    //
    
    
    OralHealth *dummyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BabyTeethViewController_SB_ID"];
    [self.navigationController pushViewController:dummyVC animated:YES];

    
    
    
    
}
-(void)visualAction
{
    [oralOverlayView setHidden:YES];
  //  [self performSegueWithIdentifier:@"activitySegue" sender:self];
  
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"forOral"];
    
    VisualViewController *dummyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VisualViewController_SB_ID"];
    [self.navigationController pushViewController:dummyVC animated:YES];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"percentialSegue"])
    {
        // Get reference to the destination view controller
        PercentialViewController *vc = [segue destinationViewController];
        if (percentialIndex==1) {
            
        }
        switch (percentialIndex) {
            case 1:
                [vc setTitleString:@"Head"];
                [vc setSuffix:@"cm"];
                [vc setYaxisName:@"Cirumference"];
                [vc setTitleLableString:@"PERCENTILES OF HEAD CIRCUMFERENCE-FOR-AGE"];
                [vc setSubTitleLableString:@"GIRLS AGED 0 TO 24 MONTHS"];
                
                break;
            case 2:
                [vc setTitleString:@"Height"];
                [vc setSuffix:@"cm"];
                [vc setYaxisName:@"Height"];
                [vc setTitleLableString:@"PERCENTILES OF HEIGHT-FOR-AGE"];
                [vc setSubTitleLableString:@"GIRLS AGED 0 TO 24 MONTHS"];
                break;
            case 3:
                [vc setTitleString:@"Weight"];
                [vc setSuffix:@"kgs"];
                [vc setYaxisName:@"Weight"];
                [vc setTitleLableString:@"PERCENTILES OF WEIGHT-FOR-AGE"];
                [vc setSubTitleLableString:@"GIRLS AGED 0 TO 24 MONTHS"];
                
                break;
            case 4:
                [vc setTitleString:@"BMI"];
                [vc setSuffix:@"h/w"];
                [vc setYaxisName:@"BMI"];
                [vc setTitleLableString:@"PERCENTILES OF BMI-FOR-AGE"];
                [vc setSubTitleLableString:@"GIRLS AGED 0 TO 24 MONTHS"];
                
                break;
            default:
                break;
        }
    }
    
}


- (IBAction)screeningAction:(id)sender
{
   /* UIViewController *dummyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChildDevelopementalViewController"];
    [self.navigationController pushViewController:dummyVC animated:YES];*/
    
    DevelopmetalScreenViewController *dummyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DevelopmetalScreenViewController"];
    [self.navigationController pushViewController:dummyVC animated:YES];
    
    
    
}

- (IBAction)childSafetyAction:(id)sender {
    
    UIViewController *dummyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"childSafety"];
    [self.navigationController pushViewController:dummyVC animated:YES];
    
}
@end
