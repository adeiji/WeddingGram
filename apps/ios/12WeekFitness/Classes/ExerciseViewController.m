//
//  ExerciseViewController.m
//  90DayFitness
//
//  Created by Bruce Green on 6/29/09.
//  Copyright 2009 Stylographix. All rights reserved.
//

#import "ExerciseViewController.h"
#import "BodyViewController.h"

@implementation ExerciseViewController

@synthesize buttonClicked;
@synthesize dayInfo;
@synthesize exerciseCell;

-(void)viewDidLoad {
    [super viewDidLoad];
    // Set view title and Notes based on button clicked
    NSMutableDictionary *dic;
    switch (buttonClicked) {
        case kChest:
            navItem.title = @"Chest";
            dic = dayInfo.chest;
            break;
            
        case kBiceps:
            navItem.title = @"Biceps";
            dic = dayInfo.biceps;
            break;
            
        case kShoulders:
            navItem.title = @"Shoulders";
            dic = dayInfo.shoulders;
            break;
            
        case kTriceps:
            navItem.title = @"Triceps";
            dic = dayInfo.triceps;
            break;
            
        case kBack:
            navItem.title = @"Back";
            dic = dayInfo.back;
            break;
            
        case kForearms:
            navItem.title = @"Forearms";
            dic = dayInfo.forearms;
            break;
            
        case kAbs:
            navItem.title = @"Abs";
            dic = dayInfo.abs;
            break;
            
        case kQuadriceps:
            navItem.title = @"Quadriceps";
            dic = dayInfo.quadriceps;
            break;
            
        case kHamstrings:
            navItem.title = @"Hamstrings";
            dic = dayInfo.hamstrings;
            break;
            
        case kCalves:
            navItem.title = @"Calves";
            dic = dayInfo.calves;
            break;
            
        case kGluetals:
            navItem.title = @"Cardio";
            dic = dayInfo.cardio;
            break;
            
        case kOther:
            navItem.title = @"Other";
            dic = dayInfo.other;
            break;
    }
    if (dic != nil) {
        notes.text = [dic valueForKey:@"NoteText"];
    }
	// Add observers
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPresets:) name:@"ShowPresets" object:nil];
}

-(void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}

-(void)dealloc {
	// Remove presets
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	// Clean up
    [exerciseCell release];
    [dayInfo release];
    [super dealloc];
}

