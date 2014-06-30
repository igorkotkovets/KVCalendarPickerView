//
//  KVCalendarPickerView.h
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/22/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KVCalendarConstants.h"

@class KVCalendarTile;
@class KVCalendarPickerView;


@protocol KVCalendarPickerViewDelegate <NSObject>
- (void)monthCalendarPicker:(KVCalendarPickerView *)picker willDisplayTile:(KVCalendarTile *)tile;
- (void)monthCalendarPicker:(KVCalendarPickerView *)picker didChangeSelectedMonth:(NSDate *)date;
-(void)monthCalendarPicker:(KVCalendarPickerView *)picker didSelectDate:(NSDate *)date;
@end

@interface KVCalendarPickerView : UIView
@property (nonatomic, weak) IBOutlet id<KVCalendarPickerViewDelegate> delegate;

- (void)setFirstWeekday:(MonthCalendarWeekBeginsFromDay)firstWeekday;
- (MonthCalendarWeekBeginsFromDay)firstWeekday;
- (void)showDate:(NSDate *)date;
@end
