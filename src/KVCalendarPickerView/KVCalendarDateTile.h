//
//  KVCalendarDate.h
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/22/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVCalendarTile.h"

@class KVCalendarTile;
@protocol KVCalendarDateTileDelegate <NSObject>
-(void)didSelectCalendarDateTile:(KVCalendarTile *)view withDate:(NSDate *)date;
@end

@interface KVCalendarDateTile : KVCalendarTile
{
    UIButton *_dateButton;
}

@property (nonatomic, weak) id<KVCalendarDateTileDelegate> delegate;

-(void)setDateString:(NSString *)string;

- (Class)getNextTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        nextDate:(NSDate **)date;
- (Class)getPreviousTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        previousDate:(NSDate **)date;
@end
