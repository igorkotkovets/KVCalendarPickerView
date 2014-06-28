//
//  KVTileProvider.h
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/24/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KVCalendarTile;
@class KVCalendarScrollView;
@interface KVTileProvider : NSObject
+ (KVCalendarTile *)target:(KVCalendarScrollView *)scrollView
           addTileWithDate:(NSDate *)date
             onBottomRight:(inout CGPoint*)rightEdge
                    column:(NSInteger)column;

+ (KVCalendarTile *)target:(KVCalendarScrollView *)scrollView
           addTileWithDate:(NSDate *)date
                 onTopLeft:(inout CGPoint *)leftEdge
                    column:(NSInteger)column;
@end
