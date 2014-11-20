//
//  PPSetAlarmViewController.m
//  Zen Awake
//
//  Created by App Dev Wizard on 11/13/14.
//  Copyright (c) 2014 Pavel Palancica. All rights reserved.
//

#import "PPSetAlarmViewController.h"

#import "PPAlarmDaysViewController.h"
#import "PPAlarmSoundsViewController.h"

#import "PPCustomDatePicker.h"

#import "PPReviewManager.h"
#import "PPAlarmsManager.h"


#define BORDER_WIDTH 5.0f


@interface PPSetAlarmViewController () <PPAlarmDaysViewControllerDelegate, PPAlarmSoundsViewControllerDelegate>

@property (nonatomic, strong) UIButton *okayButton;//13.2%
@property (nonatomic, strong) PPCustomDatePicker *timePicker;
@property (nonatomic, strong) UIButton *daysButton;//13.2%
@property (nonatomic, strong) UIButton *soundButton;//13.2%
@property (nonatomic, strong) UIButton *snoozeButton;//13.2%
@property (nonatomic, strong) UIButton *cancelButton;//8.8%

@property (nonatomic, strong) PPAlarmDaysViewController *alarmDaysVC;
@property (nonatomic, strong) PPAlarmSoundsViewController *alarmSoundsVC;

@property (nonatomic, strong) NSMutableArray *arraySelectedDays;
@property (nonatomic, strong) NSArray *arrayShortDaysNames;

@property (nonatomic, assign) NSUInteger numberOfDaysSelected;
@property (nonatomic, assign, getter=isSnoozeOn) BOOL snoozeOn;

@property (nonatomic, strong) NSString *selectedSoundName;

@end


@implementation PPSetAlarmViewController

@synthesize arraySelectedDays = _arraySelectedDays;

#pragma mark - Lazy Initialization

- (PPAlarmDaysViewController *)alarmDaysVC
{
    if (!_alarmDaysVC) {
        _alarmDaysVC = [[PPAlarmDaysViewController alloc] init];
    }
    
    return _alarmDaysVC;
}

- (PPAlarmSoundsViewController *)alarmSoundsVC
{
    if (!_alarmSoundsVC) {
        _alarmSoundsVC = [[PPAlarmSoundsViewController alloc] init];
    }
    
    return _alarmSoundsVC;
}

- (NSString *)selectedSoundName
{
    if (!_selectedSoundName) {
        _selectedSoundName = @"ZEN";
    }
    
    return _selectedSoundName;
}

- (NSMutableArray *)arraySelectedDays
{
    if (!_arraySelectedDays) {
        _arraySelectedDays = [NSMutableArray array];
    }
    
    return _arraySelectedDays;
}

- (NSArray *)arrayShortDaysNames
{
    if (!_arrayShortDaysNames)
    {
        _arrayShortDaysNames = @[ @"MON", @"TUE", @"WED", @"THU", @"FRI", @"SAT", @"SUN" ];
    }
    
    return _arrayShortDaysNames;
}

- (void)setArraySelectedDays:(NSMutableArray *)arraySelectedDaysNames
{
    _arraySelectedDays = arraySelectedDaysNames;
    
    NSString *alarmDays = @"";
    
    self.numberOfDaysSelected = 0;
    
    for (NSInteger i = 0; i < [arraySelectedDaysNames count]; ++i)
    {
        if ([arraySelectedDaysNames[i] boolValue] == YES)
        {
            alarmDays = [alarmDays stringByAppendingString:[NSString stringWithFormat:@"%@ ", self.arrayShortDaysNames[i]]];
            
            self.numberOfDaysSelected++;
        }
    }
    
    if (self.numberOfDaysSelected == 0)
    {
        alarmDays = @"TODAY";
    }
    else if (self.numberOfDaysSelected == 7)
    {
        alarmDays = @"EVERYDAY";
    }
    else
    {
        alarmDays = [alarmDays substringToIndex:[alarmDays length] - 1];
    }
    
    [self.daysButton setTitle:alarmDays forState:UIControlStateNormal];
}

#pragma mark - View Life Cycle

