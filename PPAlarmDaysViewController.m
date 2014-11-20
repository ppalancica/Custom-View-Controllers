//
//  PPAlarmDaysViewController.m
//  Zen Awake
//
//  Created by App Dev Wizard on 8/31/14.
//  Copyright (c) 2014 Pavel Palancica. All rights reserved.
//

#import "PPAlarmDaysViewController.h"


#define BORDER_WIDTH 5.0f


@interface PPAlarmDaysViewController ()

@property (nonatomic, strong) NSMutableArray *arraySelectedDays;

@property (nonatomic, strong) UITableView *tableViewAlarmDays;

@property (nonatomic, strong) UIButton *mondayButton;//13.2%
@property (nonatomic, strong) UIButton *tuesdayButton;//13.2%
@property (nonatomic, strong) UIButton *wednesdayButton;//13.2%
@property (nonatomic, strong) UIButton *thursdayButton;//13.2%
@property (nonatomic, strong) UIButton *fridayButton;//13.2%
@property (nonatomic, strong) UIButton *saturdayButton;//13.2%
@property (nonatomic, strong) UIButton *sundayButton;//13.2%
@property (nonatomic, strong) UIButton *doneButton;//8.8%

@property (nonatomic, strong) UIColor *dayButtonBlackColor;
@property (nonatomic, strong) UIColor *dayButtonGreenColor;

@end


@implementation PPAlarmDaysViewController

- (UIColor *)dayButtonBlackColor
{
    if (!_dayButtonBlackColor) {
        _dayButtonBlackColor = [UIColor colorWithRed:34 / 255.0f
                                               green:34 / 255.0f
                                                blue:34 / 255.0f
                                               alpha:0.9f];
    }
    
    return _dayButtonBlackColor;
}

- (UIColor *)dayButtonGreenColor
{
    if (!_dayButtonGreenColor) {
        _dayButtonGreenColor = [UIColor colorWithRed:61 / 255.0f
                                               green:144 / 255.0f
                                                blue:119 / 255.0f
                                               alpha:0.9f];
    }
    
    return _dayButtonGreenColor;
}

//- (NSArray *)arrayDaysNames
//{
//    if (!_arrayDaysNames)
//    {
//        _arrayDaysNames = @[ @"MONDAY", @"TUESDAY", @"WEDNESDAY", @"THURSDAY", @"FRIDAY", @"SATURDAY", @"SUNDAY" ];
//
////        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
////
////        NSMutableArray *daysNames = [NSMutableArray arrayWithArray:dateFormatter.weekdaySymbols];
////
////        // Sunday comes first, but it would be localized
////        for (int i = 0; i < [daysNames count]; i++)
////        {
////            daysNames[i] = [daysNames[i] uppercaseString];
////        }
////
////        _arrayDaysNames = daysNames;
////
////        NSLog(@"daysNames = %@", daysNames);
//    }
//
//    return _arrayDaysNames;
//}

- (NSMutableArray *)arraySelectedDays
{
    if (!_arraySelectedDays)
    {
        _arraySelectedDays = [NSMutableArray arrayWithCapacity:7];
        
        for (NSInteger i = 0; i < 7; ++i)
        {
            _arraySelectedDays[i] = [NSNumber numberWithBool:YES];
        }
    }
    
    return _arraySelectedDays;
}

#pragma mark - View Life Cycle

