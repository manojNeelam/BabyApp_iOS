//
//  EncyclopediaData.h
//  BabyApp
//
//  Created by Jiten on 02/05/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncyclopediaData : NSObject

@property (nonatomic, strong) NSString *descriptionEncyclo, *idEncyclo, *title;
@property (nonatomic, strong) NSArray *items;

-(id)initwithDictionary:(NSDictionary *)params;

@end
