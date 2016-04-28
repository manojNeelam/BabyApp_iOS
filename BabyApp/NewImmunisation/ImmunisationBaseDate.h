//
//  ImmunisationBaseDate.h
//  BabyApp
//
//  Created by Jiten on 09/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImmunisationBaseDate : NSObject
@property (nonatomic, strong) NSString *sectionName, *immuID;

@property (nonatomic, strong) NSArray *listOfData;


-(id)initwithDueDictionary:(NSDictionary *)dict dueStatus:(BOOL)isDue;
-(id)initwithData:(ImmunisationBaseDate *)dict;

-(id)initwithDueDictionary:(NSDictionary *)dict;
@end
