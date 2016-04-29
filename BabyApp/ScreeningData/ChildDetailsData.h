//
//  ChildDetailsData.h
//  BabyApp
//
//  Created by Jiten on 23/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChildDetailsData : NSObject
@property (nonatomic, strong) NSString *baby_image, *child_id, *dob, *name;

@property (nonatomic, strong) NSArray *immunisationList, *screeningList;

-(id)initwithDictionary:(NSDictionary *)dict;

@end
