//
//  KVCalendarMonthLabel.h
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/22/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVCalendarTile.h"

@class KVCalendarMonthTile;
@protocol KVCalendarMonthTileDelegate <NSObject>
-(void)didSelectCalendarMonthTile:(KVCalendarMonthTile *)view withDate:(NSDate *)date;
@end

@interface KVCalendarMonthTile : KVCalendarTile
{
    UIButton *_monthButton;
}

@property (nonatomic, weak) id<KVCalendarMonthTileDelegate> delegate;

-(void)setMonthString:(NSString *)string;

- (Class)getNextTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        nextDate:(NSDate **)date;
- (Class)getPreviousTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        previousDate:(NSDate **)date;

@end
