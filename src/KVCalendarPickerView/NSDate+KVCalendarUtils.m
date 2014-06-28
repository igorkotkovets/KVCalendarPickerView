//
//  NSDate+KVCalendarUtils.m
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/21/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "NSDate+KVCalendarUtils.h"

@implementation NSDate (KVCalendarUtils)
- (NSDate *)dateByAddingDays:(NSInteger)days calendar:(NSCalendar *)calendar
{
    NSDateComponents *incrementalComponents = [[NSDateComponents alloc] init];
    [incrementalComponents setDay:days];
    NSDate *newDate = [calendar dateByAddingComponents:incrementalComponents
                                                toDate:self
                                               options:0];
    return newDate;
}

- (BOOL)isWeekday:(NSCalendar *)calendar
{
    return ![self isWeekend:calendar];
}

- (BOOL)isWeekend:(NSCalendar *)calendar
{
    NSRange weekdayRange = [calendar maximumRangeOfUnit:NSWeekdayCalendarUnit];
    NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSUInteger weekdayOfDate = [components weekday];
    
    return (weekdayOfDate == weekdayRange.location || weekdayOfDate == weekdayRange.length);
}

-(BOOL)isEqualToDate:(NSDate *)otherDate
          components:(NSCalendarUnit)components
            calendar:(NSCalendar *)calendar
{
    NSDateComponents *selfComponents = [calendar components:components fromDate:self];
    NSDateComponents *dateComponents = [calendar components:components fromDate:otherDate];
    
    if ((components&NSCalendarUnitSecond)
        && selfComponents.second != dateComponents.second)
    {
        return NO;
    }
    
    if ((components&NSCalendarUnitMinute)
        && selfComponents.minute != dateComponents.minute)
    {
        return NO;
    }
    
    if ((components&NSCalendarUnitHour)
        && selfComponents.hour != dateComponents.hour)
    {
        return NO;
    }
    
    if ((components&NSCalendarUnitDay)
        && selfComponents.day != dateComponents.day)
    {
        return NO;
    }
    
    if ((components&NSCalendarUnitMonth)
        && selfComponents.month != dateComponents.month)
    {
        return NO;
    }
    
    if ((components&NSCalendarUnitYear)
        && selfComponents.year != dateComponents.year)
    {
        return NO;
    }
    
    if ((components&NSCalendarUnitEra)
        && selfComponents.era != dateComponents.era)
    {
        return NO;
    }
    
    if ((components&NSCalendarUnitWeekday)
        && selfComponents.weekday != dateComponents.weekday)
    {
        return NO;
    }
    
    if ((components&NSCalendarUnitWeekdayOrdinal)
        && selfComponents.weekdayOrdinal != dateComponents.weekdayOrdinal)
    {
        return NO;
    }
    
    if ((components&NSCalendarUnitQuarter)
        && selfComponents.quarter != dateComponents.quarter)
    {
        return NO;
    }
    
    if ((components&NSCalendarUnitWeekOfMonth)
        && selfComponents.weekOfMonth != dateComponents.weekOfMonth)
    {
        return NO;
    }
    
    if ((components&NSCalendarUnitWeekOfYear)
        && selfComponents.weekOfYear != dateComponents.weekOfYear)
    {
        return NO;
    }
    
    if ((components&NSCalendarUnitYearForWeekOfYear)
        && selfComponents.yearForWeekOfYear != dateComponents.yearForWeekOfYear)
    {
        return NO;
    }
    
    if ((components&NSCalendarUnitCalendar)
        && selfComponents.calendar != dateComponents.calendar)
    {
        return NO;
    }
    
    if ((components&NSCalendarUnitTimeZone)
        && selfComponents.timeZone != dateComponents.timeZone)
    {
        return NO;
    }
    
    return YES;
}

-(BOOL)isEqualMonth:(NSDate *)date calendar:(NSCalendar *)calendar
{
    return [self isEqualToDate:date
                    components:NSYearCalendarUnit|NSMonthCalendarUnit
                      calendar:calendar];
}
@end
