//
//  KVCalendarTile.h
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/20/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

@import UIKit;


@class KVCalendarDateController;
@interface KVCalendarTile : UIView
@property(nonatomic, strong) NSDate *date;
@property(nonatomic, assign) NSInteger column;

- (Class)getNextTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        nextDate:(NSDate **)date;
- (Class)getPreviousTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        previousDate:(NSDate **)date;
@end
