//
//  KVTileProvider.m
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/24/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVTileProvider.h"

@implementation KVTileProvider
+ (KVCalendarTile *)target:(KVCalendarScrollView *)scrollView
           addTileWithDate:(NSDate *)date
             onBottomRight:(inout CGPoint*)rightEdge
                    column:(NSInteger)column
{
    @throw [NSException exceptionWithName:@"Method not found"
                                   reason:@"Method not implemented in base class"
                                 userInfo:nil];
}

+ (KVCalendarTile *)target:(KVCalendarScrollView *)scrollView
           addTileWithDate:(NSDate *)date
                 onTopLeft:(inout CGPoint *)leftEdge
                    column:(NSInteger)column
{
    @throw [NSException exceptionWithName:@"Method not found"
                                   reason:@"Method not implemented in base class"
                                 userInfo:nil];
}
@end
