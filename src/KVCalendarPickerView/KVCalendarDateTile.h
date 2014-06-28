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
    id<KVCalendarDateTileDelegate> _delegate;
    UIButton *_dateButton;
}

-(void)setDelegate:(id<KVCalendarDateTileDelegate>)delegate;
-(id<KVCalendarDateTileDelegate>)delegate;

-(void)setDateString:(NSString *)string;
@end
