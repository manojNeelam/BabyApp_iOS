
//
//  ChildDetailsData.m
//  BabyApp
//
//  Created by Jiten on 23/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import "ChildDetailsData.h"

@implementation ChildDetailsData
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
    
}
@end
