//
//  _0DayFitnessAppDelegate.m
//  90DayFitness
//
//  Created by Bruce Green on 6/19/09.
//  Copyright Stylographix 2009. All rights reserved.
//

#import "_0DayFitnessAppDelegate.h"
#import "MainViewController.h"

@implementation _0DayFitnessAppDelegate

@synthesize window;
@synthesize mainViewController;
@synthesize dayCopy;
@synthesize mainMenuViewController;

-(void)applicationDidFinishLaunching:(UIApplication *)application {
    // Load archived array from saved settings
    NSArray *archived = [[NSUserDefaults standardUserDefaults] objectForKey:@"DayInformation"];
    // Now load it (if not empty) into selectionArray
    if (archived == nil) {
		BOOL done = [[NSUserDefaults standardUserDefaults] boolForKey:@"DataInitialized"];
		if (!done) {
			// Set up defaults
			for (int i=0; i<84; i++) {
				CalendarDay *day = [[CalendarDay alloc] init];
				day.day = i;
				day.completed = NO;
				day.dayType = kDayTypeNone;
				[day save];
				[day release];
			}
			[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"DataInitialized"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
    } else {
        // Unarchive each array element and load into selectionArray
		NSString *done = [[NSUserDefaults standardUserDefaults] objectForKey:@"ConversionDone"];
		if (done == nil) {
			DayInfo *day;
			int i = 0;
			for (NSData *data in archived) {
				day = (DayInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
				CalendarDay *d = [[CalendarDay alloc] init];
				d.day = i;
				d.dayType = day.dayType;
				d.completed = day.completed;
				d.chest = day.chest;
				d.biceps = day.biceps;
				d.shoulders = day.shoulders;
				d.triceps = day.triceps;
				d.back = day.back;
				d.forearms = day.forearms;
				d.abs = day.abs;
				d.quadriceps = day.quadriceps;
				d.hamstrings = day.hamstrings;
				d.calves = day.calves;
				d.other = day.other;
				d.cardio = day.cardio;
				[d save];
				[d release];
				i++;
			}
			[[NSUserDefaults standardUserDefaults] setValue:@"Y" forKey:@"ConversionDone"];
			[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"DataInitialized"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
    }
    // Now load the main view
//    MainViewController *aController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
//    self.mainViewController = aController;
    
    MainMenuViewController *aController = [[MainMenuViewController alloc] initWithNibName:@"MainMenuView" bundle:nil];
    self.mainMenuViewController = aController;
    
    mainMenuViewController.view.frame = [UIScreen mainScreen].applicationFrame;
    [window addSubview:[mainMenuViewController view]];
    [window makeKeyAndVisible];
}

-(void)applicationWillTerminate:(UIApplication *)application {
    // Any clean up code?
}

-(void)dealloc {
    [mainViewController release];
    [window release];
	[dayCopy release];
    [super dealloc];
}

#pragma mark -
#pragma mark Helper Methods
-(void)resetData {
	// Set up defaults
	NSString *where;
	for (int i=0; i<84; i++) {
		where = [NSString stringWithFormat:@"WHERE day=%d", i];
		CalendarDay *day = (CalendarDay *)[CalendarDay findFirstByCriteria:where];
		day.completed = NO;
		day.dayType = kDayTypeNone;
		day.chest = nil;
		day.biceps = nil;
		day.shoulders = nil;
		day.triceps = nil;
		day.back = nil;
		day.forearms = nil;
		day.abs = nil;
		day.quadriceps = nil;
		day.hamstrings = nil;
		day.calves = nil;
		day.other = nil;
		day.cardio = nil;
		[day save];
	}
}

@end
