//
//  PresetsViewController.h
//  90DayFitness
//
//  Created by Fahim Farook on 17/10/09.
//  Copyright 2009 Stylographix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseViewCell.h"

@protocol PresetsViewControllerDelegate;

@interface PresetsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	id<PresetsViewControllerDelegate> delegate;
	IBOutlet UITableView *table;
	NSMutableArray *sections;
	NSMutableArray *data;
	ExerciseViewCell *cell;
}

@property (assign) id<PresetsViewControllerDelegate> delegate;
@property (nonatomic, retain) ExerciseViewCell *cell;

-(IBAction)closeView;

@end

@protocol PresetsViewControllerDelegate <NSObject>

-(void)closePresetsViewController:(PresetsViewController *)controller;

@end