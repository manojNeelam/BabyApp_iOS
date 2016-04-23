//
//  ChildDevData.m
//  BabyApp
//
//  Created by Jiten on 24/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import "ChildDevData.h"

@implementation ChildDevData
@synthesize title;

-(id)initwithDictionary:(NSDictionary *)dict
{
    [self parseDictionary:dict];
    return self;
}

-(void)parseDictionary:(NSDictionary *)param
{
    self.title = [param objectForKey:@"title"];
}
@end
