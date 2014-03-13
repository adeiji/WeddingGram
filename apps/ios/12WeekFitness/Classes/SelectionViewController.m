//
//  SelectionViewController.m
//  90DayFitness
//
//  Created by Bruce Green on 8/3/09.
//  Copyright 2009 Stylographix. All rights reserved.
//

#import "SelectionViewController.h"

@implementation SelectionViewController

@synthesize delegate;
@synthesize actionType;
@synthesize button;

-(void)viewDidLoad {
    [super viewDidLoad];
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
	[button release];
    [super dealloc];
}

#pragma mark -
#pragma mark Helper Methods
-(IBAction)upperClicked {
	actionType = kUpperBodyView;
	[self closeView];
}

-(IBAction)lowerClicked {
	actionType = kLowerBodyView;
	[self closeView];
}

-(IBAction)cardioClicked {
	actionType = kCardioView;
	[self closeView];
}

-(IBAction)freeClicked {
	actionType = kFreeDay;
	[self closeView];
}

-(IBAction)cancelClicked {
	actionType = kCancel;
	[self closeView];
}

-(IBAction)copyDay {
	actionType = kCopyDay;
	[self closeView];
}

-(IBAction)pasteDay {
	actionType = kPasteDay;
	[self closeView];
}

-(void)closeView {
	// Close view
    if ([self.delegate respondsToSelector:@selector(closeSelectionViewController:)]) {
        [self.delegate closeSelectionViewController:self];
    }
}

@end
