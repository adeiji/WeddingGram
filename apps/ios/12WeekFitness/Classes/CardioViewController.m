//
//  CardioViewController.m
//  90DayFitness
//
//  Created by Bruce Green on 6/27/09.
//  Copyright 2009 Stylographix. All rights reserved.
//

#import "CardioViewController.h"
#import "_0DayFitnessAppDelegate.h"


@implementation CardioViewController

@synthesize day;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

-(void)viewDidLoad {
    [super viewDidLoad];
	NSString *where = [NSString stringWithFormat:@"WHERE day=%d", day];
	dayInfo = (CalendarDay *)[CalendarDay findFirstByCriteria:where];
	[self updateCompletedButton:dayInfo.completed];
    // Do interface updates only if we have saved settings
    if (dayInfo.cardio != nil) {
        // Set duration label and picker
        NSString *buf = [dayInfo.cardio valueForKey:@"CardioIntensity"];
        if ([buf intValue] == 1) {
            [steadyButton setSelected:YES];
            [intenseButton setSelected:NO];
        } else {
            [steadyButton setSelected:NO];
            [intenseButton setSelected:YES];
        }
        // Set cardio intensity buttons
        buf = [dayInfo.cardio valueForKey:@"Hours"];
        int hour = [buf intValue];
        buf = [dayInfo.cardio valueForKey:@"Minutes"];
        int minute = [buf intValue];
        [picker selectRow:hour inComponent:0 animated:NO];
        [picker selectRow:minute inComponent:1 animated:NO];
        duration.text = [NSString stringWithFormat:@"%d hour %d min", hour, minute];
    } else {
        [picker selectRow:0 inComponent:0 animated:NO];
        [picker selectRow:20 inComponent:1 animated:NO];
    }
}	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;


-(void)updateCompletedButton:(BOOL)completed {
    if (completed) {
        [completedButton setImage:[UIImage imageNamed:@"On Black 2.png"] forState:UIControlStateNormal];
    } else {
        [completedButton setImage:[UIImage imageNamed:@"Off Black 2.png"] forState:UIControlStateNormal];
    }
}


-(void)dealloc {
    [super dealloc];
}

-(IBAction)closeView {
	// Save day on close
	[dayInfo save];
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	int rows = 0;
    if (component == 0) {
        rows = 13;
    } else if (component == 1) {
        rows = 60;
    }
	return rows;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger) row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%d", row];
}

-(IBAction)updateCompletedButtonClicked {
    dayInfo.completed = !dayInfo.completed;
    [self updateCompletedButton:dayInfo.completed];
}

-(IBAction)intensityChanged:(id)sender {
    // Is the CardioView dictionary set up?
    if ([dayInfo.cardio count] == 0) {
        if (!dayInfo.completed) {
            dayInfo.completed = YES;
        }
    }
    // Save change
    UIButton *btn = (UIButton *)sender;
    if (btn == steadyButton) {
        [steadyButton setSelected:YES];
        [intenseButton setSelected:NO];
        [dayInfo.cardio setValue:@"1" forKey:@"CardioIntensity"];
    } else {
        [steadyButton setSelected:NO];
        [intenseButton setSelected:YES];
        [dayInfo.cardio setValue:@"2" forKey:@"CardioIntensity"];
    }
}

-(IBAction)setDuration {
    // Is the CardioView dictionary set up?
    if ([dayInfo.cardio count] == 0) {
        if (!dayInfo.completed) {
            dayInfo.completed = YES;
        }
    }
    // Save change
    int hour = [picker selectedRowInComponent:0];
    int minute = [picker selectedRowInComponent:1];
    [dayInfo.cardio setValue:[NSString stringWithFormat:@"%d", hour] forKey:@"Hours"];
    [dayInfo.cardio setValue:[NSString stringWithFormat:@"%d", minute] forKey:@"Minutes"];
    // Set label
    duration.text = [NSString stringWithFormat:@"%d hour %d min", hour, minute];
}

-(IBAction)resetClicked {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reset Confirmation" message:@"Do you really want to reset all entered data?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
    [alert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSMutableDictionary *dic = dayInfo.cardio;
        dayInfo.cardio = nil;
        [dic removeAllObjects];
        [self closeView];
    }
}

@end
