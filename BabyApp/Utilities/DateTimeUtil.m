//
//  DateTimeUtil.m
//  ForumApp
//
//  Created by SanC on 05/03/14.
//  Copyright (c) 2014 Enovate. All rights reserved.
//
#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

#define DATE_FMT_YYYY_MM_DD         @"yyyy-MM-dd"
#define DATE_FMT_DD_MM_YYYY         @"dd-MM-yyyy"
#define GRAPH_DATE_FMT_DD_MM_YYYY   @"dd/MM/yyyy"
#define DATE_FMT_DD_MM_YYYY_1       @"yyyy-MM-DD"

#define DATE_FMT_DD_MM_YYYY_2      @"yyyy-MM-dd"


#define DATE_FMT_DD_MM_YYYY__HH_MM_SS_12 @"dd/MM/yyyy hh:mm:ss"
#define DATE_FMT_DD_MM_YYYY__HH_MM_SS_24 @"dd/MM/yyyy HH:mm:ss"
#define DATE_yyyy_MM_dd_HH_MM_SS    @"yyyy-MM-dd HH:mm:ss"
#define TIME_FMT_HH_MM_SS           @"HH:mm:ss"
#define DATE_SUMMARY_FORMAT         @"HH:mm, dd MMM yyyy"

#define DATE_FMT_100                @"dd MMM yyyy hh:mm aaa"
#define RECEIPT_NAME_DATE_FORMAT    @"dd.MM.YYYY HH:mm"
#define DATE_FMT_TIME_ONLY_24       @"HH:mm"
#define DATE_MM_DD_HH_MM            @"MMM dd"


#import "DateTimeUtil.h"

#define ONE_DAY_SEC         86400
#define ONE_HOUR_SEC        3600
#define ONE_MIN_SEC         60

@implementation DateTimeUtil

static NSDateFormatter *dtFormatter;

+(NSDate *) localDateFromServerDateString:(NSString *)dateString
{
    //get source date from the server
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:DATE_FMT_DD_MM_YYYY__HH_MM_SS_12];
    NSDate *sourceDate = [dateFormat dateFromString:dateString];
    
    //set timezones
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Jerusalem"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    //calc time difference
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    //set current real date
    return [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
}

