//
//  KVCalendarPickerView.m
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/22/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVCalendarPickerView.h"

#import "KVCalendarDateController.h"
#import "KVCalendarTile+Protected.h"
#import "KVCalendarScrollView.h"
#import "KVCalendarDateTile.h"
#import "KVCalendarMonthTile.h"
#import "KVCalendarEmptyTile.h"
#import "KVCalendarConstants.h"

@interface KVCalendarPickerView ()
<KVCalendarScrollViewDatasource, KVCalendarScrollViewDelegate,
KVCalendarMonthTileDelegate, KVCalendarDateTileDelegate>

@property(nonatomic, strong) KVCalendarDateController *dateProvider;
@property(nonatomic, strong) NSMutableArray *dayLabels;
@property(nonatomic, assign) CGSize tileSize;
@property (nonatomic, strong) KVCalendarScrollView *monthScrollView;

- (void)setupKVCalendarPickerView;
- (NSMutableArray *)addDayLabelsWithSize:(CGSize)size;
- (void)reloadDayLabelsWithFirstWeekday:(MonthCalendarWeekBeginsFromDay)weekday;
@end


@implementation KVCalendarPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupKVCalendarPickerView];
    }
    return self;
}

-(void)awakeFromNib
{
    [self setupKVCalendarPickerView];
}

static const float DayLabelsHeight = 30.f;

- (void)setupKVCalendarPickerView
{
    self.dateProvider = [[KVCalendarDateController alloc]
                         initWithBaseDate:[NSDate date]];
    
    self.firstWeekday = MonthCalendarWeekBeginsDayFromMonday;
    
    CGFloat calendarHeight = self.frame.size.height-DayLabelsHeight;
    self.monthScrollView = [[KVCalendarScrollView alloc] initWithFrame:CGRectZero
                                                         dateProvider:self.dateProvider];
    CGRect rc = CGRectMake(0, DayLabelsHeight,
                           self.frame.size.width, calendarHeight);
    [self.monthScrollView setFrame:rc];
    self.monthScrollView.calendarScrollDatasource = self;
    self.monthScrollView.calendarScrollDelegate = self;
    self.monthScrollView.clipsToBounds = YES;
    [self addSubview:self.monthScrollView];
    
    self.monthScrollView.layer.borderColor =
    [UIColor colorWithRed:211/255.f green:207/255.f blue:207/255.f alpha:1.f].CGColor;
    self.monthScrollView.layer.borderWidth = 0.5f;
    
    
    self.tileSize = [self monthScrollViewGetFixedTileSize:self.monthScrollView];
    
    self.dayLabels = [self addDayLabelsWithSize:
                      CGSizeMake(self.tileSize.width, DayLabelsHeight)];
    [self reloadDayLabelsWithFirstWeekday:self.firstWeekday];
}

- (NSMutableArray *)addDayLabelsWithSize:(CGSize)size
{
    CGFloat xPos = 0.f;
    NSMutableArray *dayLabels = [[NSMutableArray alloc] init];
    
    for (int i=0;i<days_in_week;++i)
    {
        xPos = size.width*i;
        CGRect rc = CGRectMake(xPos, 0, size.width, size.height);
        UILabel * dayLabel = [[UILabel alloc] initWithFrame:rc];
        dayLabel.backgroundColor = [UIColor clearColor];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.textColor = [UIColor colorWithRed:64/255.f green:64/255.f blue:64/255.f alpha:1.f];
        
        [self addSubview:dayLabel];
        [dayLabels addObject:dayLabel];
    }
    
    return dayLabels;
}

