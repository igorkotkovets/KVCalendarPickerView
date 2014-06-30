//
//  KVCalendarController.m
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/20/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVCalendarDateController.h"

#import "NSDate+KVCalendarUtils.h"

@interface KVCalendarDateController ()
@property(nonatomic, strong) NSDate *baseDate;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, assign) NSUInteger firstWeekDay;
@property (nonatomic, strong) NSDateFormatter *monthStringDateFormatter;
@property (nonatomic, strong) NSDateFormatter *dayStringDateFormatter;
@end

@implementation KVCalendarDateController
-(id)init
{
    return [self initWithBaseDate:[NSDate date]];
}

-(id)initWithBaseDate:(NSDate *)date
{
    return [self initWithBaseDate:date
                      beginOfWeek:MonthCalendarWeekBeginsDayFromMonday];
}

-(id)initWithBaseDate:(NSDate *)date
          beginOfWeek:(MonthCalendarWeekBeginsFromDay)day
{
    self = [super init];
    if (self) {
        NSAssert(date != nil, @"Base date can't be nil");
        self.baseDate = date;
        
        self.firstWeekDay = day;
        
        self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [self.calendar setFirstWeekday:self.firstWeekDay];
        self.calendar.timeZone = [NSTimeZone systemTimeZone];
        self.calendar.locale = [NSLocale currentLocale];
        
        self.monthStringDateFormatter = [[NSDateFormatter alloc] init];
        [self.monthStringDateFormatter setDateFormat:@"LLLL yyyy"];
        
        self.dayStringDateFormatter = [[NSDateFormatter alloc] init];
        [self.dayStringDateFormatter setDateFormat:@"d"];
    }
    
    return self;
}

-(NSDate *)beginOfWeekBaseDate
{
    return [self beginOfTheWeek:self.baseDate
                       calendar:self.calendar];
}

-(NSString *)monthStringFromDate:(NSDate *)date
{
    return [self.monthStringDateFormatter stringFromDate:date];
}

-(NSString *)dayStringFromDate:(NSDate *)date
{
    return [self.dayStringDateFormatter stringFromDate:date];
}

-(NSDate *)date:(NSDate *)date byAddingDays:(NSInteger)days
{
    return [date dateByAddingDays:days calendar:self.calendar];
}

-(BOOL)isDifferentMonthsDate:(NSDate *)date1 andDate:(NSDate *)date2
{
    return ![date1 isEqualToDate:date2 components:NSMonthCalendarUnit
                        calendar:self.calendar];
}

-(NSInteger)dayColumnIndexOfDate:(NSDate *)date
{
    NSDateComponents *weekdayComponents =
    [self.calendar components:NSWeekdayCalendarUnit
                     fromDate:date];
    NSInteger dayIndex = [weekdayComponents weekday];
    if (dayIndex == 1) {
        dayIndex = 8;
    }
    
    dayIndex = dayIndex - self.firstWeekDay;
    
    return dayIndex;
}

-(BOOL)isFirstDayInMonth:(NSDate *)date
{
    NSRange dayRange = [self.calendar rangeOfUnit:NSDayCalendarUnit
                                           inUnit:NSMonthCalendarUnit
                                          forDate:date];
    NSDateComponents *dateComponents = [self.calendar components:NSDayCalendarUnit
                                                        fromDate:date];
    
    return (dateComponents.day == dayRange.location);
}

-(BOOL)isLastDayInMonth:(NSDate *)date
{
    NSRange dayRange = [self.calendar rangeOfUnit:NSCalendarUnitDay
                                           inUnit:NSMonthCalendarUnit
                                          forDate:date];
    NSDateComponents *dateComponents = [self.calendar components:NSDayCalendarUnit
                                                        fromDate:date];
    
    return (dateComponents.day == dayRange.length);
}

#pragma mark -
#pragma mark - Private

- (NSDate *)beginOfTheWeek:(NSDate *)date calendar:(NSCalendar *)calendar
{
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit
                                                      fromDate:date];
    /*
     Create a date components to represent the number of days to subtract
     from the current date.
     The weekday value for Sunday in the Gregorian calendar is 1, so
     subtract 1 from the number
     of days to subtract from the date in question.  (If today's Sunday,
     subtract 0 days.)
     */
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    /* Substract [gregorian firstWeekday] to handle first day of the week being something else than Sunday */
    if ([weekdayComponents weekday] != 1) {
        [componentsToSubtract setDay: - ([weekdayComponents weekday] - [calendar firstWeekday])];
    }
    else {
        [componentsToSubtract setDay: - ([weekdayComponents weekday] - [calendar firstWeekday]) - 7];
    }
//    [componentsToSubtract setDay: - ([weekdayComponents weekday] - _firstWeekDay)];
    NSDate *beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract
                                                        toDate:date options:0];
    
    /*
     Optional step:
     beginningOfWeek now has the same hour, minute, and second as the
     original date (today).
     To normalize to midnight, extract the year, month, and day components
     and create a new date from those components.
     */
    NSDateComponents *components = [calendar components: (NSYearCalendarUnit |
                                                          NSMonthCalendarUnit |
                                                          NSDayCalendarUnit)
                                               fromDate: beginningOfWeek];
    beginningOfWeek = [calendar dateFromComponents: components];
    
    return beginningOfWeek;
}
@end
