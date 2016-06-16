//
//  ImmunisationBaseDate.m
//  BabyApp
//
//  Created by Jiten on 09/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import "ImmunisationBaseDate.h"
#import "ImmunisationData.h"

@implementation ImmunisationBaseDate
@synthesize sectionName, listOfData, immuID;


-(id)initwithDueDictionary:(NSDictionary *)dict dueStatus:(BOOL)isDue
{
    [self parseDictionary:dict withStatus:isDue];
    return self;
}

-(void)parseDictionary:(NSDictionary *)params withStatus:(BOOL)isDue
{
    
    
    NSArray *listItems = [params objectForKey:@"items"];
    if(listItems.count)
    {
        
        if([params objectForKey:@"title"] != nil)
        {
            self.sectionName = [params objectForKey:@"title"];

        }
        else if([params objectForKey:@"date"] != nil)
        {
            self.sectionName = [params objectForKey:@"date"];

        }
        self.immuID = [params objectForKey:@"id"];
        
        NSMutableArray *temp = [NSMutableArray array];
        for(NSDictionary *dict in listItems)
        {
            ImmunisationData *immunisatioData = [[ImmunisationData alloc] initwithDictionary:dict];
            if(immunisatioData.is_done == isDue)
            {
                [temp addObject:immunisatioData];
            }
        }
        
        self.listOfData = temp;
    }
}

-(id)initwithDueDictionary:(NSDictionary *)dict
{
    [self parseDictionary:dict];
    return self;
}

-(void)parseDictionary:(NSDictionary *)params
{
    
    if([params objectForKey:@"title"] != nil)
    {
        self.sectionName = [params objectForKey:@"title"];
        
    }
    else if([params objectForKey:@"date"] != nil)
    {
        self.sectionName = [params objectForKey:@"date"];
        
    }
    self.immuID = [params objectForKey:@"id"];
    
    NSArray *listItems = [params objectForKey:@"items"];
    if(listItems.count)
    {
        
        
        NSMutableArray *temp = [NSMutableArray array];
        for(NSDictionary *dict in listItems)
        {
            ImmunisationData *immunisatioData = [[ImmunisationData alloc] initwithDictionary:dict];
            [temp addObject:immunisatioData];
        }
        
        self.listOfData = temp;
    }
}

-(id)initwithData:(ImmunisationBaseDate *)dict
{
    self.sectionName = dict.sectionName;
    self.immuID = dict.immuID;
    
    return self;
}

@end
