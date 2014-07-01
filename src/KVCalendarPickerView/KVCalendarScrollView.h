//
//  KVCalendarScrollView.h
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/21/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

@import UIKit;

#import "KVCalendarTile.h"

@class KVCalendarDateController;
@class KVCalendarScrollView;
@class KVCalendarDateTile;
@class KVCalendarMonthTile;
@class KVCalendarEmptyTile;

@protocol KVCalendarScrollViewDatasource <NSObject>

- (KVCalendarDateTile *)monthScrollView:(KVCalendarScrollView *)view
             createCalendarTileWithDate:(NSDate *)date
                                 column:(NSInteger)column;
- (void)configureCalendarTile:(KVCalendarDateTile *)tile
                     withDate:(NSDate *)date
                       column:(NSInteger)column;

- (KVCalendarEmptyTile *)monthScrollView:(KVCalendarScrollView *)view
         createCalendarEmptyTileWithDate:(NSDate *)date
                                  column:(NSInteger)column;
- (void)configureCalendarEmptyTile:(KVCalendarEmptyTile *)tile
                          withDate:(NSDate *)date
                            column:(NSInteger)column;

- (KVCalendarMonthTile *)monthScrollView:(KVCalendarScrollView *)view
         createCalendarMonthTileWithDate:(NSDate *)date
                                  column:(NSInteger)column;
- (void)configureCalendarMonthTile:(KVCalendarMonthTile *)tile
                          withDate:(NSDate *)date
                            column:(NSInteger)column;


- (CGSize)monthScrollViewGetFixedTileSize:(KVCalendarScrollView *)view;
@end


@protocol KVCalendarScrollViewDelegate <NSObject>
- (void)calendarScrollViewDidFinishScrollAnimating:(KVCalendarScrollView *)view;
@end


@interface KVCalendarScrollView : UIScrollView
{
    NSMutableArray *_loadedViews;
}

@property (nonatomic, weak) IBOutlet id<KVCalendarScrollViewDatasource> calendarScrollDatasource;
@property (nonatomic, weak) IBOutlet id<KVCalendarScrollViewDelegate> calendarScrollDelegate;
@property(nonatomic, strong) KVCalendarDateController *dateProvider;

- (id)initWithFrame:(CGRect)frame
      dateProvider:(KVCalendarDateController *)provider;

- (void)reloadData;
- (void)stopScrolling;
- (KVCalendarDateTile *)dequeueReusableCalendarTileFromTop;
- (KVCalendarDateTile *)dequeueReusableCalendarTileFromBottom;

- (KVCalendarEmptyTile *)dequeueReusableCalendarEmptyTileFromTop;
- (KVCalendarEmptyTile *)dequeueReusableCalendarEmptyTileFromBottom;

- (KVCalendarMonthTile *)dequeueReusableCalendarMonthTileFromTop;
- (KVCalendarMonthTile *)dequeueReusableCalendarMonthTileFromBottom;
@end
