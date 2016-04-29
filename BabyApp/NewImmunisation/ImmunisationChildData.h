//
//  ImmunisationChildData.h
//  BabyApp
//
//  Created by Jiten on 30/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImmunisationChildData : NSObject
/*
 "batch_no" = 5252;
 "brand_of_vaccine" = 252;
 "child_id" = 50;
 clinic = 25252;
 contraindications = 25252;
 "date_given" = "2013-04-27";
 doctor = 25252;
 "immunisation_id" = 36;
 sequence = 255252;
 "site_of_vaccination" = 5252;
 "user_id" = 109;
 "vaccine_type" = 1;
 "vaccine_type_name" = "Hep B";
*/


@property (nonatomic, strong) NSString *batch_no, *brand_of_vaccine, *child_id, *clinic, *contraindications, *date_given, *doctor, *immunisation_id, *sequence, *site_of_vaccination, *user_id, *vaccine_type, *vaccine_type_name;

-(id)initwithDictionary:(NSDictionary *)param;
@end
