//
//  KVCalendarTile.m
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/20/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVCalendarTile.h"

#import <QuartzCore/QuartzCore.h>

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

#pragma mark - 
#pragma mark - Private

-(void)setupKVCalendarTile
{
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 0.25f;
}

@end
