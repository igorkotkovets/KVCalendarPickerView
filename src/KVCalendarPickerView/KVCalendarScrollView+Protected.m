//
//  KVCalendarScrollView+Protected.m
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/24/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVCalendarScrollView+Protected.h"

@implementation KVCalendarScrollView (Protected)
- (void)setLoadedViews:(NSMutableArray *)array
{
    _loadedViews = array;
}

- (NSMutableArray *)loadedViews
{
    return _loadedViews;
}
@end
