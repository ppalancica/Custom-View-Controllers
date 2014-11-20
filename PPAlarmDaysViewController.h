//
//  PPAlarmDaysViewController.h
//  Zen Awake
//
//  Created by App Dev Wizard on 8/31/14.
//  Copyright (c) 2014 Pavel Palancica. All rights reserved.
//

#import <UIKit/UIKit.h>


@class PPAlarmDaysViewController;


@protocol PPAlarmDaysViewControllerDelegate <NSObject>

@required
- (void)alarmDaysViewController:(PPAlarmDaysViewController *)alarmDaysVC
                  didSelectDays:(NSMutableArray *)arrayDays;

@end


@interface PPAlarmDaysViewController : UIViewController

@property (nonatomic, assign) id<PPAlarmDaysViewControllerDelegate> delegate;

@end