-(IBAction)closeView {
	// Close view
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

-(IBAction)addRow {
    NSMutableDictionary *dic;
    NSMutableArray *tableData;
    switch (buttonClicked) {
        case kChest:
            dic = dayInfo.chest;
            break;
            
        case kBiceps:
            dic = dayInfo.biceps;
            break;
            
        case kShoulders:
            dic = dayInfo.shoulders;
            break;
            
        case kTriceps:
            dic = dayInfo.triceps;
            break;
            
        case kBack:
            dic = dayInfo.back;
            break;
            
        case kForearms:
            dic = dayInfo.forearms;
            break;
            
        case kAbs:
            dic = dayInfo.abs;
            break;
            
        case kQuadriceps:
            dic = dayInfo.quadriceps;
            break;
            
        case kHamstrings:
            dic = dayInfo.hamstrings;
            break;
            
        case kCalves:
            dic = dayInfo.calves;
            break;
            
        case kGluetals:
            dic = dayInfo.cardio;
            break;
            
        case kOther:
            dic = dayInfo.other;
            break;
    }
    // We have the dictionary, so get table array
	if ([dic count] > 0) {
		tableData = [dic objectForKey:@"TableData"];
	} else {
		tableData = [self setupDictionary:dic];
	}
    // Create blank row
    NSMutableDictionary *row = [[NSMutableDictionary alloc] initWithCapacity:1];
    // Check table row selection
    NSIndexPath *selection = [tableView indexPathForSelectedRow];
    if (selection == nil) {
        // Add exercise, reps, weight, intensity default values
        [row setObject:@"" forKey:@"Exercise"];
        [row setObject:@"0" forKey:@"Reps"];
        [row setObject:@"0" forKey:@"Weight"];
        [row setObject:@"1" forKey:@"Intensity"];
    } else {
        // Duplicate selected row values
        NSMutableDictionary *sel = [tableData objectAtIndex:selection.row];
        [row setObject:[sel objectForKey:@"Exercise"] forKey:@"Exercise"];
        [row setObject:[sel objectForKey:@"Reps"] forKey:@"Reps"];
        [row setObject:[sel objectForKey:@"Weight"] forKey:@"Weight"];
        [row setObject:[sel objectForKey:@"Intensity"] forKey:@"Intensity"];
    }
    // Insert row into table
    [tableData addObject:row];
    // Insert row into tableview
    [tableView reloadData];
}

-(IBAction)resetClicked {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reset Confirmation" message:@"Do you really want to reset all entered data?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
    [alert release];
}

-(IBAction)editClicked {
    if (tableView.editing) {
        [tableView setEditing:NO animated:YES];
    } else {
        [tableView setEditing:YES animated:YES];
    }
}

-(NSMutableArray *)setupDictionary:(NSMutableDictionary *)dic {
    // Is this day complete?
    if (!dayInfo.completed) {
        if ([dayInfo.chest count] == 0 && [dayInfo.biceps count] == 0 && [dayInfo.shoulders count] == 0 && [dayInfo.triceps count] == 0 && [dayInfo.back count] == 0 && [dayInfo.forearms count] == 0 && [dayInfo.abs count] == 0 && [dayInfo.quadriceps count] == 0 && [dayInfo.hamstrings count] == 0 && [dayInfo.calves count] == 0 && [dayInfo.cardio count] == 0 && [dayInfo.other count] == 0) {
            dayInfo.completed = YES;
        }
    }
    // Create table array
    NSMutableArray *tableData = [[NSMutableArray alloc] initWithCapacity:1];
    [dic setObject:tableData forKey:@"TableData"];
    return tableData;
}

-(void)showPresets:(NSNotification *)info {
	PresetsViewController *pvc = [[PresetsViewController alloc] initWithNibName:@"PresetsView" bundle:nil];
	pvc.delegate = self;
	pvc.cell = [[info userInfo] objectForKey:@"Cell"];
	[self presentModalViewController:pvc animated:YES];
}

-(void)saveNote {
}

#pragma mark -
#pragma mark UITableView Delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic;
    switch (buttonClicked) {
        case kChest:
            dic = dayInfo.chest;
            break;
            
        case kBiceps:
            dic = dayInfo.biceps;
            break;
            
        case kShoulders:
            dic = dayInfo.shoulders;
            break;
            
        case kTriceps:
            dic = dayInfo.triceps;
            break;
            
        case kBack:
            dic = dayInfo.back;
            break;
            
        case kForearms:
            dic = dayInfo.forearms;
            break;
            
        case kAbs:
            dic = dayInfo.abs;
            break;
            
        case kQuadriceps:
            dic = dayInfo.quadriceps;
            break;
            
        case kHamstrings:
            dic = dayInfo.hamstrings;
            break;
            
        case kCalves:
            dic = dayInfo.calves;
            break;
            
        case kGluetals:
            dic = dayInfo.cardio;
            break;
            
        case kOther:
            dic = dayInfo.other;
            break;
    }
    if ([dic count] == 0) {
        // We don't have any saved data for this type
        return 0;
    } else {
        NSArray *tableData = [dic objectForKey:@"TableData"];
        return [tableData count];
    }
    return 0;
}

// Customize the appearance of table view cells.
-(UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get data
    NSMutableDictionary *dic;
    switch (buttonClicked) {
        case kChest:
            dic = dayInfo.chest;
            break;
            
        case kBiceps:
            dic = dayInfo.biceps;
            break;
            
        case kShoulders:
            dic = dayInfo.shoulders;
            break;
            
        case kTriceps:
            dic = dayInfo.triceps;
            break;
            
        case kBack:
            dic = dayInfo.back;
            break;
            
        case kForearms:
            dic = dayInfo.forearms;
            break;
            
        case kAbs:
            dic = dayInfo.abs;
            break;
            
        case kQuadriceps:
            dic = dayInfo.quadriceps;
            break;
            
        case kHamstrings:
            dic = dayInfo.hamstrings;
            break;
            
        case kCalves:
            dic = dayInfo.calves;
            break;
            
        case kGluetals:
            dic = dayInfo.cardio;
            break;
            
        case kOther:
            dic = dayInfo.other;
            break;
    }
    NSMutableArray *tableData = [dic objectForKey:@"TableData"];
	NSMutableDictionary *row = [tableData objectAtIndex:indexPath.row];
//    NSMutableDictionary *row = [NSMutableDictionary dictionaryWithDictionary: [tableData objectAtIndex:indexPath.row]];
    // Load data into cell
    static NSString *CellIdentifier = @"ExerciseCell";
    ExerciseViewCell *cell = (ExerciseViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"ExerciseViewCell" owner:self options:nil];
        cell = exerciseCell;
        self.exerciseCell = nil;
    }
    // Set up the cell
    cell.data = row;
    return cell;
}

