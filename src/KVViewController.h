//
//  KVViewController.h
//  KVCalendarPickerView
//
//  Created by Igor Kotkovets on 6/28/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KVCalendarPickerView;
@interface KVViewController : UIViewController
@property (nonatomic, weak) IBOutlet KVCalendarPickerView *calendarPickerView;

- (IBAction)setBeginingOfAWeekMonday:(id)sender;
- (IBAction)setBeginingOfAWeekSunday:(id)sender;

- (IBAction)today:(id)sender;
- (IBAction)date:(id)sender;
@end
