//
//  ChildDevData.h
//  BabyApp
//
//  Created by Jiten on 24/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChildDevData : NSObject
@property (nonatomic, strong) NSString *title;
-(id)initwithDictionary:(NSDictionary *)dict;


@end
