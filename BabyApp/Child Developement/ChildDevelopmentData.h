//
//  ChildDevelopmentData.h
//  BabyApp
//
//  Created by Jiten on 23/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChildDevelopmentData : NSObject
@property (nonatomic, strong) NSString * headerTitle;
@property (nonatomic, strong) NSArray *listChildDev;


-(id)initwithDictionary:(NSDictionary *)dict;

@end
