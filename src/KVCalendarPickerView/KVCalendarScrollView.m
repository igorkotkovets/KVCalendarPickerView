//
//  KVCalendarScrollView.m
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/21/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVCalendarScrollView.h"

#import "NSDate+KVCalendarUtils.h"
#import "KVCalendarDateController.h"
#import "KVCalendarDateTile.h"
#import "KVCalendarMonthTile.h"
#import "KVCalendarEmptyTile.h"
#import "KVCalendarScrollView+Protected.h"
#import "KVDateTileProvider.h"
#import "KVCalendarTile+Protected.h"


@interface KVCalendarScrollView ()
<UIScrollViewDelegate>
@property (atomic, assign) BOOL isInited;
@property (nonatomic, assign) CGSize tileSize;

- (void)setupImagesScroll;
- (void)setupContent;
- (void)recenterIfNecessary;

- (CGPoint)topLeftContentOffset;
- (CGPoint)bottomRightContentOffset;
- (void)updateTilesFromTopLeftPoint:(CGPoint)tl toBottomRightPoint:(CGPoint)br;

- (void)addTilesToBottomRightPoint:(CGPoint)br fromLeftX:(CGFloat)x;
- (void)addTilesToTopLeftPoint:(CGPoint)tl fromRightX:(CGFloat)x;
- (void)removeTilesOutOfTopLeftPoint:(CGPoint)tl toBottomRightPoint:(CGPoint)br;
@end

@implementation KVCalendarScrollView
-(void)dealloc
{
    [self.loadedViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.loadedViews removeAllObjects];
}

- (id)initWithFrame:(CGRect)frame
       dateProvider:(KVCalendarDateController *)provider
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.dateProvider = provider;
        [self setupImagesScroll];
    }
    return self;
}

- (void)setupImagesScroll
{
    self.loadedViews = [[NSMutableArray alloc] init];
    
    [super setDelegate:self];
    [self setDecelerationRate:UIScrollViewDecelerationRateNormal];
    [self setPagingEnabled:NO];
    [self setAlwaysBounceHorizontal:NO];
    [self setAlwaysBounceVertical:YES];
    [self setShowsVerticalScrollIndicator:NO];
}

- (void)setupContent
{
    self.tileSize = [self.calendarScrollDatasource
                     monthScrollViewGetFixedTileSize:self];
    
    CGSize sz = [self frame].size;
    [self setContentSize:CGSizeMake(sz.width, 7.f*sz.height)];
    [self setContentOffset:CGPointZero];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.isInited)
    {
        [self setupContent];
        self.isInited = YES;
    }
    
    [self recenterIfNecessary];
    
    CGPoint tl = [self topLeftContentOffset];
    CGPoint br = [self bottomRightContentOffset];
    
    [self updateTilesFromTopLeftPoint:tl toBottomRightPoint:br];
}

- (void)recenterIfNecessary
{
    CGFloat contentHeight = [self contentSize].height;
    CGPoint currentOffset = [self contentOffset];
    currentOffset.y = MAX(0, currentOffset.y);
    currentOffset.y = MIN(currentOffset.y, contentHeight-[self bounds].size.height);
    CGFloat centerOffsetY = (contentHeight - [self bounds].size.height) / 2.0;
    CGFloat distanceFromCenter = currentOffset.y - centerOffsetY;
    CGFloat absDistanceFromCenter = fabs(distanceFromCenter);
    
    if (absDistanceFromCenter>=contentHeight/4.f)
    {
        self.contentOffset = CGPointMake(currentOffset.x, centerOffsetY);
        for (UIView *view in self.loadedViews)
        {
            CGPoint center = view.center;
            center.y += (centerOffsetY - currentOffset.y);
            view.center = center;
        }
    }
}

- (CGPoint)topLeftContentOffset
{
    CGSize contentSize = self.contentSize;
    CGPoint contentOffset = self.contentOffset;
    contentOffset.y = MAX(0, contentOffset.y);
    contentOffset.y = MIN(contentOffset.y, contentSize.height-[self bounds].size.height);
    
    return contentOffset;
}

- (CGPoint)bottomRightContentOffset
{
    CGSize contentSize = self.contentSize;
    CGSize selfSize = [self frame].size;
    CGPoint contentOffset = self.contentOffset;
    contentOffset.y = MAX(0, contentOffset.y);
    contentOffset.y = MIN(contentOffset.y, contentSize.height-[self bounds].size.height);
    CGPoint br = CGPointMake(contentOffset.x+selfSize.width, contentOffset.y+selfSize.height);
    
    return br;
}

#pragma mark -

