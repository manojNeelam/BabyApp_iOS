//
//  ImmunisationData.m
//  BabyApp
//
//  Created by Jiten on 09/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import "ImmunisationData.h"

@implementation ImmunisationData
@synthesize is_done, sequence, immuId, date_given, nextDoseDate, dosage;


-(id)initwithDictionary:(NSDictionary *)params
{
    [self parseDictionary:params];
    return self;
}

-(void)parseDictionary:(NSDictionary *)dict
{
    /*
     "id": "1",
     "sequence": "1st Dose",
     "date_given": "2016-04-05",
     "is_done": "1"
     
     */
    id _idDone = [dict objectForKey:@"is_done"];
    
    if([_idDone isKindOfClass:[NSString class]])
    {
        self.is_done = [_idDone boolValue];
    }
    else if ([_idDone isKindOfClass:[NSNumber class]])
    {
        self.is_done = [_idDone boolValue];
    }
    else
    {
        self.is_done = _idDone;
    }
    
    self.sequence = [dict objectForKey:@"sequence"];
    self.date_given = [dict objectForKey:@"date_given"];
    self.immuId = [dict objectForKey:@"id"];
}


-(id)initwithData:(ImmunisationData *)data
{
    self.is_done = data.is_done;
    
    self.sequence = data.sequence;
    self.date_given = data.date_given;
    self.immuId = data.immuId;
    
    return self;
}

@end
