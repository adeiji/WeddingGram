//
//  ExerciseViewCell.m
//  90DayFitness
//
//  Created by Bruce Green on 7/1/09.
//  Copyright 2009 Stylographix. All rights reserved.
//

#import "ExerciseViewCell.h"

@implementation ExerciseViewCell

@synthesize exercise;
@synthesize reps;
@synthesize weight;
@synthesize intensity;
@synthesize data;

-(id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setData:(NSMutableDictionary *)value {
    data = value;
    exercise.text = [data valueForKey:@"Exercise"];
    reps.text = [data valueForKey:@"Reps"];
    weight.text = [data valueForKey:@"Weight"];
    intensity.text = [data valueForKey:@"Intensity"];
}

-(void)dealloc {
	[exercise release];
    [reps release];
	[weight release];
	[intensity release];
	[data release];
    [super dealloc];
}

#pragma mark -
#pragma mark Helper methods
-(IBAction)showPresets {
	NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:self, @"Cell", nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ShowPresets" object:self userInfo:info];
}

#pragma mark -
#pragma mark UITextField Delegate Methods
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField == exercise) {
        [data setValue:textField.text forKey:@"Exercise"];
    } else if (textField == reps) {
        [data setValue:textField.text forKey:@"Reps"];
    } else if (textField == weight) {
        [data setValue:textField.text forKey:@"Weight"];
    } else if (textField == intensity) {
        [data setValue:textField.text forKey:@"Intensity"];
    }
    return YES;
} 

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    // Get parent
    UITableView *tableView = (UITableView *)self.superview;
    screenScrolled = NO;
    // Get row count
    int rows = [tableView numberOfRowsInSection:0];
    // Is row count greater than 4?
    if (rows > 4) {
        // What's the selected row?
        NSIndexPath *path = [tableView indexPathForCell:self];
        if (path.row > (rows-2)) {
            // Scroll the entire view up
            screenScrolled = YES;
            // Editing began, now scroll screen up
            CGRect viewFrame = tableView.superview.frame;
            viewFrame.origin.y -= 160;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.3];
            [tableView.superview setFrame:viewFrame];
            [UIView commitAnimations];
            return;
        }
    }
    // Scroll current cell into view
    UITableViewCell *cell = (UITableViewCell*)self;
    [tableView scrollToRowAtIndexPath:[tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    // Did we scroll the screen up?
    if (screenScrolled) {
        // Remove editing flag
        screenScrolled = NO;
        // Get parent
        UITableView *tableView = (UITableView *)self.superview;
        // Editing ended, now scroll screen down
        CGRect viewFrame = tableView.superview.frame;
        viewFrame.origin.y += 160;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        [tableView.superview setFrame:viewFrame];
        [UIView commitAnimations];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {    
    [textField resignFirstResponder];
    return YES;    
}

@end