- (void)loadView
{
    [super loadView];
    
    CGRect bounds = self.view.bounds;
    CGFloat originY = BORDER_WIDTH;
   
    UIColor *greenColor = [UIColor colorWithRed:61 / 255.0f
                                          green:144 / 255.0f
                                           blue:119 / 255.0f
                                          alpha:1.0f];
    UIColor *blackColor = [UIColor colorWithRed:56 / 255.0f
                                          green:56 / 255.0f
                                           blue:56 / 255.0f
                                          alpha:1.0f];
    
    // Okay Button
    
    CGRect okayButtonFrame = CGRectMake(BORDER_WIDTH,
                                        BORDER_WIDTH,
                                        bounds.size.width - BORDER_WIDTH * 2,
                                        bounds.size.height * 0.132f);
    
    self.okayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.okayButton.frame = okayButtonFrame;
    self.okayButton.backgroundColor = greenColor;
    
    [self.okayButton setTitleColor:blackColor forState:UIControlStateNormal];
    [self.okayButton setTitle:NSLocalizedString(@"OKAY", @"OKAY") forState:UIControlStateNormal];
    [self.okayButton addTarget:self action:@selector(onOkayButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    originY += (BORDER_WIDTH + okayButtonFrame.size.height);
    
    // Date Picker
    
    CGRect datePickerFrame = CGRectMake(BORDER_WIDTH,
                                        originY,
                                        bounds.size.width - BORDER_WIDTH * 2,
                                        bounds.size.height * 0.2905f);
    
    self.timePicker = [[PPCustomDatePicker alloc] initWithFrame:datePickerFrame];
    
    self.timePicker.backgroundColor = [UIColor clearColor];
    
    originY += (BORDER_WIDTH + datePickerFrame.size.height);
    
    // Days Button
    
    CGRect daysButtonFrame = CGRectMake(BORDER_WIDTH,
                                        originY,
                                        bounds.size.width - BORDER_WIDTH * 2,
                                        bounds.size.height * 0.132f);
    
    self.daysButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.daysButton.frame = daysButtonFrame;
    self.daysButton.backgroundColor = greenColor;
    
    [self.daysButton setTitle:NSLocalizedString(@"EVERYDAY", @"EVERYDAY") forState:UIControlStateNormal];
    [self.daysButton addTarget:self action:@selector(onDaysButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    originY += (BORDER_WIDTH + daysButtonFrame.size.height);

    // Sound Button
    
    CGRect soundButtonFrame = CGRectMake(BORDER_WIDTH,
                                         originY,
                                         bounds.size.width - BORDER_WIDTH * 2,
                                        bounds.size.height * 0.132f);
    
    self.soundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.soundButton.frame = soundButtonFrame;
    self.soundButton.backgroundColor = greenColor;
    
    [self.soundButton setTitle:NSLocalizedString(@"SOUND - ZEN", @"SOUND - ZEN") forState:UIControlStateNormal];
    [self.soundButton addTarget:self action:@selector(onSoundButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    originY += (BORDER_WIDTH + soundButtonFrame.size.height);
    
    // Snooze Button
    
    CGRect snoozeButtonFrame = CGRectMake(BORDER_WIDTH,
                                          originY,
                                          bounds.size.width - BORDER_WIDTH * 2,
                                          bounds.size.height * 0.132f);
    
    self.snoozeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.snoozeButton.frame = snoozeButtonFrame;
    self.snoozeButton.backgroundColor = greenColor;
    
    [self.snoozeButton setTitle:NSLocalizedString(@"SNOOZE - OFF", @"SNOOZE - OFF") forState:UIControlStateNormal];
    [self.snoozeButton addTarget:self action:@selector(onSnoozeButtonTap:) forControlEvents:UIControlEventTouchUpInside];

    originY += (BORDER_WIDTH + snoozeButtonFrame.size.height);
    
    // Cancel Button
    
    CGRect cancelButtonFrame = CGRectMake(BORDER_WIDTH,
                                          originY,
                                          bounds.size.width - BORDER_WIDTH * 2,
                                          bounds.size.height * 0.088f);
    
    cancelButtonFrame.origin.y = bounds.size.height - BORDER_WIDTH - cancelButtonFrame.size.height;
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = cancelButtonFrame;
    self.cancelButton.backgroundColor = blackColor;
//    self.cancelButton.titleLabel.textColor = [];
    [self.cancelButton setTitle:NSLocalizedString(@"CANCEL", @"CANCEL") forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(onCancelButtonTap:) forControlEvents:UIControlEventTouchUpInside];

    // http://stackoverflow.com/questions/11926729/change-uibutton-border-color-on-highlight
    
    [self.okayButton addTarget:self action:@selector(highlightButton:) forControlEvents:UIControlEventTouchDown];
    [self.okayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.okayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.daysButton addTarget:self action:@selector(highlightButton:) forControlEvents:UIControlEventTouchDown];
    [self.daysButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.daysButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.soundButton addTarget:self action:@selector(highlightButton:) forControlEvents:UIControlEventTouchDown];
    [self.soundButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.soundButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchDragOutside];

    [self.snoozeButton addTarget:self action:@selector(highlightButton:) forControlEvents:UIControlEventTouchDown];
    [self.snoozeButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.snoozeButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchDragOutside];

    [self.cancelButton addTarget:self action:@selector(highlightButton:) forControlEvents:UIControlEventTouchDown];
    [self.cancelButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    // Add Subviews
    
    [self.view addSubview:self.okayButton];
    [self.view addSubview:self.timePicker];
    [self.view addSubview:self.daysButton];
    [self.view addSubview:self.soundButton];
    [self.view addSubview:self.snoozeButton];
    [self.view addSubview:self.cancelButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.snoozeOn = NO;
    
//    self.timePicker.hour = 6;
//    self.timePicker.minute = 30;
//    self.datePicker.dateTime = DayTimePM;
    
//    NSLog(@"self.datePicker = %d", self.datePicker.dateTime);
}

#pragma mark - IBActions

- (void)onOkayButtonTap:(UIButton *)sender
{
    NSLog(@"TIME CHOSEN");
    NSLog(@"self.datePicker.hour = %ld", (long)self.timePicker.hour);
    NSLog(@"self.datePicker.minute = %ld", (long)self.timePicker.minute);
    NSLog(@"self.datePicker.dateTime = %ld", (long)self.timePicker.dateTime);
    
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)onDaysButtonTap:(UIButton *)sender
{
    self.alarmDaysVC.delegate = self;
    
    [self.navigationController pushViewController:self.alarmDaysVC animated:YES];
}

- (void)onSoundButtonTap:(UIButton *)sender
{
    self.alarmSoundsVC.delegate = self;
    
    [self.navigationController pushViewController:self.alarmSoundsVC animated:YES];
}

- (void)onSnoozeButtonTap:(UIButton *)sender
{
    self.snoozeOn = !self.isSnoozeOn;
    
    if (self.isSnoozeOn) {
        [self.snoozeButton setTitle:NSLocalizedString(@"SNOOZE - ON", @"SNOOZE - ON") forState:UIControlStateNormal];
    } else {
        [self.snoozeButton setTitle:NSLocalizedString(@"SNOOZE - OFF", @"SNOOZE - OFF") forState:UIControlStateNormal];
    }
}

- (void)onCancelButtonTap:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)highlightButton:(UIButton *)sender
{
    sender.alpha = 0.9f;
}

- (void)unhighlightButton:(UIButton *)sender
{
    sender.alpha = 1.0f;
}

#pragma mark - PPAlarmDaysViewControllerDelegate

- (void)alarmDaysViewController:(PPAlarmDaysViewController *)alarmDaysVC
                  didSelectDays:(NSMutableArray *)arrayDays
{
    NSLog(@"arrayDays = %@", arrayDays);
    
    self.arraySelectedDays = arrayDays;
}


#pragma mark - PPAlarmSoundsViewControllerDelegate

- (void)alarmSoundsViewController:(PPAlarmSoundsViewController *)alarmSoundsVC
           didSelectSoundWithName:(NSString *)soundName
{
    self.selectedSoundName = soundName;
    
    NSLog(@"self.selectedSoundName = %@", self.selectedSoundName);
//    self.soundButton.titleLabel.text = [NSString stringWithFormat:@"SOUND - %@", self.selectedSoundName];
    [self.soundButton setTitle:[NSString stringWithFormat:@"SOUND - %@", self.selectedSoundName] forState:UIControlStateNormal];
}

@end
