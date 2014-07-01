//
//  KVEmptyTileProvider.h
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/24/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVTileProvider.h"

@class KVCalendarDateController;
@interface KVEmptyTileProvider : KVTileProvider
- (Class)getNextTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        nextDate:(NSDate **)date;
- (Class)getPreviousTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        previousDate:(NSDate **)date;
@end
