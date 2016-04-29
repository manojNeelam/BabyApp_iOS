//
//  ScreeningChildData.h
//  BabyApp
//
//  Created by Jiten on 30/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScreeningChildData : NSObject

/*
 "due_date" = "2016-04-24";
 "screening_id" = 108;
 status = 0;
 title = "5-6 Weeks";

 */

@property (nonatomic, strong) NSString *due_date, *screening_id, *status, *title;

-(id)initwithDictionary:(NSDictionary *)param;
@end
