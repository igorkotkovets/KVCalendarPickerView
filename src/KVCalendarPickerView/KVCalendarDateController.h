//
//  KVCalendarController.h
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/20/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KVCalendarConstants.h"


@interface KVCalendarDateController : NSObject
-(id)initWithBaseDate:(NSDate *)date;
-(id)initWithBaseDate:(NSDate *)date beginOfWeek:(MonthCalendarWeekBeginsFromDay)day;

-(NSDate *)beginOfWeekBaseDate;
-(NSString *)monthStringFromDate:(NSDate *)date;
-(NSString *)dayStringFromDate:(NSDate *)date;
-(NSDate *)date:(NSDate *)date byAddingDays:(NSInteger)days;

-(BOOL)isDifferentMonthsDate:(NSDate *)date1 andDate:(NSDate *)date2;
-(NSInteger)dayColumnIndexOfDate:(NSDate *)date;
-(BOOL)isFirstDayInMonth:(NSDate *)date;
-(BOOL)isLastDayInMonth:(NSDate *)date;
@end
