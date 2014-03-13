//
//  DayView.m
//  90DayFitness
//
//  Created by Fahim Farook on 12/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DayView.h"

@implementation DayView

@synthesize label;
@synthesize button;

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

-(id)initWithIndex:(int)index {
	// row
	int row = index / 7;
	// column
	int col = index % 7;
	// x
	int x = 31;
	x = x + (42 * col);
	// y
	int y = 40;
	y = y + (35 * row);
	if (self = [super initWithFrame:CGRectMake(x, y, 38, 33)]) {
		// Add label
		label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 38, 33)];
		label.numberOfLines = 2;
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		// Seventh day is bold and blue
		if (col == 6) {
			label.font = [UIFont boldSystemFontOfSize:10];
			label.textColor = [UIColor colorWithRed:0.000 green:0.000 blue:1.000 alpha:1.000];
		} else {
			label.font = [UIFont systemFontOfSize:10];
		}
		// Default label text
		if (col == 0 || col == 4) {
			label.text = @"Upper Body";
		} else if (col == 1 || col == 3 || col == 5) {
			label.text = @"Cardio";
		} else if (col == 2) {
			label.text = @"Lower Body";
		} else {
			label.text = @"FREE Day";
		}
		[self addSubview:label];
		// Add button
		button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(0, 0, 38, 33);
		[self addSubview:button];
	}
	return self;
}

/*
-(void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)dealloc {
	[button release];
	[label release];
    [super dealloc];
}

@end
