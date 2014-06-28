//
//  NSDate+KVCalendarUtils.h
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/21/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (KVCalendarUtils)
- (NSDate *)dateByAddingDays:(NSInteger)days calendar:(NSCalendar *)calendar;
- (BOOL)isWeekday:(NSCalendar *)calendar;
- (BOOL)isWeekend:(NSCalendar *)calendar;
- (BOOL)isEqualToDate:(NSDate *)otherDate
          components:(NSCalendarUnit)components
            calendar:(NSCalendar *)calendar;
-(BOOL)isEqualMonth:(NSDate *)date calendar:(NSCalendar *)calendar;
@end
