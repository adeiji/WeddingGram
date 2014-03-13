//
//  BodyViewController.h
//  90DayFitness
//
//  Created by Bruce Green on 6/26/09.
//  Copyright 2009 Stylographix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseViewController.h"
#import "CalendarDay.h"
#import "CardioViewController.h"

#define kChest 1
#define kBiceps 2
#define kShoulders 3
#define kTriceps 4
#define kBack 5
#define kForearms 6
#define kAbs 7
#define kQuadriceps 8
#define kHamstrings 9
#define kCalves 10
#define kGluetals 11
#define kOther 12

@interface BodyViewController : UIViewController {
    int day; 
	CalendarDay *dayInfo;
	IBOutlet UIButton *completedButton;
	IBOutlet UIButton *chest;
    IBOutlet UIButton *biceps;
    IBOutlet UIButton *shoulders;
    IBOutlet UIButton *triceps;
    IBOutlet UIButton *back;
    IBOutlet UIButton *forearms;
    IBOutlet UIButton *abs;
    IBOutlet UIButton *quadriceps;
    IBOutlet UIButton *hamstrings;
    IBOutlet UIButton *calves;
    IBOutlet UIButton *gluetals;
    IBOutlet UIButton *other;
}

@property (nonatomic) int day;

-(IBAction)BodyButtonClicked:(id)sender;
-(IBAction)closeView;
-(IBAction)updateCompletedButtonClicked;
-(void)updateCompletedButton:(BOOL)completed;

@end
