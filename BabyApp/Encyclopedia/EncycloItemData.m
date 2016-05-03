//
//  EncycloItemData.m
//  BabyApp
//
//  Created by Jiten on 03/05/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import "EncycloItemData.h"

@implementation EncycloItemData
@synthesize descriptionEncyclo, dosageEncyclo, idEncyclo, otherinfoEncyclo, sideeffectsEncyclo;

-(id)initWithDictionary:(NSDictionary *)param
{
    [self parseDictionary:param];
    return self;
}

-(void)parseDictionary:(NSDictionary *)dict
{
    /*
     description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
     dosage = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
     id = 1;
     otherinfo = "";
     sideeffects = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
     */
    
    self.descriptionEncyclo = [dict objectForKey:@"description"];
    self.dosageEncyclo = [dict objectForKey:@"dosage"];
    self.idEncyclo = [dict objectForKey:@"id"];
    self.otherinfoEncyclo = [dict objectForKey:@"otherinfo"];
    self.sideeffectsEncyclo = [dict objectForKey:@"sideeffects"];
    
}
@end
