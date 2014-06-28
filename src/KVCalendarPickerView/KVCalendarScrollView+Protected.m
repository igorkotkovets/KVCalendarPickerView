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
    @synchronized(self) {
        _loadedViews = array;
    }
}

- (NSMutableArray *)loadedViews
{
    @synchronized(self) {
        return _loadedViews;
    }
}
@end
