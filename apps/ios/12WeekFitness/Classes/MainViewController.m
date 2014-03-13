//
//  MainViewController.m
//  90DayFitness
//
//  Created by Bruce Green on 6/19/09.
//  Copyright Stylographix 2009. All rights reserved.
//

#import "MainViewController.h"
#import "BodyViewController.h"
#import "CardioViewController.h"

@implementation MainViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    app = (_0DayFitnessAppDelegate *)[UIApplication sharedApplication].delegate;
	// Create buttons
	buttonArray = [[NSMutableArray alloc] init];
	for (int i=0; i<84; i++) {
		DayView *btn = [[DayView alloc] initWithIndex:i];
		// Set up button action
		[btn.button addTarget:self action:@selector(dayClicked:) forControlEvents:UIControlEventTouchUpInside];
		btn.button.tag = i;
		// Add to array
		[buttonArray addObject:btn];
		// Add to view
		[self.view addSubview:btn];
		[btn release];
	}
	// Notification observer
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayCalendar) name:@"CalendarDataReset" object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
	[self displayCalendar];
}

-(void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
	// Flip back
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:1.25];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	UIViewAnimationTransition transition;
	transition = UIViewAnimationTransitionFlipFromRight;
	[UIView setAnimationTransition:transition forView:self.view cache:YES];
	[controller.view removeFromSuperview];
	[UIView commitAnimations];
	// Release view controller
	[controller release];
}

-(IBAction)showInfo {    
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	// Flip view
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:1.25];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	UIViewAnimationTransition transition;
	transition = UIViewAnimationTransitionFlipFromLeft;
	[UIView setAnimationTransition: transition forView:self.view cache:YES];
	[self.view addSubview:controller.view];
	[UIView commitAnimations];
}

-(void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}


-(void)viewDidUnload {
	// Remove observers
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Helper Methods
-(IBAction)dayClicked:(id)sender{
    UIButton *btn = (UIButton *)sender;
    SelectionViewController *svc = [[SelectionViewController alloc] initWithNibName:@"SelectionView" bundle:nil];
	svc.delegate = self;
	svc.button = btn;
    [self.view addSubview:svc.view];
}

-(void)displayCalendar {
	CalendarDay *day;
	NSString *where;
	DayView *btn;
	BOOL check;
    // Set selection status for each of the buttons baesd on array values
	for (int i=0; i<84; i++) {
		where = [NSString stringWithFormat:@"WHERE day=%d", i];
		day = (CalendarDay *)[CalendarDay findFirstByCriteria:where];
		[self setupDayView:i with:day];
		btn = [buttonArray objectAtIndex:i];
        check = day.completed;
		[btn.button setSelected:check];
	}
}

-(void)closeSelectionViewController:(SelectionViewController *)svc {
    // Get action
    int action = svc.actionType;
    UIButton *btn = svc.button;
    int index = btn.tag;
    // Remove menu
    [svc.view removeFromSuperview];
    [svc release];
	// Get day info for seleciton
	NSString *where = [NSString stringWithFormat:@"WHERE day=%d", index];
	CalendarDay *info = (CalendarDay *)[CalendarDay findFirstByCriteria:where];
    // Act upon action
    switch (action) {
        case kUpperBodyView:
        case kLowerBodyView:
		{
			BodyViewController *body = [[BodyViewController alloc] initWithNibName:@"BodyView" bundle:nil];
			if (action == kUpperBodyView) {
				info.dayType = kDayTypeUpperBody;
			} else {
				info.dayType = kDayTypeLowerBody;
			}
			[info save];
			body.day = index;
			[self presentModalViewController:body animated:YES];
			[body release];
		}
            break;
            
        case kCardioView:
        {
            CardioViewController *cardio = [[CardioViewController alloc] initWithNibName:@"CardioView" bundle:nil];
			info.dayType = kDayTypeCardio;
			[info save];
            cardio.day = index;
            [self presentModalViewController:cardio animated:YES];
            [cardio release];
        }
            break;
            
        case kFreeDay:
        {
			info.dayType = kDayTypeFree;
            info.completed = !info.completed;
			[info save];
			// Set up button
            [btn setSelected:info.completed];
        }
            break;
			
		case kCopyDay:
			if (app.dayCopy != nil) {
				[app.dayCopy release];
				app.dayCopy = nil;
			}
			app.dayCopy = info;
			break;
			
		case kPasteDay:
		{	
			if (app.dayCopy == nil) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No copied data! First copy a day and then paste." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release];
			} else {
				info = app.dayCopy;
				where = [NSString stringWithFormat:@"WHERE day=%d", index];
				CalendarDay *d = (CalendarDay *)[CalendarDay findFirstByCriteria:where];
				d.dayType = info.dayType;
				d.completed = info.completed;
				[self copyData:info.chest to:d.chest];
				[self copyData:info.biceps to:d.biceps];
				[self copyData:info.shoulders to:d.shoulders];
				[self copyData:info.triceps to:d.triceps];
				[self copyData:info.back to:d.back];
				[self copyData:info.forearms to:d.forearms];
				[self copyData:info.abs to:d.abs];
				[self copyData:info.quadriceps to:d.quadriceps];
				[self copyData:info.hamstrings to:d.hamstrings];
				[self copyData:info.calves to:d.calves];
				[self copyData:info.other to:d.other];
				[self copyData:info.cardio to:d.cardio];
				[d save];
				[d release];
				// Set up button
				[btn setSelected:info.completed];
			}
		}
			break;
    }
	// Set up day view changes
	[self setupDayView:index with:info];
}

