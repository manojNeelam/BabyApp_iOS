//
//  DummyScreeningVC.m
//  BabyApp
//
//  Created by Vishal Kolhe on 06/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "DummyScreeningVC.h"
#import "CommonScreeingListVC.h"
#import "CommonScreeingData.h"

@implementation DummyScreeningVC

- (IBAction)onClickPersonalButton:(id)sender {

    CommonScreeingListVC *personalListVC = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_CommonScreeningVC];
    personalListVC.listOfObjects = [self dummyData];
    personalListVC.navTitle = @"Personal Social";
    [self.navigationController pushViewController:personalListVC animated:YES];

}

- (IBAction)onClcikFineMotorButton:(id)sender {

    CommonScreeingListVC *personalListVC = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_CommonScreeningVC];
    personalListVC.listOfObjects = [self dummyData];
    personalListVC.navTitle = @"Fine Motor-Adaptive";
    [self.navigationController pushViewController:personalListVC animated:YES];
    

}

- (IBAction)onClickLauguageButton:(id)sender {

    CommonScreeingListVC *personalListVC = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_CommonScreeningVC];
    personalListVC.listOfObjects = [self dummyData];
    personalListVC.navTitle = @"Language";
    [self.navigationController pushViewController:personalListVC animated:YES];
    
}

- (IBAction)onClickGrossMotorButton:(id)sender {

    CommonScreeingListVC *personalListVC = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_CommonScreeningVC];
    personalListVC.listOfObjects = [self dummyData];
    personalListVC.navTitle = @"Gross Motor";
    [self.navigationController pushViewController:personalListVC animated:YES];
}

-(NSMutableArray *)dummyData
{
    NSMutableArray *array = [NSMutableArray array];
    CommonScreeingData *commonScreeingData = [[CommonScreeingData alloc] init];
    commonScreeingData.sDesc = @"Your child displays excitment like kicking legs, moving arms, on seeing an attractive to. (Excites at a toy)";
    commonScreeingData.sAge = @"Age 5.5 months";
    [array addObject:commonScreeingData];
    
    commonScreeingData = [[CommonScreeingData alloc] init];
    commonScreeingData.sDesc = @"Your child will try to get a toy that he enjoys when it is out of reach by strectching his arms or body.(Works for atoy out of reach)";
    commonScreeingData.sAge = @"Age 6.5 months";
    [array addObject:commonScreeingData];
    
    
    commonScreeingData = [[CommonScreeingData alloc] init];
    commonScreeingData.sDesc = @"Your child seems to be shy or wary of strangers. (Reacts to strabger)";
    commonScreeingData.sAge = @"Age 10 months";
    [array addObject:commonScreeingData];
    
    commonScreeingData = [[CommonScreeingData alloc] init];
    commonScreeingData.sDesc = @"When you face your child, say bye bye and wave him, he responds by waving his arm. hand and fingers without his hands or arms being touched.";
    commonScreeingData.sAge = @"Age 10.5 months";
    [array addObject:commonScreeingData];
    
    return array;
}


@end
