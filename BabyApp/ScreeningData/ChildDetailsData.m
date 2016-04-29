
//
//  ChildDetailsData.m
//  BabyApp
//
//  Created by Jiten on 23/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import "ChildDetailsData.h"
#import "ImmunisationChildData.h"
#import "ScreeningChildData.h"

@implementation ChildDetailsData
@synthesize immunisationList, screeningList;

-(id)initwithDictionary:(NSDictionary *)dict
{
    [self parseDictionary:dict];
    return self;
}

-(void)parseDictionary:(NSDictionary *)params
{
    self.baby_image = [params objectForKey:@"baby_image"];
    self.child_id = [params objectForKey:@"child_id"];
    self.dob = [params objectForKey:@"dob"];
    self.name = [params objectForKey:@"name"];
    
    NSArray *immunisationTemp = [params objectForKey:@"immunisation"];
    if(immunisationTemp.count)
    {
        NSMutableArray *temp = [NSMutableArray array];
        for(NSDictionary *dict in immunisationTemp)
        {
            ImmunisationChildData *childData = [[ImmunisationChildData alloc] initwithDictionary:dict];
            [temp addObject:childData];
        }
        
        self.immunisationList = temp;
    }
    
    NSArray *screeningTemp = [params objectForKey:@"screening"];
    if(screeningTemp.count)
    {
        NSMutableArray *temp1 = [NSMutableArray array];
        for(NSDictionary *dict in screeningTemp)
        {
            ScreeningChildData *childData = [[ScreeningChildData alloc] initwithDictionary:dict];
            [temp1 addObject:childData];
        }
        
        self.screeningList = temp1;
    }
}
@end
