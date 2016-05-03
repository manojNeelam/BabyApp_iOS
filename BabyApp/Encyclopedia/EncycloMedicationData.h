//
//  EncycloMedicationData.h
//  BabyApp
//
//  Created by Jiten on 03/05/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncycloMedicationData : NSObject

@property (nonatomic, strong) NSString *descriptionEncyMedi, *idEncyMedi, *info, *otherinfo, *title;

-(id)initwithDictionary:(NSDictionary *)param;


@end
