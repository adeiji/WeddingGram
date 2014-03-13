//
//  ExerciseViewCell.h
//  90DayFitness
//
//  Created by Bruce Green on 7/1/09.
//  Copyright 2009 Stylographix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseViewCell : UITableViewCell <UITextFieldDelegate> {
	NSMutableDictionary *data;
    UITextField *exercise;
    UITextField *reps;
    UITextField *weight;
    UITextField *intensity;
	BOOL screenScrolled;
}

@property (nonatomic, retain) IBOutlet UITextField *exercise;
@property (nonatomic, retain) IBOutlet UITextField *reps;
@property (nonatomic, retain) IBOutlet UITextField *weight;
@property (nonatomic, retain) IBOutlet UITextField *intensity;
@property (nonatomic, retain) NSMutableDictionary *data;

-(IBAction)showPresets;

@end
