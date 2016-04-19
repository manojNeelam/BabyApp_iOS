//
//  ImmunisationData.h
//  BabyApp
//
//  Created by Jiten on 09/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImmunisationData : NSObject
@property (nonatomic,strong) NSString *title, *completedDate, *nextDoseDate, *dosage;
@property (nonatomic, assign) BOOL isCompleted;
@end