- (void)loadView
{
    [super loadView];
    
    CGRect bounds = self.view.bounds;
    CGFloat totalHorizontalInnerSpace = 2 * BORDER_WIDTH;
    CGFloat originY = BORDER_WIDTH;
    UIColor *blackColor = [UIColor colorWithRed:56 / 255.0f
                                          green:56 / 255.0f
                                           blue:56 / 255.0f
                                          alpha:1.0f];
    
    // Monday Button
    
    CGRect mondayButtonFrame = CGRectMake(BORDER_WIDTH,
                                          BORDER_WIDTH,
                                          bounds.size.width - totalHorizontalInnerSpace,
                                          bounds.size.height * 0.132f);
    
    self.mondayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mondayButton.frame = mondayButtonFrame;
    self.mondayButton.backgroundColor = self.dayButtonGreenColor;
    
    [self.mondayButton setTitle:NSLocalizedString(@"MONDAY", @"MONDAY") forState:UIControlStateNormal];
    [self.mondayButton addTarget:self action:@selector(onDayButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    originY += (BORDER_WIDTH + mondayButtonFrame.size.height);
    
    // Tuesday Button
    
    CGRect tuesdayButtonFrame = CGRectMake(BORDER_WIDTH,
                                           originY,
                                           bounds.size.width - totalHorizontalInnerSpace,
                                           bounds.size.height * 0.132f);
    
    self.tuesdayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tuesdayButton.frame = tuesdayButtonFrame;
    self.tuesdayButton.backgroundColor = self.dayButtonGreenColor;
    
    [self.tuesdayButton setTitle:NSLocalizedString(@"TUESDAY", @"TUESDAY") forState:UIControlStateNormal];
    [self.tuesdayButton addTarget:self action:@selector(onDayButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    originY += (BORDER_WIDTH + tuesdayButtonFrame.size.height);
    
    // Wednesday Button
    
    CGRect wednesdayButtonFrame = CGRectMake(BORDER_WIDTH,
                                             originY,
                                             bounds.size.width - totalHorizontalInnerSpace,
                                             bounds.size.height * 0.132f);
    
    self.wednesdayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.wednesdayButton.frame = wednesdayButtonFrame;
    self.wednesdayButton.backgroundColor = self.dayButtonGreenColor;
    
    [self.wednesdayButton setTitle:NSLocalizedString(@"WEDNESDAY", @"WEDNESDAY") forState:UIControlStateNormal];
    [self.wednesdayButton addTarget:self action:@selector(onDayButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    originY += (BORDER_WIDTH + wednesdayButtonFrame.size.height);
    
    // Thursday Button
    
    CGRect thursdayButtonFrame = CGRectMake(BORDER_WIDTH,
                                            originY,
                                            bounds.size.width - totalHorizontalInnerSpace,
                                            bounds.size.height * 0.132f);
    
    self.thursdayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.thursdayButton.frame = thursdayButtonFrame;
    self.thursdayButton.backgroundColor = self.dayButtonGreenColor;
    
    [self.thursdayButton setTitle:NSLocalizedString(@"THURSDAY", @"THURSDAY") forState:UIControlStateNormal];
    [self.thursdayButton addTarget:self action:@selector(onDayButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    originY += (BORDER_WIDTH + thursdayButtonFrame.size.height);
    
    // Friday Button
    
    CGRect fridayButtonFrame = CGRectMake(BORDER_WIDTH,
                                          originY,
                                          bounds.size.width - totalHorizontalInnerSpace,
                                          bounds.size.height * 0.132f);
    
    self.fridayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fridayButton.frame = fridayButtonFrame;
    self.fridayButton.backgroundColor = self.dayButtonGreenColor;
    
    [self.fridayButton setTitle:NSLocalizedString(@"FRIDAY", @"FRIDAY") forState:UIControlStateNormal];
    [self.fridayButton addTarget:self action:@selector(onDayButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    originY += (BORDER_WIDTH + fridayButtonFrame.size.height);
    
    // Saturday Button
    
    CGRect saturdayButtonFrame = CGRectMake(BORDER_WIDTH,
                                            originY,
                                            (bounds.size.width - BORDER_WIDTH * 3) / 2,
                                            bounds.size.height * 0.132f);
    
    self.saturdayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saturdayButton.frame = saturdayButtonFrame;
    self.saturdayButton.backgroundColor = self.dayButtonGreenColor;
    
    [self.saturdayButton setTitle:NSLocalizedString(@"SATURDAY", @"SATURDAY") forState:UIControlStateNormal];
    [self.saturdayButton addTarget:self action:@selector(onDayButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    //    originY += (BORDER_WIDTH + saturdayButtonFrame.size.height);
    
    // Sunday Button
    
    CGRect sundayButtonFrame = CGRectMake((bounds.size.width + BORDER_WIDTH) / 2,
                                          originY,
                                          (bounds.size.width - BORDER_WIDTH * 3) / 2,
                                          bounds.size.height * 0.132f);
    
    self.sundayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sundayButton.frame = sundayButtonFrame;
    self.sundayButton.backgroundColor = self.dayButtonGreenColor;
    
    [self.sundayButton setTitle:NSLocalizedString(@"SUNDAY", @"SUNDAY") forState:UIControlStateNormal];
    [self.sundayButton addTarget:self action:@selector(onDayButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    originY += (BORDER_WIDTH + sundayButtonFrame.size.height);
    
    // Cancel Button
    
    CGRect doneButtonFrame = CGRectMake(BORDER_WIDTH,
                                        originY,
                                        bounds.size.width - totalHorizontalInnerSpace,
                                        bounds.size.height * 0.088f);
    
    doneButtonFrame.origin.y = bounds.size.height - BORDER_WIDTH - doneButtonFrame.size.height;
    
    self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.doneButton.frame = doneButtonFrame;
    self.doneButton.backgroundColor = blackColor;
    //    self.cancelButton.titleLabel.textColor = [];
    [self.doneButton setTitle:NSLocalizedString(@"DONE", @"DONE") forState:UIControlStateNormal];
    [self.doneButton addTarget:self action:@selector(onDoneButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    // http://stackoverflow.com/questions/11926729/change-uibutton-border-color-on-highlight
    
    [self.mondayButton addTarget:self action:@selector(highlightButton:) forControlEvents:UIControlEventTouchDown];
    [self.mondayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.mondayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.tuesdayButton addTarget:self action:@selector(highlightButton:) forControlEvents:UIControlEventTouchDown];
    [self.tuesdayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.tuesdayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.wednesdayButton addTarget:self action:@selector(highlightButton:) forControlEvents:UIControlEventTouchDown];
    [self.wednesdayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.wednesdayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.thursdayButton addTarget:self action:@selector(highlightButton:) forControlEvents:UIControlEventTouchDown];
    [self.thursdayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.thursdayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.fridayButton addTarget:self action:@selector(highlightButton:) forControlEvents:UIControlEventTouchDown];
    [self.fridayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.fridayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.saturdayButton addTarget:self action:@selector(highlightButton:) forControlEvents:UIControlEventTouchDown];
    [self.saturdayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.saturdayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.sundayButton addTarget:self action:@selector(highlightButton:) forControlEvents:UIControlEventTouchDown];
    [self.sundayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.sundayButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.doneButton addTarget:self action:@selector(highlightButton:) forControlEvents:UIControlEventTouchDown];
    [self.doneButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.doneButton addTarget:self action:@selector(unhighlightButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    // Add Subviews
    
    [self.view addSubview:self.mondayButton];
    [self.view addSubview:self.tuesdayButton];
    [self.view addSubview:self.wednesdayButton];
    [self.view addSubview:self.thursdayButton];
    [self.view addSubview:self.fridayButton];
    [self.view addSubview:self.saturdayButton];
    [self.view addSubview:self.sundayButton];
    [self.view addSubview:self.doneButton];
}

- (void)addHorizontalLineToEachButtonTitle
{
    [self.mondayButton.titleLabel sizeToFit];
    [self.tuesdayButton.titleLabel sizeToFit];
    [self.wednesdayButton.titleLabel sizeToFit];
    [self.thursdayButton.titleLabel sizeToFit];
    [self.fridayButton.titleLabel sizeToFit];
    [self.saturdayButton.titleLabel sizeToFit];
    [self.sundayButton.titleLabel sizeToFit];
    
    UIView *horizontalLineView = nil;
    CGRect lineFrame;
    CGFloat originX;
    CGFloat originY;
    CGFloat lineWidth;
    CGFloat lineHeight;
    UIColor *lineColor = [UIColor whiteColor];
    
    // Horizontal Line for Monday
    
    originX = self.mondayButton.frame.size.width - self.mondayButton.titleLabel.frame.size.width;
    originY = self.mondayButton.frame.size.height / 2;
    lineWidth = self.mondayButton.titleLabel.frame.size.width;
    lineHeight = 1.0f;
    
    lineFrame = CGRectMake(originX / 2, originY, lineWidth, lineHeight);
    
    horizontalLineView = [[UIView alloc] initWithFrame:lineFrame];
    horizontalLineView.backgroundColor = lineColor;
    horizontalLineView.tag = self.mondayButton.tag + 100;
    horizontalLineView.hidden = YES;
    
    [self.mondayButton addSubview:horizontalLineView];
    
    // Horizontal Line for Tuesday
    
    originX = self.tuesdayButton.frame.size.width - self.tuesdayButton.titleLabel.frame.size.width;
    originY = self.tuesdayButton.frame.size.height / 2;
    lineWidth = self.tuesdayButton.titleLabel.frame.size.width;
    lineHeight = 1.0f;
    
    lineFrame = CGRectMake(originX / 2, originY, lineWidth, lineHeight);
    
    horizontalLineView = [[UIView alloc] initWithFrame:lineFrame];
    horizontalLineView.backgroundColor = lineColor;
    horizontalLineView.tag = self.tuesdayButton.tag + 100;
    horizontalLineView.hidden = YES;
    
    [self.tuesdayButton addSubview:horizontalLineView];
    
    // Horizontal Line for Wednesday
    
    originX = self.wednesdayButton.frame.size.width - self.wednesdayButton.titleLabel.frame.size.width;
    originY = self.wednesdayButton.frame.size.height / 2;
    lineWidth = self.wednesdayButton.titleLabel.frame.size.width;
    lineHeight = 1.0f;
    
    lineFrame = CGRectMake(originX / 2, originY, lineWidth, lineHeight);
    
    horizontalLineView = [[UIView alloc] initWithFrame:lineFrame];
    horizontalLineView.backgroundColor = lineColor;
    horizontalLineView.tag = self.wednesdayButton.tag + 100;
    horizontalLineView.hidden = YES;
    
    [self.wednesdayButton addSubview:horizontalLineView];
    
    // Horizontal Line for Thursday
    
    originX = self.thursdayButton.frame.size.width - self.thursdayButton.titleLabel.frame.size.width;
    originY = self.thursdayButton.frame.size.height / 2;
    lineWidth = self.thursdayButton.titleLabel.frame.size.width;
    lineHeight = 1.0f;
    
    lineFrame = CGRectMake(originX / 2, originY, lineWidth, lineHeight);
    
    horizontalLineView = [[UIView alloc] initWithFrame:lineFrame];
    horizontalLineView.backgroundColor = lineColor;
    horizontalLineView.tag = self.thursdayButton.tag + 100;
    horizontalLineView.hidden = YES;
    
    [self.thursdayButton addSubview:horizontalLineView];
    
    // Horizontal Line for Friday
    
    originX = self.fridayButton.frame.size.width - self.fridayButton.titleLabel.frame.size.width;
    originY = self.fridayButton.frame.size.height / 2;
    lineWidth = self.fridayButton.titleLabel.frame.size.width;
    lineHeight = 1.0f;
    
    lineFrame = CGRectMake(originX / 2, originY, lineWidth, lineHeight);
    
    horizontalLineView = [[UIView alloc] initWithFrame:lineFrame];
    horizontalLineView.backgroundColor = lineColor;
    horizontalLineView.tag = self.fridayButton.tag + 100;
    horizontalLineView.hidden = YES;
    
    [self.fridayButton addSubview:horizontalLineView];
    
    // Horizontal Line for Saturday
    
    originX = self.saturdayButton.frame.size.width - self.saturdayButton.titleLabel.frame.size.width;
    originY = self.saturdayButton.frame.size.height / 2;
    lineWidth = self.saturdayButton.titleLabel.frame.size.width;
    lineHeight = 1.0f;
    
    lineFrame = CGRectMake(originX / 2, originY, lineWidth, lineHeight);
    
    horizontalLineView = [[UIView alloc] initWithFrame:lineFrame];
    horizontalLineView.backgroundColor = lineColor;
    horizontalLineView.tag = self.saturdayButton.tag + 100;
    horizontalLineView.hidden = YES;
    
    [self.saturdayButton addSubview:horizontalLineView];
    
    // Horizontal Line for Sunday
    
    originX = self.sundayButton.frame.size.width - self.sundayButton.titleLabel.frame.size.width;
    originY = self.sundayButton.frame.size.height / 2;
    lineWidth = self.sundayButton.titleLabel.frame.size.width;
    lineHeight = 1.0f;
    
    lineFrame = CGRectMake(originX / 2, originY, lineWidth, lineHeight);
    
    horizontalLineView = [[UIView alloc] initWithFrame:lineFrame];
    horizontalLineView.backgroundColor = lineColor;
    horizontalLineView.tag = self.sundayButton.tag + 100;
    horizontalLineView.hidden = YES;
    
    [self.sundayButton addSubview:horizontalLineView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mondayButton.tag = 100;
    self.tuesdayButton.tag = 101;
    self.wednesdayButton.tag = 102;
    self.thursdayButton.tag = 103;
    self.fridayButton.tag = 104;
    self.saturdayButton.tag = 105;
    self.sundayButton.tag = 106;
    
    [self addHorizontalLineToEachButtonTitle];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - IBActions

- (void)onDayButtonTap:(UIButton *)sender
{
    NSLog(@"sender.tag = %ld", (long)sender.tag);
    
    NSInteger buttonTag = sender.tag - 100;
    
    if ([self.arraySelectedDays[buttonTag] boolValue] == NO)
    {
        self.arraySelectedDays[buttonTag] = [NSNumber numberWithBool:YES];
        sender.backgroundColor = self.dayButtonGreenColor;
        
        [sender viewWithTag:sender.tag + 100].hidden = YES;
    }
    else
    {
        self.arraySelectedDays[buttonTag] = [NSNumber numberWithBool:NO];
        sender.backgroundColor = self.dayButtonBlackColor;
        
        [sender viewWithTag:sender.tag + 100].hidden = NO;
    }
}

- (void)onDoneButtonTap:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(alarmDaysViewController:didSelectDays:)])
    {
        [self.delegate alarmDaysViewController:self didSelectDays:self.arraySelectedDays];
    }
    
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

@end
