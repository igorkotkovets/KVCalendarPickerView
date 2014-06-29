//
//  KVCalendarDate.m
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/22/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVCalendarDateTile.h"

#import "KVCalendarTile+Protected.h"
#import "KVDateTileProvider.h"
#import "KVEmptyTileProvider.h"
#import "KVCalendarDateController.h"
#import "KVCalendarConstants.h"
#import "KVMonthTileProvider.h"


@interface KVCalendarTile ()
@property(nonatomic, strong) UIButton *dateButton;

- (void)setupKVCalendarDateTile;
- (void)monthButtonDidTouchUpInside:(id)sender;
@end

@implementation KVCalendarDateTile
@synthesize dateButton = _dateButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupKVCalendarDateTile];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setupKVCalendarDateTile];
}

- (void)setDelegate:(id<KVCalendarDateTileDelegate>)delegate
{
    _delegate = delegate;
}

- (id<KVCalendarDateTileDelegate>)delegate
{
    return _delegate;
}

- (void)setDateString:(NSString *)string
{
    [self.dateButton setTitle:string forState:UIControlStateNormal];
    [self.dateButton setTitle:string forState:UIControlStateDisabled];
    [self.dateButton setTitle:string forState:UIControlStateHighlighted];
    [self.dateButton setTitle:string forState:UIControlStateSelected];
}

#pragma mark -
#pragma mark - Private

- (void)setupKVCalendarDateTile
{
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5f;
    
    self.dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dateButton.frame = self.bounds;
    [self.dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.dateButton.enabled = NO;
    [self.dateButton addTarget:self
                        action:@selector(monthButtonDidTouchUpInside:)
              forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.dateButton];
}

- (void)monthButtonDidTouchUpInside:(id)sender
{
    if ([_delegate respondsToSelector:@selector(didSelectCalendarDateTile:withDate:)])
    {
        [_delegate didSelectCalendarDateTile:self withDate:self.date];
    }
}

#pragma mark -
#pragma mark - Protected

- (Class)getNextTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        nextDate:(NSDate **)date
{
    NSDate *nextDate = [controller date:self.date
                           byAddingDays:1];

    if ([controller isDifferentMonthsDate:nextDate andDate:self.date])
    {
        *date = self.date;
        return [KVEmptyTileProvider class];
    }
    
    *date = nextDate;
    return [KVDateTileProvider class];
}

- (Class)getPreviousTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        previousDate:(NSDate **)date
{
    NSDate *previousDate = [controller date:self.date
                               byAddingDays:-1];
    BOOL isDifferentMonth = [controller isDifferentMonthsDate:previousDate
                                                      andDate:self.date];
    
    if (isDifferentMonth && self.column == 0)
    {
        *date = self.date;
        return [KVMonthTileProvider class];
    }
    
    if (isDifferentMonth && self.column != 0)
    {
        *date = self.date;
        return [KVEmptyTileProvider class];
    }
    
    *date = previousDate;
    return [KVDateTileProvider class];
}

@end
