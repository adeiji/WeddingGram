//
//  BodyViewController.m
//  90DayFitness
//
//  Created by Bruce Green on 6/26/09.
//  Copyright 2009 Stylographix. All rights reserved.
//

#import "BodyViewController.h"
#import "_0DayFitnessAppDelegate.h"

@implementation BodyViewController

@synthesize day;

-(void)viewDidLoad {
    [super viewDidLoad];
	NSString *where = [NSString stringWithFormat:@"WHERE day=%d", day];
	dayInfo = (CalendarDay *)[CalendarDay findFirstByCriteria:where];
}

-(void)updateCompletedButton:(BOOL)completed {
    if (completed) {
        [completedButton setImage:[UIImage imageNamed:@"On Black 2.png"] forState:UIControlStateNormal];
    } else {
        [completedButton setImage:[UIImage imageNamed:@"Off Black 2.png"] forState:UIControlStateNormal];
    }
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}

-(void)viewDidUnload {
}


-(void)dealloc {
    [super dealloc];
}

-(IBAction)BodyButtonClicked:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (btn == gluetals) {
        CardioViewController *cardio = [[CardioViewController alloc] initWithNibName:@"CardioView" bundle:nil];
        cardio.day = self.day;
        [self presentModalViewController:cardio animated:YES];
        [cardio release];
    } else {
        ExerciseViewController *ex = [[ExerciseViewController alloc] initWithNibName:@"ExerciseView" bundle:nil];
        ex.buttonClicked = btn.tag;
        ex.dayInfo = dayInfo;
        [self presentModalViewController:ex animated:YES];
        [ex release];
    }
}

-(IBAction)closeView {
	// Save day on unload
	[dayInfo save];
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

-(IBAction)updateCompletedButtonClicked {
    dayInfo.completed = !dayInfo.completed;
    [self updateCompletedButton:dayInfo.completed];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Set button states
    if ([dayInfo.chest count] > 0) {
        chest.selected = YES;
	} else {
		chest.selected = NO;
	}
    if ([dayInfo.biceps count] > 0) {
        biceps.selected = YES;
    } else {
		biceps.selected = NO;
	}
    if ([dayInfo.shoulders count] > 0) {
        shoulders.selected = YES;
    } else {
		shoulders.selected = NO;
	}
    if ([dayInfo.triceps count] > 0) {
        triceps.selected = YES;
    } else {
		triceps.selected = NO;
	}
    if ([dayInfo.back count] > 0) {
        back.selected = YES;
    } else {
		back.selected = NO;
	}
    if ([dayInfo.forearms count] > 0) {
        forearms.selected = YES;
    } else {
		forearms.selected = NO;
	}
    if ([dayInfo.abs count] > 0) {
        abs.selected = YES;
    } else {
		abs.selected = NO;
	}
    if ([dayInfo.quadriceps count] > 0) {
        quadriceps.selected = YES;
    } else {
		quadriceps.selected = NO;
	}
    if ([dayInfo.hamstrings count] > 0) {
        hamstrings.selected = YES;
    } else {
		hamstrings.selected = NO;
	}
    if ([dayInfo.calves count] > 0) {
        calves.selected = YES;
    } else {
		calves.selected = NO;
	}
    if ([dayInfo.cardio count] > 0) {
        gluetals.selected = YES;
    } else {
		gluetals.selected = NO;
	}
    if ([dayInfo.other count] > 0) {
        other.selected = YES;
    } else {
		other.selected = NO;
	}
	[self updateCompletedButton:dayInfo.completed];
}

@end
