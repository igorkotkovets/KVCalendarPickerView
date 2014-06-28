//
//  KVCalendarScrollView+Protected.h
//  KVCalendarPickerVIew
//
//  Created by Igor Kotkovets on 6/24/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVCalendarScrollView.h"

@interface KVCalendarScrollView (Protected)
- (void)setLoadedViews:(NSMutableArray *)array;
- (NSMutableArray *)loadedViews;
@end