- (void)updateTilesFromTopLeftPoint:(CGPoint)tl toBottomRightPoint:(CGPoint)br
{
    if ((br.x - tl.x)<=0 || (br.y - tl.y)<=0) return;
    
    if ([self.loadedViews count]==0)
    {
        NSDate *date = [self.dateProvider beginOfWeekBaseDate];
        CGPoint pt = tl;
        [KVDateTileProvider target:self
                   addTileWithDate:date
                     onBottomRight:&pt
                            column:0];
    }
    
    [self addTilesToTopLeftPoint:tl fromRightX:br.x];
    [self addTilesToBottomRightPoint:br fromLeftX:tl.x];
    [self removeTilesOutOfTopLeftPoint:tl toBottomRightPoint:br];
}

- (void)addTilesToBottomRightPoint:(CGPoint)br fromLeftX:(CGFloat)x
{
    KVCalendarTile *lastView = [self.loadedViews lastObject];
    NSInteger column = lastView.column;
    CGPoint rightEdgePoint = CGPointMake(CGRectGetMaxX(lastView.frame),
                                         CGRectGetMinY(lastView.frame));
    
    while (rightEdgePoint.y<br.y)
    {
        while (rightEdgePoint.x<br.x) {
            NSDate *date = nil;
            Class tileProvider = [lastView getNextTileViewProviderWithDateProvider:self.dateProvider
                                                                          nextDate:&date];
            lastView = [tileProvider target:self
                            addTileWithDate:date
                              onBottomRight:&rightEdgePoint
                                     column:column];
            
            ++column;
        }
        
        rightEdgePoint.x = x;
        rightEdgePoint.y += _tileSize.height;
        column = 0;
    }
}

- (void)addTilesToTopLeftPoint:(CGPoint)tl fromRightX:(CGFloat)x
{
    KVCalendarTile *firstView = [self.loadedViews firstObject];
    NSInteger column = firstView.column;
    CGPoint leftTopEdgePoint = CGPointMake(CGRectGetMinX(firstView.frame),
                                           CGRectGetMinY(firstView.frame));
    
    if (leftTopEdgePoint.x<=x)
    {
        leftTopEdgePoint.x = x;
        column = days_in_week-1;
    }
    
    while (leftTopEdgePoint.y>tl.y)
    {
        while (leftTopEdgePoint.x>tl.x)
        {
            NSDate *date = nil;
            Class tileProvider =
            [firstView getPreviousTileViewProviderWithDateProvider:self.dateProvider
                                                      previousDate:&date];
            firstView = [tileProvider target:self
                             addTileWithDate:date
                                   onTopLeft:&leftTopEdgePoint
                                      column:column];
            
            --column;
        }
        
        leftTopEdgePoint.x = x;
        leftTopEdgePoint.y -= _tileSize.height;
        column = days_in_week-1;
    }
}

-(void)removeTilesOutOfTopLeftPoint:(CGPoint)tl toBottomRightPoint:(CGPoint)br
{
    KVCalendarTile *lastView = [self.loadedViews lastObject];
    //    while ([lastView frame].origin.y >= br.y+_tileSize.height)
    while ([lastView frame].origin.y >= br.y+([self isDecelerating]||[self isDragging]?_tileSize.height:0.f))
    {
        [lastView removeFromSuperview];
        [self.loadedViews removeLastObject];
        lastView = [self.loadedViews lastObject];
    }
    
    KVCalendarTile *firstView = [self.loadedViews firstObject];
    //    while (firstView && CGRectGetMaxY([firstView frame]) <= tl.y-_tileSize.height)
    while (firstView && CGRectGetMaxY([firstView frame]) <= tl.y-([self isDecelerating]||[self isDragging]?_tileSize.height:0.f))
    {
        [firstView removeFromSuperview];
        [self.loadedViews removeObject:firstView];
        firstView = [self.loadedViews firstObject];
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.userInteractionEnabled = YES;
    
    [self performSelector:@selector(notifyDelegateScrollViewDidFinishScrollAnimating) withObject:nil afterDelay:0];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self performSelector:@selector(notifyDelegateScrollViewDidFinishScrollAnimating) withObject:nil afterDelay:0];;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
        [self performSelector:@selector(notifyDelegateScrollViewDidFinishScrollAnimating) withObject:nil afterDelay:0];
}

- (void)notifyDelegateScrollViewDidFinishScrollAnimating
{
    [self.calendarScrollDelegate calendarScrollViewDidFinishScrollAnimating:self];
}

#pragma mark - public

