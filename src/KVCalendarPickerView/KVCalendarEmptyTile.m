//
//  KVCalendarEmptyTile.m
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/22/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVCalendarEmptyTile.h"

#import "KVCalendarDateController.h"
#import "KVDateTileProvider.h"
#import "KVEmptyTileProvider.h"
#import "KVMonthTileProvider.h"


@interface KVCalendarEmptyTile ()
@end

@implementation KVCalendarEmptyTile

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupKVCalendarEmptyTile];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setupKVCalendarEmptyTile];
}

#pragma mark -
#pragma mark - Private

- (void)setupKVCalendarEmptyTile
{
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark -
#pragma mark - Protected

- (Class)getNextTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        nextDate:(NSDate **)date
{
    NSDate *nextDate = [controller date:self.date
                           byAddingDays:1];
    
    
    if ([controller isLastDayInMonth:self.date]
        && self.column == days_in_week-1)
    {
        *date = nextDate;
        return [KVMonthTileProvider class];
    }
    
    NSInteger dayIndex = [controller dayColumnIndexOfDate:self.date];
    if ([controller isFirstDayInMonth:self.date]
        && dayIndex == self.column+1)
    {
        *date = self.date;
        return [KVDateTileProvider class];
    }
    
    *date = self.date;
    return [KVEmptyTileProvider class];
}

- (Class)getPreviousTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        previousDate:(NSDate **)date
{
    if ([controller isFirstDayInMonth:self.date]
        && self.column == 0)
    {
        *date = self.date;
        return [KVMonthTileProvider class];
    }
    
    NSInteger dayIndex = [controller dayColumnIndexOfDate:self.date];
    
    if (dayIndex == self.column-1
        || self.column == 0)
    {
        *date = self.date;
        return [KVDateTileProvider class];
    }
    
    *date = self.date;
    return [KVEmptyTileProvider class];
}

@end
