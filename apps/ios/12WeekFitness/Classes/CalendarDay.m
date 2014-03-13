//
//  CalendarDay.m
//  90DayFitness
//
//  Created by Bruce Green on 7/2/09.
//  Copyright 2009 Stylographix. All rights reserved.
//

#import "CalendarDay.h"

@implementation CalendarDay

@synthesize day;
@synthesize dayType;
@synthesize completed;
@synthesize chest;
@synthesize biceps;
@synthesize shoulders;
@synthesize triceps;
@synthesize back;
@synthesize forearms;
@synthesize abs;
@synthesize quadriceps;
@synthesize hamstrings;
@synthesize calves;
@synthesize other;
@synthesize cardio;

-(id)init {
	self = [super init];
	if (self != nil) {
		chest = [[NSMutableDictionary alloc] init];
		biceps = [[NSMutableDictionary alloc] init];
		shoulders = [[NSMutableDictionary alloc] init];
		triceps = [[NSMutableDictionary alloc] init];
		back = [[NSMutableDictionary alloc] init];
		forearms = [[NSMutableDictionary alloc] init];
		abs = [[NSMutableDictionary alloc] init];
		quadriceps = [[NSMutableDictionary alloc] init];
		hamstrings = [[NSMutableDictionary alloc] init];
		calves = [[NSMutableDictionary alloc] init];
		other = [[NSMutableDictionary alloc] init];
		cardio = [[NSMutableDictionary alloc] init];
	}
	return self;
}

-(void)dealloc {
	[chest release];
	[biceps release];
	[shoulders release];
	[triceps release];
	[back release];
	[forearms release];
	[abs release];
	[quadriceps release];
	[hamstrings release];
	[calves release];
	[other release];
	[cardio release];
	[super dealloc];
}

@end