- (void)reloadData
{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.loadedViews removeAllObjects];
    
    [self setupContent];
    
    [self setNeedsLayout];
}

- (KVCalendarDateTile *)dequeueReusableCalendarTileFromTop
{
    CGPoint tl = [self topLeftContentOffset];
    KVCalendarDateTile *reusableView = nil;
    for (NSInteger i=0; i<[self.loadedViews count]; ++i)
    {
        reusableView = [self.loadedViews objectAtIndex:i];
        if (reusableView && CGRectGetMaxY(reusableView.frame)<tl.y)
        {
            if ([reusableView isKindOfClass:[KVCalendarDateTile class]])
            {
                [reusableView removeFromSuperview];
                [self.loadedViews removeObject:reusableView];
                return reusableView;
            }
            else {
                break;
            }
        }
        else
        {
            break;
        }
    }
    
    return nil;
}

- (KVCalendarDateTile *)dequeueReusableCalendarTileFromBottom
{
    CGPoint br = [self bottomRightContentOffset];
    KVCalendarDateTile *reusableView = nil;
    for (NSInteger i=[self.loadedViews count]-1; i>=0; --i)
    {
        reusableView = [self.loadedViews objectAtIndex:i];
        if (reusableView && CGRectGetMinY([reusableView frame])>br.y)
        {
            if ([reusableView isKindOfClass:[KVCalendarDateTile class]])
            {
                [reusableView removeFromSuperview];
                [self.loadedViews removeObject:reusableView];
                return reusableView;
            }
            else {
                break;
            }
        }
        else
        {
            break;
        }
    }
    
    return nil;
}

- (KVCalendarEmptyTile *)dequeueReusableCalendarEmptyTileFromTop
{
    CGPoint tl = [self topLeftContentOffset];
    KVCalendarEmptyTile *reusableView = nil;
    for (NSInteger i=0; i<[self.loadedViews count]; ++i)
    {
        reusableView = [self.loadedViews objectAtIndex:i];
        if (reusableView && CGRectGetMaxY(reusableView.frame)<tl.y)
        {
            if ([reusableView isKindOfClass:[KVCalendarEmptyTile class]])
            {
                [reusableView removeFromSuperview];
                [self.loadedViews removeObject:reusableView];
                return reusableView;
            }
            else {
                break;
            }
        }
        else
        {
            break;
        }
    }
    
    return nil;
}

- (KVCalendarEmptyTile *)dequeueReusableCalendarEmptyTileFromBottom
{
    CGPoint br = [self bottomRightContentOffset];
    KVCalendarEmptyTile *reusableView = nil;
    for (NSInteger i=[self.loadedViews count]-1; i>=0; --i)
    {
        reusableView = [self.loadedViews objectAtIndex:i];
        if (reusableView && CGRectGetMinY([reusableView frame])>br.y)
        {
            if ([reusableView isKindOfClass:[KVCalendarEmptyTile class]])
            {
                [reusableView removeFromSuperview];
                [self.loadedViews removeObject:reusableView];
                return reusableView;
            }
            else {
                break;
            }
        }
        else
        {
            break;
        }
    }
    
    return nil;
}

- (KVCalendarMonthTile *)dequeueReusableCalendarMonthTileFromTop
{
    CGPoint tl = [self topLeftContentOffset];
    KVCalendarMonthTile *reusableView = nil;
    for (NSInteger i=0; i<[self.loadedViews count]; ++i)
    {
        reusableView = [self.loadedViews objectAtIndex:i];
        if (reusableView && CGRectGetMaxY(reusableView.frame)<tl.y)
        {
            if ([reusableView isKindOfClass:[KVCalendarMonthTile class]])
            {
                [reusableView removeFromSuperview];
                [self.loadedViews removeObject:reusableView];
                return reusableView;
            }
            else {
                break;
            }
        }
        else
        {
            break;
        }
    }
    
    return nil;
}

- (KVCalendarMonthTile *)dequeueReusableCalendarMonthTileFromBottom
{
    CGPoint br = [self bottomRightContentOffset];
    KVCalendarMonthTile *reusableView = nil;
    for (NSInteger i=[self.loadedViews count]-1; i>=0; --i)
    {
        reusableView = [self.loadedViews objectAtIndex:i];
        if (reusableView && CGRectGetMinY([reusableView frame])>br.y)
        {
            if ([reusableView isKindOfClass:[KVCalendarMonthTile class]])
            {
                [reusableView removeFromSuperview];
                [self.loadedViews removeObject:reusableView];
                return reusableView;
            }
            else {
                break;
            }
        }
        else
        {
            break;
        }
    }
    
    return nil;
}

@end
