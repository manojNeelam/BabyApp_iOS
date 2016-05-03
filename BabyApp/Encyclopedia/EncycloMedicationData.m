
//
//  EncycloMedicationData.m
//  BabyApp
//
//  Created by Jiten on 03/05/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import "EncycloMedicationData.h"

@implementation EncycloMedicationData
@synthesize descriptionEncyMedi, info, idEncyMedi, title, otherinfo;

-(id)initwithDictionary:(NSDictionary *)param
{
    [self parseDictionary:param];
    return self;
}

-(void)parseDictionary:(NSDictionary *)dict
{
    self.descriptionEncyMedi = [dict objectForKey:@"description"];
    self.info = [dict objectForKey:@"info"];
    self.idEncyMedi = [dict objectForKey:@"id"];
    self.title = [dict objectForKey:@"title"];
    self.otherinfo = [dict objectForKey:@"otherinfo"];
    
}

@end