-(void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete from data source
        NSMutableDictionary *dic;
        switch (buttonClicked) {
            case kChest:
                dic = dayInfo.chest;
                break;
                
            case kBiceps:
                dic = dayInfo.biceps;
                break;
                
            case kShoulders:
                dic = dayInfo.shoulders;
                break;
                
            case kTriceps:
                dic = dayInfo.triceps;
                break;
                
            case kBack:
                dic = dayInfo.back;
                break;
                
            case kForearms:
                dic = dayInfo.forearms;
                break;
                
            case kAbs:
                dic = dayInfo.abs;
                break;
                
            case kQuadriceps:
                dic = dayInfo.quadriceps;
                break;
                
            case kHamstrings:
                dic = dayInfo.hamstrings;
                break;
                
            case kCalves:
                dic = dayInfo.calves;
                break;
                
            case kGluetals:
                dic = dayInfo.cardio;
                break;
                
            case kOther:
                dic = dayInfo.other;
                break;
        }
        NSMutableArray *tableData = [dic objectForKey:@"TableData"];
        [tableData removeObjectAtIndex:indexPath.row];
        // Update table
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

#pragma mark -
#pragma mark UITextView Delegates
-(void)textViewDidBeginEditing:(UITextView *)textView {
    // Set editing flag
    editingNotes = YES;
    // Editing began on Notes, now scroll screen up
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= 160;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

-(void)textViewDidEndEditing:(UITextView *)textView {
	// Remove editing flag
    editingNotes = NO;
    // Editing ended on Notes, now scroll screen down
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += 160;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    // Now save the Notes value to the right body part
    NSMutableDictionary *dic;
    switch (buttonClicked) {
        case kChest:
            dic = dayInfo.chest;
            break;
            
        case kBiceps:
            dic = dayInfo.biceps;
            break;
            
        case kShoulders:
            dic = dayInfo.shoulders;
            break;
            
        case kTriceps:
            dic = dayInfo.triceps;
            break;
            
        case kBack:
            dic = dayInfo.back;
            break;
            
        case kForearms:
            dic = dayInfo.forearms;
            break;
            
        case kAbs:
            dic = dayInfo.abs;
            break;
            
        case kQuadriceps:
            dic = dayInfo.quadriceps;
            break;
            
        case kHamstrings:
            dic = dayInfo.hamstrings;
            break;
            
        case kCalves:
            dic = dayInfo.calves;
            break;
            
        case kGluetals:
            dic = dayInfo.cardio;
            break;
            
        case kOther:
            dic = dayInfo.other;
            break;
    }
	// Do we need to initialize dictionary?
	if ([dic count] == 0) {
		[self setupDictionary:dic];
	}
    // We have the dictionary, save the data
    [dic setValue:notes.text forKey:@"NoteText"];
}

#pragma mark -
#pragma mark UIAlertView Delegates
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        switch (buttonClicked) {
            case kChest:
				[dayInfo.chest removeAllObjects];
                break;
                
            case kBiceps:
                [dayInfo.biceps removeAllObjects];
                break;
                
            case kShoulders:
                [dayInfo.shoulders removeAllObjects];
                break;
                
            case kTriceps:
                [dayInfo.triceps removeAllObjects];
                break;
                
            case kBack:
                [dayInfo.back removeAllObjects];
                break;
                
            case kForearms:
                [dayInfo.forearms removeAllObjects];
                break;
                
            case kAbs:
                [dayInfo.abs removeAllObjects];
                break;
                
            case kQuadriceps:
                [dayInfo.quadriceps removeAllObjects];
                break;
                
            case kHamstrings:
                [dayInfo.hamstrings removeAllObjects];
                break;
                
            case kCalves:
                [dayInfo.calves removeAllObjects];
                break;
                
            case kGluetals:
                [dayInfo.cardio removeAllObjects];
                break;
                
            case kOther:
                [dayInfo.other removeAllObjects];
                break;
        }
		[dayInfo save];
		[self closeView];
    }
}

#pragma mark -
#pragma mark Touch Handling
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([[event touchesForView:back1] count] > 0 || [[event touchesForView:back2] count] > 0) {
        // We got a hit on the background, retract keyboard for notes field
        if (editingNotes) {
            [notes resignFirstResponder];
        }
    }
}

#pragma mark -
#pragma mark PresetsViewController Delegate Methods
-(void)closePresetsViewController:(PresetsViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
	// Release view controller
	[controller release];
}

@end
