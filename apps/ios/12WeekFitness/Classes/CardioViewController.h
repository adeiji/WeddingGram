//
//  CardioViewController.h
//  90DayFitness
//
//  Created by Bruce Green on 6/27/09.
//  Copyright 2009 Stylographix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseViewController.h"
#import "CalendarDay.h"


@interface CardioViewController : UIViewController <UIAlertViewDelegate> {
	int day; 
	CalendarDay *dayInfo;
	IBOutlet UIButton *completedButton;
	IBOutlet UIPickerView *picker;
	IBOutlet UIButton *steadyButton;
	IBOutlet UIButton *intenseButton;
	IBOutlet UILabel *duration;
}

@property (nonatomic) int day;


-(IBAction)closeView;
-(IBAction)updateCompletedButtonClicked;
-(void)updateCompletedButton:(BOOL)completed;
-(IBAction)intensityChanged:(id)sender;
-(IBAction)setDuration;
-(IBAction)resetClicked;

@end
