//
//  MainViewController.h
//  90DayFitness
//
//  Created by Bruce Green on 6/19/09.
//  Copyright Stylographix 2009. All rights reserved.
//
#import "_0DayFitnessAppDelegate.h"
#import "FlipsideViewController.h"
#import "SelectionViewController.h"
#import "DayView.h"
#import "CalendarDay.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, SelectionViewControllerDelegate> {
	_0DayFitnessAppDelegate *app;
	NSMutableArray *buttonArray;
}

-(IBAction)showInfo;
-(IBAction)dayClicked:(id)sender;

-(void)setupDayView:(int)index with:(CalendarDay *)info;
-(void)displayCalendar;
-(void)copyData:(NSMutableDictionary *)d1 to:(NSMutableDictionary *)d2;

@end