- (void)reloadDayLabelsWithFirstWeekday:(MonthCalendarWeekBeginsFromDay)weekday
{
    NSArray *days = @[NSLocalizedString(@"Sun", nil),
                      NSLocalizedString(@"Mon", nil),
                      NSLocalizedString(@"Tue", nil),
                      NSLocalizedString(@"Wed", nil),
                      NSLocalizedString(@"Thu", nil),
                      NSLocalizedString(@"Fri", nil),
                      NSLocalizedString(@"Sat", nil)];
    
    NSInteger const sunday = 0;
    NSInteger const saturday = 6;
    
    NSUInteger dayIndex = weekday-1;
    for (int i=0;i<days_in_week;++i)
    {
        if (dayIndex>=[days count])
            dayIndex = 0;
        
        UILabel *dayLabel = [_dayLabels objectAtIndex:i];
        dayLabel.font = [UIFont fontWithName:dayIndex==sunday||dayIndex==saturday?@"HelveticaNeue-Medium":@"HelveticaNeue-Light" size:13.f];
        dayLabel.text = [days objectAtIndex:dayIndex];
        
        ++dayIndex;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tileSize = [self monthScrollViewGetFixedTileSize:self.monthScrollView];
}

#pragma mark -
#pragma mark Public

- (void)setFirstWeekday:(MonthCalendarWeekBeginsFromDay)firstWeekday
{
    firstWeekday = MAX(MonthCalendarWeekBeginsDayFromSunday, firstWeekday);
    firstWeekday = MIN(MonthCalendarWeekBeginsDayFromMonday, firstWeekday);
    
    [self reloadDayLabelsWithFirstWeekday:firstWeekday];
    
    [self.monthScrollView stopScrolling];
    [self.dateProvider setFirstWeekDay:firstWeekday];
    [self.monthScrollView reloadData];
}

- (MonthCalendarWeekBeginsFromDay)firstWeekday
{
    return [self.dateProvider firstWeekDay];
}

- (void)showDate:(NSDate *)date
{
    [self.monthScrollView stopScrolling];
    [self.dateProvider setBaseDate:date];
    [self.monthScrollView reloadData];
}

- (void)presentDatesBeginsFromDate:(NSDate *)aDate
{
}

#pragma mark -
#pragma IKMonthScrollViewDatasource

- (KVCalendarDateTile *)monthScrollView:(KVCalendarScrollView *)view
             createCalendarTileWithDate:(NSDate *)date
                                 column:(NSInteger)column
{
    KVCalendarDateTile *tv = [[KVCalendarDateTile alloc]
                            initWithFrame:CGRectMake(0, 0,
                                                   self.tileSize.width, self.tileSize.height)];
    tv.delegate = self;
    
    [self configureCalendarTile:tv withDate:date column:column];
    
    return tv;
}

- (void)configureCalendarTile:(KVCalendarDateTile *)tile
                     withDate:(NSDate *)date
                       column:(NSInteger)column
{
    tile.date = date;
    tile.column = column;
    [tile setDateString:[self.dateProvider dayStringFromDate:date]];
}

- (KVCalendarEmptyTile *)monthScrollView:(KVCalendarScrollView *)view
         createCalendarEmptyTileWithDate:(NSDate *)date
                                  column:(NSInteger)column
{
    KVCalendarEmptyTile *tv = [[KVCalendarEmptyTile alloc]
                              initWithFrame:CGRectMake(0, 0,
                                                       self.tileSize.width,
                                                       self.tileSize.height)];
    
    [self configureCalendarEmptyTile:tv withDate:date column:column];
    
    return tv;
}

- (void)configureCalendarEmptyTile:(KVCalendarEmptyTile *)tile
                          withDate:(NSDate *)date
                            column:(NSInteger)column
{
    tile.date = date;
    tile.column = column;
}

- (KVCalendarMonthTile *)monthScrollView:(KVCalendarScrollView *)view
         createCalendarMonthTileWithDate:(NSDate *)date
                                  column:(NSInteger)column
{
    KVCalendarMonthTile *tv = [[KVCalendarMonthTile alloc]
                               initWithFrame:CGRectMake(0, 0,
                                                        view.frame.size.width,
                                                        self.tileSize.height)];
    
    [self configureCalendarMonthTile:tv withDate:date column:column];
    
    return tv;
}

- (void)configureCalendarMonthTile:(KVCalendarMonthTile *)tile
                          withDate:(NSDate *)date
                            column:(NSInteger)column
{
    tile.date = date;
    tile.column = column;
    [tile setMonthString:[self.dateProvider monthStringFromDate:date]];
}

static const CGFloat tileHeight = 46;
- (CGSize)monthScrollViewGetFixedTileSize:(KVCalendarScrollView *)view
{
    CGFloat tileWidth = view.frame.size.width/days_in_week;
    return CGSizeMake(tileWidth, tileHeight);
}

#pragma mark -
#pragma mark <IKMonthScrollViewDelegate>

- (void)calendarScrollViewDidFinishScrollAnimating:(KVCalendarScrollView *)view
{
    NSLog(@"calendarScrollViewDidFinishScrollAnimating");
}

#pragma mark -
#pragma mark - <KVCalendarTileDelegate>

-(void)didSelectCalendarTile:(KVCalendarTile *)view withDate:(NSDate *)date
{
    [self.delegate monthCalendarPicker:self didSelectDate:date];
}

@end
