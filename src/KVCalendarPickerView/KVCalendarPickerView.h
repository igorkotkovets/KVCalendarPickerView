//
//  KVCalendarPickerView.h
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/22/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

@import UIKit;

#import "KVCalendarConstants.h"
#import "KVCalendarDateTile.h"

@class KVCalendarPickerView;
@protocol KVCalendarPickerViewDelegate <NSObject>
- (void)calendarPickerView:(KVCalendarPickerView *)picker
           didShowTile:(KVCalendarDateTile *)tile;
- (void)calendarPickerView:(KVCalendarPickerView *)picker
              didSelectDate:(NSDate *)date;
@end

@interface KVCalendarPickerView : UIView
@property (nonatomic, weak) IBOutlet id<KVCalendarPickerViewDelegate> delegate;

- (void)setFirstWeekday:(MonthCalendarWeekBeginsFromDay)firstWeekday;
- (MonthCalendarWeekBeginsFromDay)firstWeekday;
- (void)showDate:(NSDate *)date;
@end
