//
//  KVCalendarTile.m
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/20/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVCalendarTile.h"

#import <QuartzCore/QuartzCore.h>
#import "KVCalendarDateController.h"

@interface KVCalendarTile ()

-(void)setupKVCalendarTile;
@end


@implementation KVCalendarTile

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupKVCalendarTile];
    }
    
    return self;
}

-(void)awakeFromNib
{
    [self setupKVCalendarTile];
}

- (Class)getNextTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        nextDate:(NSDate **)date
{
    @throw [NSException exceptionWithName:@"Method not found"
                                   reason:@"Method not implemented in base class"
                                 userInfo:nil];
}

- (Class)getPreviousTileViewProviderWithDateProvider:(KVCalendarDateController *)controller
                                        previousDate:(NSDate **)date
{
    @throw [NSException exceptionWithName:@"Method not found"
                                   reason:@"Method not implemented in base class"
                                 userInfo:nil];
}

#pragma mark - 
#pragma mark - Private

-(void)setupKVCalendarTile
{
}

@end
