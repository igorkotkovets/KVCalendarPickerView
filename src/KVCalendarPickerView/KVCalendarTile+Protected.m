//
//  KVCalendarTile+Protected.m
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/21/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVCalendarTile+Protected.h"

#import "KVCalendarDateController.h"

@implementation KVCalendarTile (Protected)
- (Class)getNextTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        nextDate:(NSDate **)date
{
    @throw [NSException exceptionWithName:@"Method not found"
                                   reason:@"Method not implemented in base class"
                                 userInfo:nil];
}

- (Class)getPreviousTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        previousDate:(NSDate **)date
{
    @throw [NSException exceptionWithName:@"Method not found"
                                   reason:@"Method not implemented in base class"
                                 userInfo:nil];
}
@end
