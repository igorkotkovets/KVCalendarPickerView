//
//  KVViewController.m
//  KVCalendarPickerView
//
//  Created by Igor Kotkovets on 6/28/14.
//  Copyright (c) 2014 Kotkovets. All rights reserved.
//

#import "KVViewController.h"

#import "KVCalendarPickerView.h"

@interface KVViewController ()
<KVCalendarPickerViewDelegate>

@end

@implementation KVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)monthCalendarPicker:(KVCalendarPickerView *)picker willDisplayTile:(KVCalendarTile *)tile
{
    
}

-(void)monthCalendarPicker:(KVCalendarPickerView *)picker didSelectDate:(NSDate *)date
{
    
}

- (IBAction)setBeginingOfAWeekMonday:(id)sender
{
    [self.calendarPickerView setFirstWeekday:MonthCalendarWeekBeginsDayFromMonday];
}

- (IBAction)setBeginingOfAWeekSunday:(id)sender
{
    [self.calendarPickerView setFirstWeekday:MonthCalendarWeekBeginsDayFromSunday];
}

- (IBAction)today:(id)sender
{
    [self.calendarPickerView showDate:[NSDate date]];
}

- (IBAction)date:(id)sender
{

}

@end
