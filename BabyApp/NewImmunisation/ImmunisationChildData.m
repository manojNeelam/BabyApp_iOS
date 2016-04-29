//
//  ImmunisationChildData.m
//  BabyApp
//
//  Created by Jiten on 30/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import "ImmunisationChildData.h"

@implementation ImmunisationChildData

@synthesize batch_no, brand_of_vaccine, child_id, clinic, contraindications, date_given, doctor, immunisation_id, sequence, site_of_vaccination, user_id, vaccine_type, vaccine_type_name;

-(id)initwithDictionary:(NSDictionary *)param
{
    [self parseDictionary:param];
    return self;
}

-(void)parseDictionary:(NSDictionary *)dict
{
    self.batch_no = [dict objectForKey:@"batch_no"];
    
    self.vaccine_type_name = [dict objectForKey:@"vaccine_type_name"];
    
    self.brand_of_vaccine = [dict objectForKey:@"brand_of_vaccine"];
    self.child_id = [dict objectForKey:@"child_id"];
    self.clinic = [dict objectForKey:@"clinic"];
    self.contraindications = [dict objectForKey:@"contraindications"];
    self.date_given = [dict objectForKey:@"date_given"];
    self.doctor = [dict objectForKey:@"doctor"];
    self.immunisation_id = [dict objectForKey:@"immunisation_id"];
    self.sequence = [dict objectForKey:@"sequence"];
    self.site_of_vaccination = [dict objectForKey:@"site_of_vaccination"];
    self.user_id = [dict objectForKey:@"user_id"];
    self.vaccine_type = [dict objectForKey:@"vaccine_type"];
    
}

@end
