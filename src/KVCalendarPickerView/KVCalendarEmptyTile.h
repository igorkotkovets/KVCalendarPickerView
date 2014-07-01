//
//  KVCalendarEmptyTile.h
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/22/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVCalendarTile.h"

@interface KVCalendarEmptyTile : KVCalendarTile
- (Class)getNextTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        nextDate:(NSDate **)date;
- (Class)getPreviousTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        previousDate:(NSDate **)date;
@end
