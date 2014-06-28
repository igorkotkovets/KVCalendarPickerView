//
//  KVCalendarMonthLabel.m
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/22/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVCalendarMonthTile.h"

#import "KVCalendarDateController.h"
#import "KVEmptyTileProvider.h"
#import "KVDateTileProvider.h"

@interface KVCalendarMonthTile ()
@property(nonatomic, strong) UIButton *dateButton;

- (void)setupKVCalendarMonthTile;
- (void)monthButtonDidTouchUpInside:(id)sender;
@end

@implementation KVCalendarMonthTile
@synthesize dateButton = _dateButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupKVCalendarMonthTile];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setupKVCalendarMonthTile];
}

-(void)setDelegate:(id<KVCalendarMonthTileDelegate>)delegate
{
    _delegate = delegate;
}

-(id<KVCalendarMonthTileDelegate>)delegate
{
    return _delegate;
}

#pragma mark -
#pragma mark - Private

- (void)setupKVCalendarMonthTile
{
    self.backgroundColor = [UIColor clearColor];
    
    self.dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dateButton.frame = self.bounds;
    [self.dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.dateButton.enabled = NO;
    [self.dateButton addTarget:self
                        action:@selector(monthButtonDidTouchUpInside:)
              forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.dateButton];
}

- (void)setMonthString:(NSString *)string
{
    [self.dateButton setTitle:string forState:UIControlStateNormal];
    [self.dateButton setTitle:string forState:UIControlStateDisabled];
    [self.dateButton setTitle:string forState:UIControlStateHighlighted];
    [self.dateButton setTitle:string forState:UIControlStateSelected];
}

#pragma mark - 
#pragma mark - <Private>

- (void)monthButtonDidTouchUpInside:(id)sender
{
    if ([_delegate respondsToSelector:@selector(didSelectCalendarMonthTile:withDate:)])
    {
        [_delegate didSelectCalendarMonthTile:self withDate:self.date];
    }
}

#pragma mark -
#pragma mark - Protected

- (Class)getNextTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        nextDate:(NSDate **)date
{
    NSInteger dayIndex = [controller dayColumnIndexOfDate:self.date];
    
    if (dayIndex == 0)
    {
        *date = self.date;
        return [KVDateTileProvider class];
    }
    
    *date = self.date;
    return [KVEmptyTileProvider class];
}

- (Class)getPreviousTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        previousDate:(NSDate **)date
{
    NSDate *previousDate = [controller date:self.date
                               byAddingDays:-1];
    NSInteger dayIndex = [controller dayColumnIndexOfDate:previousDate];
    
    if (dayIndex == days_in_week-1
        && self.column != dayIndex)
    {
        *date = previousDate;
        return [KVDateTileProvider class];
    }
    
    *date = previousDate;
    return [KVEmptyTileProvider class];
}

@end
