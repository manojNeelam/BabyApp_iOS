//
//  DateTimeUtil.h
//  ForumApp
//
//  Created by SanC on 05/03/14.
//  Copyright (c) 2014 Enovate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTimeUtil : NSObject

+(NSDate *) localDateFromServerDateString:(NSString *) dateString;
+(NSDate *) serverDateFromLocalDate:(NSDate *) date;

+(NSString *) stringFromDateTime:(NSDate *) date withFormat:(NSString *) aFormat;
+(NSDate *)  dateFromStringDate:(NSString *) date withFormat:(NSString *) aFormat;

+(NSString *) getTimeLabel:(int) timeDiff;
+(NSDate *) getZeroTZDate;
+(NSString *) getZeroTZDateStr;
+(NSString *) getGMTStringDateFrom:(NSDate *) date;
+(NSDate *) getGMTDateFromStrDate:(NSString *) date;

+(NSString *) serverDateFromDisplayDate:(NSDate *) date;
+(NSString *) serverDateFromDisplayDateStr:(NSString *) date;
+(NSString *) displayDateFromServerDate:(NSDate *) date;
+(NSString *) displayDateFromServerDateStr:(NSString *) date;

//GMT to local date
+(NSDate *) localDateFromGMTDate:(NSDate *) date;
+(NSString *) displayDateTimeFromServerDate:(NSDate *) date;
+(NSString *) displayDateTimeFromServerDateStr:(NSString *) date;
+(NSDate *) getTodaysDate;
+(NSDate *) getDateAfterAddDays:(NSInteger) day;


+(NSDate *) weekStartDate;
+(NSDate *) weekEndDate;
+(NSDate *) monthStartDate;
+(NSDate *) monthEndDate;

+(NSDate *) dayStartDate:(NSDate *) date;
+(NSDate *) dayEndDate:(NSDate *) date;

+(NSString *) dayFromDate:(NSDate *) date;
+ (NSString *)getChatDisplayDate:(NSDate *)dateTime;

+(NSDate *) getDateBeforeYears:(NSInteger) year;
@end
