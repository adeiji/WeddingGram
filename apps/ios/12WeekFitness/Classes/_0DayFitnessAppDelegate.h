//
//  _0DayFitnessAppDelegate.h
//  90DayFitness
//
//  Created by Bruce Green on 6/19/09.
//  Copyright Stylographix 2009. All rights reserved.
//
#import "DayInfo.h"
#import "CalendarDay.h"
#import "MainMenuViewController.h"


@class MainViewController;

@interface _0DayFitnessAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
	CalendarDay *dayCopy;
    MainMenuViewController *mainMenuViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController *mainViewController;
@property (nonatomic, retain) CalendarDay *dayCopy;
@property (nonatomic, retain) MainMenuViewController *mainMenuViewController;

-(void)resetData;

@end

