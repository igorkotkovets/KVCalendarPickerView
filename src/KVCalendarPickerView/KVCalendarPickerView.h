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
@protocol KVCalendarPickerViewDatasource <NSObject>
- (void)weekBeginsFromDayInMonthCalendarPicker:(KVCalendarPickerView *)picker
                               willDisplayTile:(KVCalendarTile *)tile;
@end


@protocol KVCalendarPickerViewDelegate <NSObject>
- (void)monthCalendarPicker:(KVCalendarPickerView *)picker willDisplayTile:(KVCalendarTile *)tile;
- (void)monthCalendarPicker:(KVCalendarPickerView *)picker didChangeSelectedMonth:(NSDate *)date;
-(void)monthCalendarPicker:(KVCalendarPickerView *)picker didSelectDate:(NSDate *)date;
@end

@interface KVCalendarPickerView : UIView
@property (nonatomic, weak) IBOutlet id<KVCalendarPickerViewDelegate> delegate;
@property (nonatomic, weak) IBOutlet id<KVCalendarPickerViewDatasource> datasource;
@property (nonatomic, assign) MonthCalendarWeekBeginsFromDay firstWeekday;
@end
