//
//  PresetsViewController.m
//  90DayFitness
//
//  Created by Fahim Farook on 17/10/09.
//  Copyright 2009 Stylographix. All rights reserved.
//

#import "PresetsViewController.h"

@implementation PresetsViewController

@synthesize delegate;
@synthesize cell;

-(void)viewDidLoad {
    [super viewDidLoad];
	// Load data
	sections = [[NSMutableArray alloc] init];
	data = [[NSMutableArray alloc] init];
	NSDictionary *d = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"presets" ofType:@"plist"]];
	for (NSString *row in d) {
		[sections addObject:row];
		[data addObject:[d objectForKey:row]];
	}
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
	[sections release];
	[data release];
	[cell release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableView Delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [sections count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSArray *row = [data objectAtIndex:section];
	return [row count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [sections objectAtIndex:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *c = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (c == nil) {
        c = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	// Configure the cell
	NSArray *row = [data objectAtIndex:indexPath.section];
	c.textLabel.text = [row objectAtIndex:indexPath.row];
    return c;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSArray *row = [data objectAtIndex:indexPath.section];
	// Set field
	cell.exercise.text = [row objectAtIndex:indexPath.row];
	[cell.data setObject:cell.exercise.text forKey:@"Exercise"];
	[self closeView];
}

#pragma mark -
#pragma mark Helper Methods
-(IBAction)closeView {
	// Close view
    if ([self.delegate respondsToSelector:@selector(closePresetsViewController:)]) {
        [self.delegate closePresetsViewController:self];
    }
}

@end
