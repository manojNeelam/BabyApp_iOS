//
//  EncycloItemData.h
//  BabyApp
//
//  Created by Jiten on 03/05/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncycloItemData : NSObject
@property (nonatomic, strong) NSString *descriptionEncyclo, *dosageEncyclo, *idEncyclo, *otherinfoEncyclo, *sideeffectsEncyclo;


-(id)initWithDictionary:(NSDictionary *)param;

@end