-(void)setupDayView:(int)index with:(CalendarDay *)info {
	DayView *vw = [buttonArray objectAtIndex:index];
	int day;
	switch (info.dayType) {
		case kDayTypeUpperBody:
			vw.label.font = [UIFont systemFontOfSize:10];
			vw.label.textColor = [UIColor blackColor];
			vw.label.text = @"Upper Body";
			break;
			
		case kDayTypeLowerBody:
			vw.label.font = [UIFont systemFontOfSize:10];
			vw.label.textColor = [UIColor blackColor];
			vw.label.text = @"Lower Body";
			break;
			
		case kDayTypeCardio:
			vw.label.font = [UIFont systemFontOfSize:10];
			vw.label.textColor = [UIColor blackColor];
			vw.label.text = @"Cardio";
			break;
			
		case kDayTypeFree:
			vw.label.font = [UIFont boldSystemFontOfSize:10];
			vw.label.textColor = [UIColor colorWithRed:0.000 green:0.000 blue:1.000 alpha:1.000];
			vw.label.text = @"FREE Day";
			break;
		
		default:
			// Set default type, if none of the above
			day = index % 7;
			vw.label.font = [UIFont systemFontOfSize:10];
			vw.label.textColor = [UIColor blackColor];
			if (day == 0 || day == 4) {
				vw.label.text = @"Upper Body";
			} else if (day == 1 || day == 3 || day == 5) {
				vw.label.text = @"Cardio";
			} else if (day == 2) {
				vw.label.text = @"Lower Body";
			} else if (day == 6) {
				vw.label.font = [UIFont boldSystemFontOfSize:10];
				vw.label.textColor = [UIColor colorWithRed:0.000 green:0.000 blue:1.000 alpha:1.000];
				vw.label.text = @"FREE Day";
			}
			break;
	}
	// Is it a green or red check for the button?
	if (info.dayType == kDayTypeFree) {
		[vw.button setImage:[UIImage imageNamed:@"X2.png"] forState:UIControlStateSelected];
	} else {
		[vw.button setImage:[UIImage imageNamed:@"X1.png"] forState:UIControlStateSelected];
	}
}

-(void)copyData:(NSMutableDictionary *)d1 to:(NSMutableDictionary *)d2 {
	if (d2 != nil) {
		[d2 removeAllObjects];
	} else {
		d2 = [[NSMutableDictionary alloc] init];
	}
	// Iterate through all keys to add them to destination array
	for (NSString *key in [d1 allKeys]) {
		// Everything other than TableData is directly added
		if ([key isEqualToString:@"TableData"]) {
			NSMutableArray *a1 = [d1 objectForKey:key];
			NSMutableArray *a2 = [[NSMutableArray alloc] init];
			// Copy array items - all mutable dictionaries
			NSMutableDictionary *r2;
			for (NSMutableDictionary *r1 in a1) {
				r2 = [[NSMutableDictionary alloc] initWithDictionary:r1];
				[a2 addObject:r2];
			}
			[d2 setObject:a2 forKey:@"TableData"];
		} else {
			[d2 setObject:[d1 objectForKey:key] forKey:key];
		}
	}
}

@end
