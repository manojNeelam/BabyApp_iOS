//
//  ImmunisationData.h
//  BabyApp
//
//  Created by Jiten on 09/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImmunisationData : NSObject
@property (nonatomic,strong) NSString *sequence, *date_given, *nextDoseDate, *dosage, *immuId;
@property (nonatomic, assign) BOOL is_done;

-(id)initwithDictionary:(NSDictionary *)params;

-(id)initwithData:(ImmunisationData *)data;
@end
