//
//  FlipsideViewController.m
//  90DayFitness
//
//  Created by Bruce Green on 6/19/09.
//  Copyright Stylographix 2009. All rights reserved.
//

#import "FlipsideViewController.h"
#import "_0DayFitnessAppDelegate.h"

@implementation FlipsideViewController

@synthesize delegate;

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
}

-(void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}

-(void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Helper Methods
-(IBAction)done {
	[self.delegate flipsideViewControllerDidFinish:self];	
}

-(IBAction)reset {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"This will clear all your data. Are you sure?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	[alert show];
	[alert release];
}

#pragma mark -
#pragma mark UIAlertView Delegate Methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		// Actually reset data
		_0DayFitnessAppDelegate *app = (_0DayFitnessAppDelegate *) [UIApplication sharedApplication].delegate;
		[app resetData];
		// Send out notification
		[[NSNotificationCenter defaultCenter] postNotificationName:@"CalendarDataReset" object:self];
	}
}
@end
