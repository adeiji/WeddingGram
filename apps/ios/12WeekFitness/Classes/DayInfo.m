//
//  DayInfo.m
//  90DayFitness
//
//  Created by Bruce Green on 7/2/09.
//  Copyright 2009 Stylographix. All rights reserved.
//

#import "DayInfo.h"


@implementation DayInfo

@synthesize completed;
@synthesize dayType;
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

-(id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.completed = [coder decodeBoolForKey:@"Completed"];
        self.dayType = [coder decodeIntForKey:@"DayType"];
        self.chest = [coder decodeObjectForKey:@"Chest"];
        self.biceps = [coder decodeObjectForKey:@"Biceps"];
        self.shoulders = [coder decodeObjectForKey:@"Shoulders"];
        self.triceps = [coder decodeObjectForKey:@"Triceps"];
        self.back = [coder decodeObjectForKey:@"Back"];
        self.forearms = [coder decodeObjectForKey:@"Forearms"];
        self.abs = [coder decodeObjectForKey:@"Abs"];
        self.quadriceps = [coder decodeObjectForKey:@"Quadriceps"];
        self.hamstrings = [coder decodeObjectForKey:@"Hamstrings"];
        self.calves = [coder decodeObjectForKey:@"Calves"];
        self.other = [coder decodeObjectForKey:@"Other"];
        self.cardio = [coder decodeObjectForKey:@"Cardio"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeBool:completed forKey:@"Completed"];
    [coder encodeInt:dayType forKey:@"DayType"];
    [coder encodeObject:chest forKey:@"Chest"];
    [coder encodeObject:biceps forKey:@"Biceps"];
    [coder encodeObject:shoulders forKey:@"Shoulders"];
    [coder encodeObject:triceps forKey:@"Triceps"];
    [coder encodeObject:back forKey:@"Back"];
    [coder encodeObject:forearms forKey:@"Forearms"];
    [coder encodeObject:abs forKey:@"Abs"];
    [coder encodeObject:quadriceps forKey:@"Quadriceps"];
    [coder encodeObject:hamstrings forKey:@"Hamstrings"];
    [coder encodeObject:calves forKey:@"Calves"];
    [coder encodeObject:other forKey:@"Other"];
    [coder encodeObject:cardio forKey:@"Cardio"];
}

-(DayInfo *)copy {
	DayInfo *copy = [[DayInfo alloc] init];
	copy.completed = self.completed;
	copy.dayType = self.dayType;
	copy.chest = [self copyDictionary:self.chest];
	if (self.biceps != nil) {
		copy.biceps = [[NSMutableDictionary alloc] initWithDictionary:self.biceps];
	}
	if (self.shoulders != nil) {
		copy.shoulders = [[NSMutableDictionary alloc] initWithDictionary:self.shoulders];
	}
	if (self.triceps != nil) {
		copy.triceps = [[NSMutableDictionary alloc] initWithDictionary:self.triceps];
	}
	if (self.back != nil) {
		copy.back = [[NSMutableDictionary alloc] initWithDictionary:self.back];
	}
	if (self.forearms != nil) {
		copy.forearms = [[NSMutableDictionary alloc] initWithDictionary:self.forearms];
	}
	if (self.abs != nil) {
		copy.abs = [[NSMutableDictionary alloc] initWithDictionary:self.abs];
	}
	if (self.quadriceps != nil) {
		copy.quadriceps = [[NSMutableDictionary alloc] initWithDictionary:self.quadriceps];
	}
	if (self.hamstrings != nil) {
		copy.hamstrings = [[NSMutableDictionary alloc] initWithDictionary:self.hamstrings];
	}
	if (self.calves != nil) {
		copy.calves = [[NSMutableDictionary alloc] initWithDictionary:self.calves];
	}
	if (self.other != nil) {
		copy.other = [[NSMutableDictionary alloc] initWithDictionary:self.other];
	}
	if (self.cardio != nil) {
		copy.cardio = [[NSMutableDictionary alloc] initWithDictionary:self.cardio];
	}
	return copy;
}

-(NSMutableDictionary *)copyDictionary:(NSMutableDictionary *)original {
	if (original == nil) {
		return nil;
	}
	NSMutableDictionary *copy = [[NSMutableDictionary alloc] init];
	for (id key in original) {
		[copy setObject:[original objectForKey:key] forKey:key];
	}
	return copy;
}


@end
