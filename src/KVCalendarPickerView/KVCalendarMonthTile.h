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
    id<KVCalendarMonthTileDelegate> _delegate;
    UIButton *_monthButton;
}

-(void)setMonthString:(NSString *)string;

-(void)setDelegate:(id<KVCalendarMonthTileDelegate>)delegate;
-(id<KVCalendarMonthTileDelegate>)delegate;

@end