+(NSDate *) serverDateFromLocalDate:(NSDate *) date
{
    
    NSDate *sourceDate = date;
    
    //set timezones
    NSTimeZone* destinationTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Jerusalem"];
    NSTimeZone* sourceTimeZone  = [NSTimeZone systemTimeZone];
    
    //calc time difference
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    //set current real date
    return [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
}

+(NSDate *) localDateFromGMTDate:(NSDate *) date
{
    //set timezones
	NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];

    //calc time difference
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;

    //set current real date
    return [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
}

+(NSString *) stringFromDateTime:(NSDate *)date withFormat:(NSString *) aFormat
{
    if(!dtFormatter)
    {
        dtFormatter =  [[NSDateFormatter alloc] init];
    }
    [dtFormatter setDateFormat:aFormat];
    [dtFormatter setTimeZone:[NSTimeZone localTimeZone]];
    
    return [dtFormatter stringFromDate:date];
}

+(NSDate *)  dateFromStringDate:(NSString *) date withFormat:(NSString *) aFormat
{
	if(!dtFormatter)
		{
        dtFormatter =  [[NSDateFormatter alloc] init];
		}
    [dtFormatter setDateFormat:aFormat];
    
    return [dtFormatter dateFromString:date];
}

+(NSString *) getTimeLabel:(int) timeDiff
{
    if(timeDiff > 60)
    {
        int h = timeDiff/3600;
        int m = (timeDiff - h * 3600)/60;
        //  int s = timeDiff%60;
        if(h > 0)
        {
            if(h < 24)
                return [NSString stringWithFormat:@"%d hours ago",h];
            return nil;
        }
        else if(m>0)
        {
            
            return [NSString stringWithFormat:@"%d minutes ago",m];
        }
        
    }
    return [NSString stringWithFormat:@"%d seconds ago",timeDiff];
}


+(NSDate *) getZeroTZDate
{
	NSDate *sourceDate = [NSDate date];
    //set timezones
    NSTimeZone* destinationTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSTimeZone* sourceTimeZone  = [NSTimeZone systemTimeZone];
    
    //calc time difference
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    //set current real date
    NSDate *destDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
	return destDate;
}

+(NSString *) getZeroTZDateStr
{
	return [DateTimeUtil getGMTStringDateFrom:[DateTimeUtil getZeroTZDate]];
}

+(NSString *) getGMTStringDateFrom:(NSDate *) date
{
	return [DateTimeUtil stringFromDateTime:date withFormat:DATE_FMT_DD_MM_YYYY__HH_MM_SS_24];
}

+(NSDate *) getGMTDateFromStrDate:(NSString *) date
{
	return [DateTimeUtil dateFromStringDate:date withFormat:DATE_FMT_DD_MM_YYYY__HH_MM_SS_24];
}



+(NSString *) serverDateFromDisplayDate:(NSDate *) date
{
	return [DateTimeUtil stringFromDateTime:date withFormat:DATE_FMT_DD_MM_YYYY__HH_MM_SS_24];
}
+(NSString *) serverDateFromDisplayDateStr:(NSString *) date
{
	NSDate *date2 = [DateTimeUtil dateFromStringDate:date withFormat:DATE_FMT_DD_MM_YYYY];

	return [DateTimeUtil serverDateFromDisplayDate:date2];

}
+(NSString *) displayDateFromServerDate:(NSDate *) date
{
  return [DateTimeUtil stringFromDateTime:date withFormat:DATE_FMT_DD_MM_YYYY];
}
+(NSString *) displayDateFromServerDateStr:(NSString *) date
{
	NSDate *date2 = [DateTimeUtil dateFromStringDate:date withFormat:DATE_FMT_DD_MM_YYYY__HH_MM_SS_24];

	return [DateTimeUtil displayDateFromServerDate:date2];

}

+(NSString *) displayDateTimeFromServerDate:(NSDate *) date
{
	return [DateTimeUtil stringFromDateTime:date withFormat:DATE_FMT_DD_MM_YYYY__HH_MM_SS_24];
}
+(NSString *) displayDateTimeFromServerDateStr:(NSString *) date
{
	NSDate *date2 = [DateTimeUtil dateFromStringDate:date withFormat:DATE_FMT_DD_MM_YYYY__HH_MM_SS_24];

	return [DateTimeUtil displayDateTimeFromServerDate:date2];

}
+(NSDate *) getTodaysDate
{
NSCalendar* myCalendar = [NSCalendar currentCalendar];
 NSDateComponents* components = [myCalendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
											fromDate:[NSDate date]];
[components setHour: 0];
[components setMinute: 0];
[components setSecond: 0];
	return [myCalendar dateFromComponents:components];

}
+(NSDate *) getDateAfterAddDays:(NSInteger) day
{
	NSCalendar* myCalendar = [NSCalendar currentCalendar];
	NSDateComponents* components = [myCalendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
												 fromDate:[NSDate date]];
	[components setDay:(components.day + day)];
	[components setHour: 0];
	[components setMinute: 0];
	[components setSecond: 0];
	return [myCalendar dateFromComponents:components];
}

+(NSDate *) getDateBeforeYears:(NSInteger) year
{
    NSCalendar* myCalendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [myCalendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                                 fromDate:[NSDate date]];
    [components setYear:-year];
    [components setMonth:components.month];
    [components setDay:components.day];
    
    NSDate * maxDate = [myCalendar dateByAddingComponents: components toDate: [NSDate date] options: 0];
    return maxDate;

}


+(NSDate *) weekStartDate
{
	NSDateComponents *component = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit| NSWeekdayCalendarUnit|NSWeekCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit)  fromDate:[NSDate date]];
	[component setWeekday:1];
	[component setHour:0];
	[component setMinute:0];
	[component setSecond:1];

	return [[NSCalendar currentCalendar] dateFromComponents:component];

}
+(NSDate *) weekEndDate
{
	NSDateComponents *component = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit| NSWeekdayCalendarUnit|NSWeekCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit)  fromDate:[NSDate date]];
	[component setWeekday:7];
	[component setHour:23];
	[component setMinute:59];
	[component setSecond:59];

	return [[NSCalendar currentCalendar] dateFromComponents:component];
}
+(NSDate *) monthStartDate
{
	NSDateComponents *component = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit| NSWeekdayCalendarUnit|NSWeekCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit)  fromDate:[NSDate date]];
	[component setDay:1];
	[component setHour:0];
	[component setMinute:0];
	[component setSecond:1];

	return [[NSCalendar currentCalendar] dateFromComponents:component];
}
+(NSDate *) monthEndDate
{
	NSDateComponents *component = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit| NSWeekdayCalendarUnit|NSWeekCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit)  fromDate:[NSDate date]];
	[component setDay:0];
	[component setMonth:[component month]+1];
	[component setHour:23];
	[component setMinute:59];
	[component setSecond:59];

	return [[NSCalendar currentCalendar] dateFromComponents:component];
}

+(NSDate *) dayStartDate:(NSDate *) date
{
	if(!date)
		date = [NSDate date];

	NSDateComponents *component = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit| NSWeekdayCalendarUnit|NSWeekCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit)  fromDate:date];
	[component setHour:0];
	[component setMinute:0];
	[component setSecond:01];

	return [[NSCalendar currentCalendar] dateFromComponents:component];
}

+(NSDate *) dayEndDate:(NSDate *) date
{
	if(!date)
		date = [NSDate date];

	NSDateComponents *component = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit| NSWeekdayCalendarUnit|NSWeekCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit)  fromDate:date];
	[component setHour:23];
	[component setMinute:59];
	[component setSecond:59];

	return [[NSCalendar currentCalendar] dateFromComponents:component];
}

+(NSString *)dayFromDate:(NSDate *)date
{
	if(!dtFormatter)
	{
        dtFormatter =  [[NSDateFormatter alloc] init];
	}
    [dtFormatter setDateFormat:@"EEE"];

    return [dtFormatter stringFromDate:date];
}

@end
