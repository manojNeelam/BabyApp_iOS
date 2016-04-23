//
//  ChildDevelopmentData.m
//  BabyApp
//
//  Created by Jiten on 23/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import "ChildDevelopmentData.h"
#import "ChildDevData.h"

@implementation ChildDevelopmentData
@synthesize headerTitle, listChildDev;

-(id)initwithDictionary:(NSDictionary *)dict
{
    [self parseDictionary:dict];
    return self;
}

-(void)parseDictionary:(NSDictionary *)param
{
    NSArray *list = [param objectForKey:@"list"];
    
    NSMutableArray *temp = [NSMutableArray array];
    
    for(NSDictionary *dict in list)
    {
        ChildDevData *childData = [[ChildDevData alloc] initwithDictionary:dict];
        [temp addObject:childData];
    }
    
    self.listChildDev = temp;
    
    self.headerTitle = [param objectForKey:@"headerTitle"];
}

@end
