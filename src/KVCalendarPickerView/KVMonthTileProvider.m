//
//  KVMonthTileProvider.m
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/24/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVMonthTileProvider.h"

#import "KVCalendarMonthTile.h"
#import "KVCalendarScrollView+Protected.h"

@implementation KVMonthTileProvider
+ (KVCalendarTile *)target:(KVCalendarScrollView *)scrollView
           addTileWithDate:(NSDate *)date
             onBottomRight:(inout CGPoint*)rightEdge
                    column:(NSInteger)column
{
    KVCalendarMonthTile *tv = [scrollView dequeueReusableCalendarMonthTileFromTop];
    if (tv == nil) {
        tv = [scrollView.calendarScrollDatasource monthScrollView:scrollView
                                  createCalendarMonthTileWithDate:date
                                                     column:column];
    }
    else {
        [scrollView.calendarScrollDatasource configureCalendarMonthTile:tv
                                                               withDate:date
                                                                 column:column];
    }
    
    CGRect frame = [tv frame];
    frame.origin.x = (*rightEdge).x;
    frame.origin.y = (*rightEdge).y;
    [tv setFrame:frame];
    
    [scrollView addSubview:tv];
    [scrollView.loadedViews addObject:tv];
    *rightEdge = CGPointMake(CGRectGetMaxX(frame), (*rightEdge).y);
    
    return tv;
}

+ (KVCalendarTile *)target:(KVCalendarScrollView *)scrollView
           addTileWithDate:(NSDate *)date
                 onTopLeft:(inout CGPoint *)leftEdge
                    column:(NSInteger)column
{
    KVCalendarMonthTile *tv = [scrollView dequeueReusableCalendarMonthTileFromBottom];
    if (tv == nil) {
        tv = [scrollView.calendarScrollDatasource monthScrollView:scrollView
                                  createCalendarMonthTileWithDate:date
                                                           column:column];
    }
    else {
        [scrollView.calendarScrollDatasource configureCalendarMonthTile:tv
                                                               withDate:date
                                                                 column:column];
    }
    
    CGRect frame = [tv frame];
    frame.origin.x = (*leftEdge).x-frame.size.width;
    frame.origin.y = (*leftEdge).y-frame.size.height;
    [tv setFrame:frame];
    
    [scrollView addSubview:tv];
    [scrollView.loadedViews insertObject:tv atIndex:0];
    (*leftEdge) = CGPointMake(CGRectGetMinX(frame), CGRectGetMaxY(frame));
    
    return tv;
}
@end
