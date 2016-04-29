//
//  ScreeningChildData.m
//  BabyApp
//
//  Created by Jiten on 30/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import "ScreeningChildData.h"

@implementation ScreeningChildData

@synthesize due_date, screening_id, status, title;

-(id)initwithDictionary:(NSDictionary *)param
{
    [self parseDictionary:param];
    return self;
}

-(void)parseDictionary:(NSDictionary *)dict
{
    self.due_date = [dict objectForKey:@"due_date"];
    
    self.screening_id = [dict objectForKey:@"screening_id"];
    
    self.status = [dict objectForKey:@"status"];
    self.title = [dict objectForKey:@"title"];
    
}
@end
